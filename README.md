# cdpu

The goal of cdpu is to compare packages installed with `devtools::dev_mode(on = TRUE)` and those installed for all users.

## Installation

You can install the released version of cdpu from [CRAN](https://CRAN.R-project.org) with:

``` r
devtools::install_github("denrou/cdpu")
```

## Why and how?

In a team environment, `devtools::dev_mode(on = TRUE)` is very useful when someone wants to try some package without disturbing all other users.
During a development phase many packages can be installed in this manner, and at some point this person will share his work with all the team.

But at some point, some packages are installed in the development environment, and others are installed for all users, which can cause some incompatibilities.

The intent of the package is therefore to warn a user for possible conflicts.
To do that, the function `cdpu::warn_package_version()` can be placed in the user `.Rprofile`.
