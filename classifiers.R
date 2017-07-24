#################################################################################
####### Builds Naive Bayes classifiers for the data in data-frame.csv ###########
#################################################################################

# Instructions:
# To perform the computation, load the script in your R environment and adjust it to what you want to compute.
# Hints on possible adjustments are given as comments in this file.

# First load the data file. You need to adjust the file path to your local environment.

dataFrameFile <- "C:/workspaces/git/saerocon2017-replication/data-frame.csv"
data <- read.csv(dataFrameFile, sep=";")

# Load the RWeka library (which needs to be installed in your environment) and the build naive bayes classifier
library(RWeka)
NB <- make_Weka_classifier("weka/classifiers/bayes/NaiveBayes")
# Set up the vector of metrics used in the analysis
miningMetrics <- c("findbugsAll","pmdPriority","pmdCodeSize","pmdDesign","pmdCoupling","violations","code_smells","sqale_index","sqale_debt_ratio","Instability")

## Perform the classifier computation, evaluation and selection ##

# n corresponds to the level for which you want to compute model, e.g. n = 5 corresponds to models with 5 metrics. You need to adjust this value if you want to compute models for a different level.
n <- 5
combinations <- combn(miningMetricsIssues, n)
# This is the response variable you want to build a classifier for. For the data, you can select between "Cause", "Total", "source", "Target".
response <- "Total"

# The result variables in which the optimal model will be stored after the execution of the loop. You can query these variables to read the results of the run

# The F-score of the optimal model
maxF <- 0
# The recall of the optimal model
maxRecall <- 0
# The precision of the optimal model
maxPrecision <- 0
# The metrics that make up the optimal model
metrics <- list()
# The optimal model with descriptive data
model <- list()
# A summary of the optimal classifier and the confusion matrix
classifier <- list()

# Compute every combination of metrics and see if it is better than the prior maximum
for(i in 1:(length(combinations)/n)) {
  # Print a progress indicator
  print(i)
  
  # Select a combination of metrics from the data
  tempData <- data[combinations[,i]]
  
  # Build and evaluate the classifier
  tempModel <- NB(as.logical(data[, response]) ~ ., data=tempData)
  tempClassifier <- evaluate_Weka_classifier(tempModel, numFolds = 10, seed = 1)
  
  # Compute precision and recall from the confusion matrix
  truePositive = tempClassifier$confusionMatrix[2, 2]
  falsePositive = tempClassifier$confusionMatrix[1, 2]
  falseNegative = tempClassifier$confusionMatrix[2, 1]
  
  precision = truePositive / (truePositive + falsePositive)
  if((truePositive + falsePositive) == 0) {
    # This is needed, because in case of 0, R will assign the value "na" and further comparison operations will fail
    precision = 0
  }
  recall = truePositive / (truePositive + falseNegative)
  if((truePositive + falseNegative) == 0) {
    recall = 0
  }
  fMeasure = 2 * ((precision * recall) / (precision + recall))
  if((precision + recall) == 0) {
    fMeasure = 0
  }
  
  # See if the current model is better than the current maximum
  if(fMeasure > maxF) {
    maxF <- fMeasure
    maxRecall <- recall
    maxPrecision <-  precision
    metrics <- combinations[,i]
    model <- tempModel
    classifier <- tempClassifier
  }
}

# When this loop has executed, you can query the result variables (maxF, maxRecall, maxPrecision, metrics, model, classifier) to get information about the optimal model of the current run
