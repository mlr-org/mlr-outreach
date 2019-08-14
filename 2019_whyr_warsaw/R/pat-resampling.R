resampling_plan = drake_plan(
  resampling_inner = target(mlr_resamplings$get("cv3")),

  resampling_outer = target(mlr_resamplings$get("repeated_cv", param_vals = list(folds = 2, repeats = 1))
  )
)
