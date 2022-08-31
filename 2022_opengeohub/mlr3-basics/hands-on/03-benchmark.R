library("mlr3verse")

### creating a benchmarking design --------------------------------------------#
design = benchmark_grid(
  tasks = tsks(c("spam", "german_credit", "sonar")),
  learners = lrns(c("classif.ranger", "classif.rpart", "classif.featureless"),
    predict_type = "prob", predict_sets = c("train", "test")),
  resamplings = rsmps("cv", folds = 3)
)
print(design)

# execute
bmr = benchmark(design)

## Aggregate results ----------------------------------------------------------#
measures = list(
  msr("classif.auc", predict_sets = "train", id = "auc_train"),
  msr("classif.auc", id = "auc_test")
)

tab = bmr$aggregate(measures)
print(tab[, .(task_id, learner_id, auc_train, auc_test)])

# group & rank results: which learner was best for each task and train/test?
library("data.table")
# group by levels of task_id, return columns:
# - learner_id
# - rank of col '-auc_train' (per level of learner_id)
# - rank of col '-auc_test' (per level of learner_id)
ranks = tab[, .(learner_id,
  rank_train = rank(-auc_train),
  rank_test = rank(-auc_test)),
by = task_id]
print(ranks)

## Plotting BenchmarkResults --------------------------------------------------#

autoplot(bmr) +
  ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1))

# since we used 'auc' as the measure, why not print the ROC curve?
# To only do it for a single task:
# 1. Clone the benchmark result & filter on the task
# 2. autoplot() with type = "roc"

bmr_small = bmr$clone(deep = TRUE)$filter(task_id = "german_credit")
autoplot(bmr_small, type = "roc")
