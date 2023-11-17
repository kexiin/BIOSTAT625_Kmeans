
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Kmeans

<!-- badges: start -->

[![Author](https://img.shields.io/badge/Author-KexinLi-red.svg "Author")](https://kexiin.gitee.io "Author")
<!-- badges: end -->

The goal of Kmeans is to partition a dataset into distinct,
non-overlapping groups or clusters. Each data point is assigned to one
of these clusters based on its similarity to the centroid (center) of
the cluster. The algorithm aims to minimize the intra-cluster variance,
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
KMeans(dataSet, kclust=2, do.plot=TRUE)
#> $centroids
#>           [,1]      [,2]
#> [1,] 0.3223876 0.3275737
#> [2,] 1.9010921 1.9352818
#> 
#> $cluster_index
#> $cluster_index[[1]]
#>  [1]  1  2  3  5  6  8  9 11 12 13 14 15 16 17 19 20 21 22 24 25 27 29 30 31 32
#> [26] 33 34 35 36 37 38 39 40 42 43 44 45 46 47 48 49 50
#> 
#> $cluster_index[[2]]
#>  [1]   4   7  10  18  23  26  28  41  51  52  53  54  55  56  57  58  59  60  61
#> [20]  62  63  64  65  66  67  68  69  70  71  72  73  74  75  76  77  78  79  80
#> [39]  81  82  83  84  85  86  87  88  89  90  91  92  93  94  95  96  97  98  99
#> [58] 100
#> 
#> 
#> $withinGroupMaxDist
#> [1] 4.71076 2.26090
```

To comparison correctness against the original R function in base
library `kmeans`:

``` r
KMeans(dataSet, kclust=2)$centroids
#>           [,1]      [,2]
#> [1,] 0.3223876 0.3275737
#> [2,] 1.9010921 1.9352818
kmeans(dataSet, 2)$centers
#>        [,1]      [,2]
#> 1 0.3223876 0.3275737
#> 2 1.9010921 1.9352818
```

The output centers are very similar, indicating that the accuracy of
this algorithm is relatively high.

To comparison efficiency against the original R function in base library
`kmeans`:

``` r
dataSet <- rbind(matrix(rnorm(1000, 0.5, 1), ncol = 2), matrix(rnorm(1000, 2, 0.1), ncol = 2))
system.time({KMeans(dataSet, kclust=2, do.plot=TRUE)})
#>    user  system elapsed 
#>   0.011   0.000   0.012
system.time({kmeans(dataSet, 2)})
#>    user  system elapsed 
#>   0.001   0.000   0.000
```

It can be seen from the calculation time that the efficiency of this
algorithm is not as efficient as `kmeans` in the base library and needs
to be further enhanced.
