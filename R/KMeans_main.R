#' A implementation Kmeans Algorithm
#' @param dataSet input dataset
#' @param kclust number of cluster
#' @param tol tolerance
#' @return A list containing centroids, cluster results, cluster index and max distance within groups
#' @examples
#' dataSet <- matrix(c(0,0,1,0,0,1,1,1,2,1,1,2,2,2,3,2,6,6,7,6,
#' 8,6,6,7,7,7,8,7,9,8,7,8,8,8,9,9,8,9,9,5), byrow=TRUE, ncol=2)
#' kclust = 3
#' kmeans.core(dataSet, kclust)
#' @import Rcpp
#' @export

kmeans.core <- function(dataSet, kclust, tol=1e-6) {
  # randomly choose the centroid
  centroids <- dataSet[sample(seq_len(nrow(dataSet)), kclust), ]

  # Update the centroids until converge
  UpdateCen <- classify(dataSet, centroids)
  changed <- UpdateCen$changed
  newCentroids <- UpdateCen$newCentroids
  while (max(abs(changed)) > tol) {
    UpdateCen <- classify(dataSet, newCentroids)
    changed <- UpdateCen$changed
    newCentroids <- UpdateCen$newCentroids
  }
  centroids <- newCentroids[order(newCentroids[, 1]), ]

  # Compute each cluster based on centroids
  cluster <- list()
  cluster_index <- list()
  clalist <- calcDis(dataSet, centroids)
  minDistIndices <- apply(clalist, 1, which.min)
  for (i in 1:kclust) {
    cluster[[i]] <- dataSet[minDistIndices == i, ]
    cluster_index[[i]] <- which(minDistIndices == i)
  }

  # Farthest distance between each cluster
  withinDist <- numeric(kclust)
  for (i in 1:kclust) {
    clusti <- cluster[[i]]
    withinDist[i] <- max(dist(clusti))
  }

  return(list(centroids=centroids, cluster=cluster, cluster_index=cluster_index,
              withinGroupMaxDist=withinDist))
}



#' A collection of Kmeans results and plots
#' @param dataSet input dataset
#' @param kclust number of cluster
#' @param do.plot TRUE if user needs visual results of clustering of points with two-dimensional features
#' @return A list containing centroids, cluster index and max distance within groups
#' @examples
#' dataSet <- matrix(c(0,0,1,0,0,1,1,1,2,1,1,2,2,2,3,2,6,6,7,6,
#' 8,6,6,7,7,7,8,7,9,8,7,8,8,8,9,9,8,9,9,5), byrow=TRUE, ncol=2)
#' kclust = 3
#' KMeans(dataSet, kclust, do.plot=TRUE)
#' @import ggplot2
#' @export

KMeans <- function(dataSet, kclust, do.plot=TRUE) {
  kmeansOut <- kmeans.core(dataSet, kclust)

  if (do.plot && (ncol(dataSet) == 2)) {
    data <- data.frame(dataSet)
    cent.df <- data.frame(kmeansOut$centroids)

    ggplot() +
      geom_point(data, mapping=aes(x=X1, y=X2), color = '#ffbc14', size = 4) +
      geom_point(cent.df, mapping=aes(x=X1, y=X2), shape = 4, color = '#006b7b', size = 5) +
      labs(title = 'Original Points and Centroids') +
      theme_minimal() +
      theme(plot.title = element_text(hjust = 0.5))
  }

  return(list(centroids=kmeansOut$centroids, cluster_index=kmeansOut$cluster_index,
              withinGroupMaxDist=kmeansOut$withinGroupMaxDist))
}
