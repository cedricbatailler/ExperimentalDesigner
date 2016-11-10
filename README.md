
<!-- README.md is generated from README.Rmd. Please edit that file -->
ExperimentalDesigner
====================

[![CRAN status](http://www.r-pkg.org/badges/version/ExperimentalDesigner)](https://cran.r-project.org/package=ExperimentalDesigner)

Installation
------------

You can install ExperimentalDesigner from github with:

``` r
# install.packages("devtools")
devtools::install_github("cedricbatailler/ExperimentalDesigner")
```

Example
-------

This is a basic example which shows you how to use ExperimentalDesigner

``` r
library(ExperimentalDesigner)

Condition <-
  c("Eperimental", "Control")

InitExperimentalPlan(80) %>%
  AddFactor(Condition) %>%
  RandomizeOrder() %>%
  ReassignParticipantNumber() %>% 
  SaveExperimentalPlan("myplan.xlsx")
```
