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

### Set tuning space -----------------------------------------------------------#

# instead of using a default tuning space from {mlr3tuningspaces}, we define a
# search space manually

search_space = ps(
  mtry.ratio = p_dbl(0.2, 1),
  num.trees = p_int(10, 50)
)
rsmp_cv = rsmp("cv", folds = 5)
msr_rmse = msr("regr.rmse")

lrn_rf_at = AutoTuner$new(
  learner = lrn_rf,
  resampling = rsmp_cv,
  measure = msr_rmse,
  search_space = search_space,
  terminator = trm("run_time", secs = 6),
  tuner = tnr("random_search"),
  store_tuning_instance = TRUE
)

# lrn_rf_at = auto_tuner(
#   learner = lrn_rf,
#   measure = msr_rmse,
#   method = "random_search",
#   search_space = search_space,
#   resampling = rsmp_cv, # inner CV loop
#   term_time = 5, # seconds
#   store_models = TRUE
# )

### Resampling (Cross-validation) ---------------------------------------------#

rsmp_cv_out = rsmp("repeated_cv", folds = 5, repeats = 3) # outer CV loop

# parallelization
future::plan("multisession", workers = 2)

progressr::with_progress({
  # ResampleResult
  rr = resample(task_mtcars, lrn_rf_at, rsmp_cv_out, store_models = TRUE)
})

rr$aggregate()
as.data.table(rr)

### Visualize -----------------------------------------------------------------#

# how did the tuning go?
autoplot(rr$learners[[1]]$tuning_instance)

# Result: best param set of each outer training set (5 folds * 3 reps = 15)
# These params were used to train the respective learner in the outer loop
tuning_r = extract_inner_tuning_results(rr)
tuning_r

# All train/predict results from the entire resample() call
tuning_a = extract_inner_tuning_archives(rr)
tuning_a
