# 2022-09-01 OpenGeoHub Summer School

This course has two parts:

1. Machine learning with {mlr3} - an introduction
1. {mlr3} - spatial modeling

Each parts comes with a **presentation** and **hands-on** part.

## Setup

```r
usethis::use_course("mlr-org/opengeohub-summer-school-2022")
```

This will

1. Clone the repository
1. Open an RStudio project

To install the required R packages for each hands-on:

1. Change into the directory (either `mlr3-basics` or `mlr3-spatial`)
1. Run `renv::restore()`

## Slides

You can find the slides in the respective `presentation/` directories.
The presentations were made with `quarto` v1.2.15.
To install all required R packages, run `renv::restore()` from the respective `presentation/` directory.

## Hands-on

You can find the hands-on parts in the respective `hands-on/` directories.
To install all required R packages, run `renv::restore()` from the respective `presentation/` directory.
