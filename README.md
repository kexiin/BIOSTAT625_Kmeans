
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Kmeans

<!-- badges: start -->

[![Author](https://img.shields.io/badge/Author-KexinLi-red.svg "Author")](https://kexiin.gitee.io "Author")
[![R-CMD-check](https://github.com/kexiin/BIOSTAT625_Kmeans/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/kexiin/BIOSTAT625_Kmeans/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/kexiin/BIOSTAT625_Kmeans/branch/main/graph/badge.svg)](https://app.codecov.io/gh/kexiin/BIOSTAT625_Kmeans?branch=main)
<!-- badges: end -->

The goal of Kmeans is to partition a data set into distinct,
non-overlapping groups or clusters. Each data point is assigned to one
of these clusters based on its similarity to the centroid of the
cluster. The algorithm aims to minimize the intra-cluster variance,
meaning that the data points within a cluster should be as similar as
possible.

## Installation

You can install the development version of Kmeans from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("kexiin/BIOSTAT625_Kmeans")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Kmeans)

dataSet <- rbind(matrix(rnorm(100, 0.5, 1), ncol = 2), matrix(rnorm(100, 2, 0.1), ncol = 2))
KMeans(dataSet, kclust=2)
#> $centroids
#>           [,1]     [,2]
#> [1,] 0.2952638 0.309124
#> [2,] 1.9118264 1.975207
#> 
#> $cluster_index
#> $cluster_index[[1]]
#>  [1]  1  2  3  4  6  7  8  9 10 13 14 15 16 17 18 19 20 22 23 24 25 26 27 28 29
#> [26] 30 31 32 33 34 36 37 38 40 41 42 43 44 45 46 47 48 49 50
#> 
#> $cluster_index[[2]]
#>  [1]   5  11  12  21  35  39  51  52  53  54  55  56  57  58  59  60  61  62  63
#> [20]  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80  81  82
#> [39]  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99 100
#> 
#> 
#> $withinGroupMaxDist
#> [1] 3.997401 2.064636
```

To comparison correctness against the original R function in base
library `kmeans`:

``` r
dataSet <- rbind(matrix(rnorm(1000, 0.5, 1), ncol = 2), matrix(rnorm(1000, 2, 0.1), ncol = 2))
KMeans(dataSet, kclust=2)$centroids
#>           [,1]      [,2]
#> [1,] 0.1844136 0.2059646
#> [2,] 1.8817772 1.9041080
kmeans(dataSet, 2)$centers
#>        [,1]      [,2]
#> 1 1.8771336 1.9031988
#> 2 0.1829886 0.1986455
```

The output centers are very similar, indicating that the accuracy of
this algorithm is relatively high.

To comparison efficiency against the original R function in base library
`kmeans`:

``` r
system.time({KMeans(dataSet, kclust=2, do.plot=TRUE)})
#>    user  system elapsed 
#>    0.01    0.00    0.01
system.time({kmeans(dataSet, 2)})
#>    user  system elapsed 
#>   0.000   0.001   0.000
```

It can be seen from the calculation time that the efficiency of this
algorithm is not as efficient as `kmeans` in the base library and needs
to be further enhanced.
