# Load packages and function -----------------------------------------------------------
source("packages.R")

sourceDirectory("R")

# suppress progress output of `benchmark()`
lgr::get_logger("mlr3")$set_threshold("warn")

# Set Slurm options for workers -------------------------------------------

## HPC
#options(clustermq.scheduler = "slurm",
#        clustermq.template = "slurm_clustermq.tmpl")
## Local
options(clustermq.scheduler = "multicore")

# Create plans ------------------------------------------------------------

source("pat-benchmark_plan.R")

plan = bind_plans(param_sets_plan, resampling_plan, tuning_plan, benchmark_plan)

# Set the config ----------------------------------------------------------

drake_config(plan, verbose = 2,

             ## HPC
             # parallelism = "clustermq", #jobs = 2,
             #template = list(n_cpus = 5, memory = 34000, log_file = "worker%a.log"),

             # internal parallelization
             prework = quote(future::plan(future.callr::callr, workers = 4)),
             console_log_file = "drake.log")


