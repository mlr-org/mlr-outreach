library(mlr3spatial)
library(mlr3learners)
library(future)

# quiet execution
lgr::get_logger("bbotk")$set_threshold("warn")
lgr::get_logger("mlr3")$set_threshold("warn")

### create arbitrary raster stack ---------------------------------------------#
# ignore errors
stack = generate_stack(list(
  numeric_layer("x_1"),
  factor_layer("y", levels = c("a", "b"))),
layer_size = 10)
terra::ncell(stack)

vector = sample_stack(stack, n = 50) # adjust size as needed
tsk = as_task_classif_st(vector, id = "test_vector", target = "y")

### Train learner -------------------------------------------------------------#
lrn = lrn("classif.ranger")
lrn$train(tsk)

### Predict -------------------------------------------------------------------#
# remove target variable for prediction
stack$y = NULL
tsk_predict = as_task_unsupervised(stack, id = "parallel-pred")
# tell the learner to predict in parallel
lrn$parallel_predict = TRUE

# set future parallel plan
plan(multisession, workers = 2) # adapt as needed
# execute!
pred = predict_spatial(tsk_predict, lrn)

# multicore backend - not available on Windows!
plan(multicore, workers = 2) # adapt as needed
# execute!
pred = predict_spatial(tsk_predict, lrn)

# callr backend
library(future.callr)
plan(callr, workers = 2) # adapt as needed
# execute!
pred = predict_spatial(tsk_predict, lrn)
