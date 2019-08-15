#' @title Combine mlr3 benchmark results
combine_benchmarks = function(...) {
  benchmarks = list(...)
  final_benchmark = benchmarks[[1]]$clone(deep = TRUE)
  for (i in tail(seq_along(benchmarks), -1)) {
    final_benchmark$combine(benchmarks[[i]])
  }
  return(final_benchmark)
}

#' @title Create a single mlr3 benchmark run including tuning
#' @description Creates an mlr3 learner which performs hyperparameter tuning in nested resampling
create_single_bm = function(learner, learner_id, task, measures,
  resampling_inner, resampling_outer, param_set,
  terminator) {

  task = task
  measures = measures
  learner = mlr_learners$get(learner)
  param_set = param_set
  terminator = terminator
  resampling_inner = resampling_inner

  # tuning
  at = AutoTuner$new(
    learner,
    resampling_inner,
    measures,
    param_set,
    terminator,
    tuner = TunerRandomSearch,
    id = learner_id
  )
  at$store_bmr = TRUE

  resampling_outer = resampling_outer
  design = expand_grid(task, list(at), resampling_outer)
  bm = benchmark(design)
  return(bm)
}
