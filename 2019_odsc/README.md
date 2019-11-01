
# mlr: Machine Learning in R <img src="mlr.png" align="right" />

November 01, 2019; 11:00 - 12:30

Link to this Page: **tiny.cc/mlr3_odsc**

## Set up your Session!

### Remote

Easy: Run examples on RStudio Cloud. Everything is installed and was tested before, so it should work. You need to sign up for an account, then open the project: https://rstudio.cloud/project/673661

### Alternatively: Local

Run examples on your machine. For this you have to make sure your packages are installed and updated. Can't be guaranteed to work.

Load this page from the link above and copy-paste this in your R session:

```r
packages_cran = c(
    "data.table", "ggplot2", "rpart.plot", "visNetwork",
    "kknn", "MASS", "ranger",
    "future", "future.apply")
to_install = setdiff(packages_cran, installed.packages()[,"Package"])
if (length(to_install)) install.packages(to_install)

mlr3_pkgs <- c("mlr3misc", "paradox", "mlr3", "mlr3filters",
  "mlr3learners", "mlr3pipelines", "mlr3tuning")
# always re-install these
install.packages(mlr3_pkgs)
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
