library(mlr3verse)

### Create Task ---------------------------------------------------------------#
data("mtcars", package = "datasets")
task_mtcars = as_task_regr(mtcars, target = "mpg", id = "cars")

task_mtcars
task_mtcars$feature_names
task_mtcars$target_names

### Create Learner ------------------------------------------------------------#
lrn_rf = lrn("regr.ranger")
lrn_rf

lrn_rf$param_set
lrn_rf$model

### Tune ----------------------------------------------------------------------#

library(mlr3tuningspaces)

# important: this object the initial learner `lrn_rf` from above
# lts = load tuning space
lrn_rf_ts = lts("regr.ranger.default")
lrn_rf_ts
lrn_rf_ts$learner

# replace the learner from above with one that has a tuning space
lrn_rf = lrn_rf_ts$get_learner()
# note the "Parameters" part
lrn_rf


rsmp_cv = rsmp("cv")
rsmp_cv

msr_rmse = msr("regr.rmse")
msr_rmse

instance = tune(
  method = "random_search",
  task = task_mtcars,
  learner = lrn_rf,
  resampling = rsmp_cv,
  measure = msr_rmse,
  term_evals = 20
)

# progress bar
lgr::get_logger("mlr3")$set_threshold("warn")
lgr::get_logger("bbotk")$set_threshold("warn")
progressr::with_progress({
  instance = tune(
    method = "random_search",
    task = task_mtcars,
    learner = lrn_rf,
    resampling = rsmp_cv,
    measure = msr_rmse,
    term_evals = 20
  )
})

instance
instance$archive
instance$result_learner_param_vals # optimal pars

autoplot(instance)

as.data.table(tnrs())

### Train model with optimal hyperpars ----------------------------------------#
# set optimal hyerpars
lrn_rf$param_set$values = instance$result_learner_param_vals

# train model
lrn_rf$train(task_mtcars)

### Predict -------------------------------------------------------------------#

# we don't have newdata here, but if - then this would have been the final step
lrn_rf$predict_newdata(newdata)
