settings_grid = tibble::tribble(
  # write learner/ParamSet grid
  ~learner, ~param_set, ~learner_id,
  "classif.svm", "param_set_svm1", "SVM-PS1",
  "classif.svm", "param_set_svm2", "SVM-PS2",
  "classif.kknn", "param_set_knn1", "KNN-PS1",
  "classif.kknn", "param_set_knn2", "KNN-PS2"
) %>%
  tidyr::crossing(task = c("iris", "spam")) %>%
  dplyr::mutate(param_set_sym = syms(param_set))

  ### alternatively: automate "pretty" learner id creation
  # %>% dplyr::rowwise() %>% # string extraction won't work otherwise
  # %>% mutate(learner_id = paste0(
  #   toupper(str_split_fixed(learner, "[.]", n = 2)[2]),
  #   "-",
  #   paste0("PS", str_extract(param_set, "(\\d)+")),
  #   "-",
  #   task)
  # )

benchmark_plan = drake_plan(

  bm = target(

    create_single_bm(learner = learner,
      learner_id = learner_id,
      task = task,
      measures = measures,
      param_set = param_set_sym,
      resampling_inner = resampling_inner,
      resampling_outer = resampling_outer,
      terminator = terminator),

    transform = map(.data = !!settings_grid,
      .id = c(learner, task) # creation of bm_* target IDs
    )
  ),

  # combine benchmark results (all)
  # from R/model-functions.R
  agg = target(
    combine_benchmarks(bm),
    transform = combine(bm)
  ),

  # combine BMR by tasks
  # from R/model-functions.R
  agg_task = target(
    combine_benchmarks(bm),
    transform = combine(bm, .by = task)
  )
)
