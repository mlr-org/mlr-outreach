paramss = list(
  list(outer_folds = 10, models = FALSE, evals = 35),
  list(outer_folds = 10, models = FALSE, evals = 50),
  list(outer_folds = 5, models = TRUE, evals = 35)
)
for (paramsi in paramss) {
  rmarkdown::render("xgboost_autotuner.Rmd", output_file = paste0("xgboost_autotuner_",paste0(paramsi, collapse = "_"), ".html"), params = paramsi)
}
