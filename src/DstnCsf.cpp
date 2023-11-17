#include <Rcpp.h>
using namespace Rcpp;

// Function to calculate Euler distance (calcDis)
// [[Rcpp::export]]
NumericMatrix calcDis(NumericMatrix dataSet, NumericMatrix centroids) {
  int n = dataSet.nrow();
  int k = centroids.nrow();
  int p = dataSet.ncol();
  // list of the distance between each point to the centroids
  NumericMatrix clalist(n, k);

  for (int i = 0; i < n; i++) {
    for (int j = 0; j < k; j++) {
      float distance = 0;
      for (int l = 0; l < p; l++) {
        distance += pow((dataSet(i, l) - centroids(j, l)), 2);
      }
      clalist(i, j) = pow(distance, 0.5);
    }
  }

  return clalist;
}


// Function to classify and calculate new centroids (classify)
// [[Rcpp::export]]
List classify(NumericMatrix dataSet, NumericMatrix centroids) {
  int n = dataSet.nrow();
  int k = centroids.nrow();
  int p = dataSet.ncol();

  // Calculate the distance between the sample and centroids
  NumericMatrix clalist = calcDis(dataSet, centroids);

  // Group and calculate new centroids
  IntegerVector minDistIndices(n);
  for (int i = 0; i < n; i++) {
    minDistIndices(i) = 1;
    for (int j = 1; j < k; j++) {
      if (clalist(i, j) < clalist(i, minDistIndices(i) - 1)) {
        minDistIndices(i) = j + 1;
      }
    }
  }

  // Sum of each group
  NumericMatrix newCentroids(k, p);
  NumericVector clusterCounts(k);
  for (int i = 0; i < n; i++) {
    int j = minDistIndices(i) - 1;
    clusterCounts(j)++;
    for (int l = 0; l < p; l++) {
      newCentroids(j, l) += dataSet(i, l);
    }
  }

  // newCentroids and change of centroids
  NumericMatrix changed(k, p);
  for (int j = 0; j < k; ++j) {
    for (int l = 0; l < p; l++) {
      newCentroids(j, l) = newCentroids(j, l) / clusterCounts(j);
      changed(j, l) = newCentroids(j, l) - centroids(j, l);
    }
  }

  return List::create(Named("changed") = changed,
                      Named("newCentroids") = newCentroids);
}

