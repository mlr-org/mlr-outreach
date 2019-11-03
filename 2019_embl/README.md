# Practical Workshop on Machine Learning in R

06/11/2019 - 07/11/2019

Link to this Page: **http://tiny.cc/mlr3_embl**

## Tutors and Helpers:

- Prof. Dr. Bernd Bischl
- Dr. Giuseppe Casalicchio
- Martin Binder

## Schedule

### Day 1 (06/11/2019)

| Time | Topic                        |
| :-   | :---------------             |
| 09:30 - 11:00 | Lecture Session: Performance Evaluation - Measures, Resampling, and ROC Analysis |
| 11:00 - 12:30 | Lecture and Demo Session: Introduction to mlr3 |
| 12:30 - 13:30 | Lunch Break |
| 13:30 - 15:00 | Hands-on Session: Practice mlr3 Basics |
| 15:00 - 16:30 | Lecture Session: Regularization and Boosting |
| 16:30 - 17:00 | General Questions |

### Day 2 (07/11/2019)

| Time | Topic                        |
| :-   | :---------------             |
| 09:30 - 11:00 | Lecture Session: Hyperparameter Tuning and nested Cross-Validation |
| 11:00 - 12:30 | Lecture and Demo Session: Introduction to mlr3tuning |
| 12:30 - 13:30 | Lunch Break |
| 13:30 - 15:00 | Lecture Session: Feature Engineering |
| 15:00 - 16:30 | Lecture and Demo Session: Introduction to mlr3pipelines |
| 16:30 - 17:00 | General Questions |

## Set up your Session!

### Remote

Easy: Run examples on RStudio Cloud. Everything is installed and was tested before, so it should work. 
You need to sign up for an account, then open the project: https://rstudio.cloud/project/666317

### Alternatively: Local

Run examples on your machine. For this you have to make sure your packages are installed and updated. Can't be guaranteed to work.

Load this page from the link above and copy-paste this in your R session:

```r
# install from CRAN
packages_cran = c("remotes", "data.table", "ggplot2", "skimr", "DataExplorer",
  "rpart.plot", "farff", "curl", "visNetwork", "precrec",
  "glmnet", "kknn", "MASS", "ranger", "xgboost", "e1071",
  "future", "future.apply")

# install things from GitHub that are not yet on CRAN
packages_gith = "mlr-org/mlr3viz"

to_install = setdiff(packages_cran, installed.packages()[,"Package"])
if (length(to_install)) install.packages(to_install)
install.packages(c("mlr3", "mlr3misc", "paradox", "mlr3filters", "mlr3learners",
  "mlr3pipelines", "mlr3tuning"))
lapply(packages_gith, remotes::install_github)
```

## Further Links

- Main Repo **mlr3**: https://github.com/mlr-org/mlr3
  - *mlr3* documentation (long form book): https://mlr3book.mlr-org.com/
  - *mlr3* reference: https://mlr3.mlr-org.com/reference/index.html
- **mlr3tuning** repo: https://mlr3pipelines.mlr-org.com/reference/index.html
  - *mlr3tuning* reference: https://mlr3tuning.mlr-org.com/reference/index.html
  - Defining search spaces with *paradox*: https://mlr3book.mlr-org.com/paradox.html
- **mlr3pipelines** repo: https://github.com/mlr-org/mlr3pipelines/
  - Some introduction documentation: https://mlr3pipelines.mlr-org.com/articles/introduction.html
  - *mlr3pipelines* reference: <https://mlr3pipelines.mlr-org.com/reference/index.html>

### See also:
- Questions? Ask under the *mlr3 tag on StackOverflow*: https://stackoverflow.com/questions/tagged/mlr3
- Bugs? Suggestions? Don't hesitate to report. Issue trackers on GitHub:
  - *mlr3*: https://github.com/mlr-org/mlr3/issues/
  - *mlr3tuning*: https://github.com/mlr-org/mlr3tuning/issues/
  - *mlr3pipelines*: https://github.com/mlr-org/mlr3pipelines/issues/
