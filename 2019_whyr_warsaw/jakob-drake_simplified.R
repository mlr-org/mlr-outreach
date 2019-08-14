library("mlr3", quietly = TRUE)
library("paradox")
library("mlr3tuning")
library("mlr3learners")
library("callr")
library("drake")
suppressPackageStartupMessages(library("R.utils", quietly = TRUE))

# parameter sets
plan_parsets = drake_plan(
  kknn_ps = target({
    ps = ParamSet$new(params = list(
      ParamInt$new("k", lower = 10, upper = 50),
      ParamDbl$new("distance", lower = 1, upper = 50)
    ))
    ps$set_id = "kknn1"
    return(ps)
  }),
  svm_ps = target ({
    ps = ParamSet$new(params = list(
      ParamDbl$new("cost", lower = -5, upper = 5),
      ParamDbl$new("gamma", lower = -5, upper = 3)
    ))
    ps$trafo = function(x, param_set) {
      x$cost = 2^x$cost
      x$gamma = 2^x$gamma
      return(x)
    }
    ps$set_id = "svm1"
    return(ps)
  }
  ),
)

# resampling objects (do they have to be in a plan? i dont think so)
plan_resampling = drake_plan(
  resampling_inner = target(mlr_resamplings$get("cv3")),
  resampling_outer = target(mlr_resamplings$get("repeated_cv", param_vals = list(folds = 2, repeats = 1)))
)

plan_tuner = drake_plan(
  tuner = target(
    AutoTuner$new(
      learner = learner,
      resampling = resampling_inner,
      measures = "classif.ce",
      param_set = param_set,
      terminator = TerminatorEvaluations$new(3),
      tuner = TunerRandomSearch,
      id = param_set$set_id
    ),
    transform = map(
      learner = c("classif.kknn", "classif.svm"),
      param_set = c(kknn_ps, svm_ps)
    )
  )
)


my_benchmark_function = function(auto_tuner, task, resampling_outer) {
  auto_tuner$store_bmr = TRUE
  design = expand_grid(task, list(auto_tuner), resampling_outer)
  bm = benchmark(design)
  return(bm)
}

combine_benchmarks = function(...) {
  args = list(...)
  lapply(args[-1], args[[1]]$combine)
  args[[1]]
}

plan_benchmark = drake_plan(
  benchmark = target(
    my_benchmark_function(auto_tuner, task = task, resampling_outer = resampling_outer),
    
    transform = cross(
      auto_tuner = c(tuner_classif.svm_svm_ps, tuner_classif.kknn_kknn_ps), #FIXME get this automatically? plan_tuner$target has this values
      task = c("iris", "spam"),
      resampling_outer = resampling_outer
    )
  ),
  agg = target(
    combine_benchmarks(benchmark),
    transform = combine(benchmark)
  ),
)

plan = bind_plans(plan_parsets, plan_resampling, plan_tuner, plan_benchmark)

# Set the config ----------------------------------------------------------

config = drake_config(plan)

vis_drake_graph(config)

make(plan)

loadd(agg)
mlr3viz::autoplot(agg)
