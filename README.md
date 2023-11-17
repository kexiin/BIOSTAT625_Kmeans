
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
#>            [,1]      [,2]
#> [1,] 0.02711505 0.3375839
#> [2,] 1.88858455 1.8832181
#> 
#> $cluster_index
#> $cluster_index[[1]]
#>  [1]  2  4  6  7  9 11 13 15 16 18 19 20 21 22 23 25 27 28 29 30 32 33 34 35 36
#> [26] 37 38 39 41 42 44 45 46 47 48 49 50
#> 
#> $cluster_index[[2]]
#>  [1]   1   3   5   8  10  12  14  17  24  26  31  40  43  51  52  53  54  55  56
#> [20]  57  58  59  60  61  62  63  64  65  66  67  68  69  70  71  72  73  74  75
#> [39]  76  77  78  79  80  81  82  83  84  85  86  87  88  89  90  91  92  93  94
#> [58]  95  96  97  98  99 100
#> 
#> 
#> $withinGroupMaxDist
#> [1] 4.977129 3.280273
```

To comparison correctness against the original R function in base
library `kmeans`:

``` r
KMeans(dataSet, kclust=2)$centroids
#>            [,1]      [,2]
#> [1,] 0.02711505 0.3375839
#> [2,] 1.88858455 1.8832181
kmeans(dataSet, 2)$centers
#>       [,1]      [,2]
#> 1 1.894034 1.9368384
#> 2 0.114052 0.3329794
```

The output centers are very similar, indicating that the accuracy of
this algorithm is relatively high.

To comparison efficiency against the original R function in base library
`kmeans`:

``` r
library(bench)
bench::mark(
  sort(round(KMeans(dataSet, kclust=2)$centroids, 0)),
  sort(round(kmeans(dataSet, 2)$centers, 0))
)
#> # A tibble: 2 × 6
#>   expression                            min  median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>                       <bch:tm> <bch:t>     <dbl> <bch:byt>    <dbl>
#> 1 sort(round(KMeans(dataSet, kclu…   6.03ms   6.4ms      154.   142.2KB     25.7
#> 2 sort(round(kmeans(dataSet, 2)$c… 188.98µs   208µs     4703.    13.3KB     16.8
```

It can be seen from the calculation time that the efficiency of this
algorithm is not as efficient as `kmeans` in the base library and needs
to be further enhanced.
