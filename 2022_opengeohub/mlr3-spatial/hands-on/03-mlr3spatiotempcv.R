library("mlr3")
library("mlr3spatiotempcv")

lgr::get_logger("bbotk")$set_threshold("warn")
lgr::get_logger("mlr3")$set_threshold("warn")

set.seed(42) # reproducibility

### Load data and create task -------------------------------------------------#
data("ecuador", package = "mlr3spatiotempcv")
task = as_task_classif_st(ecuador, target = "slides", positive = "TRUE",
  coordinate_names = c("x", "y"), coords_as_features = FALSE,
  crs = "EPSG:32717")
task$data()

### Create learner ------------------------------------------------------------#
library("mlr3learners")
learner = lrn("classif.ranger", predict_type = "prob")

### Non-spatial resampling (CV) -----------------------------------------------#
rsmp_nsp = rsmp("repeated_cv", folds = 4, repeats = 2)
rsmp_nsp
rr_nsp = resample(
  task = task, learner = learner,
  resampling = rsmp_nsp
)
rr_nsp$predictions()
rr_nsp$prediction()

rr_nsp$aggregate(measures = msr("classif.auc"))

### Spatial resampling (CV) ---------------------------------------------------#
rsmp_sp = rsmp("repeated_spcv_coords", folds = 4, repeats = 2)
rsmp_sp
rr_sp = resample(
  task = task, learner = learner,
  resampling = rsmp_sp
)

rr_sp$aggregate(measures = msr("classif.auc"))

### Visualize -----------------------------------------------------------------#

# spatial
autoplot(rsmp_sp, task, fold_id = c(1:2), size = 0.8) *
  ggplot2::scale_y_continuous(breaks = seq(-3.97, -4, -0.01)) *
  ggplot2::scale_x_continuous(breaks = seq(-79.06, -79.08, -0.01))

# non-spatial
autoplot(rsmp_nsp, task, fold_id = c(1:2), size = 0.8) *
  ggplot2::scale_y_continuous(breaks = seq(-3.97, -4, -0.01)) *
  ggplot2::scale_x_continuous(breaks = seq(-79.06, -79.08, -0.01))
