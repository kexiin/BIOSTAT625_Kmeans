test_that("multiplication works", {
  dataSet <- matrix(c(0, 0, 1, 0, 0, 1, 1, 1, 2, 1,
                      30, 20, 60, 60, 70, 60, 100, 20, 20, 20),byrow=TRUE,ncol=2)
  kclust <- 2
  result <- KMeans(dataSet, kclust)
  expect_equal(round(result$centroids, 0), matrix(c(8, 77, 6, 47), ncol=2))
  expect_equal(result$cluster_index[[1]], c(1, 2, 3, 4, 5, 6, 10))
  expect_equal(result$cluster_index[[2]], c(7, 8, 9))
})

