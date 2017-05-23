#################################################################################
####### Builds Naive Bayes classifiers for the data in data-frame.csv ###########
#################################################################################

# First load the data file. You need to adjust the file path to your local environment

dataFrameFile <- "C:/workspaces/git/saerocon2017-replication/data-frame.csv"
data <- read.csv(dataFrameFile, sep=";")

# Load the RWeka library (needs to be installed in your environment) and the build naive bayes
library(RWeka)
NB <- make_Weka_classifier("weka/classifiers/bayes/NaiveBayes")
# Set up the vector of metrics used in the analysis
miningMetrics <- c("findbugsAll","pmdPriority","pmdCodeSize","pmdDesign","pmdCoupling","violations","code_smells","sqale_index","sqale_debt_ratio","Instability")

## Perform the classifier computation, evaluation and selection ##

# n corresponds to the level for which you want to compute model, e.g. n = 5 corresponds to models with 5 metrics
n <- 5
combinations <- combn(miningMetricsIssues, n)
# response is the response variable you want to build a classifier for. For the data, you can selected between "Cause", "Total", "source", "Target"
response <- "Cause"

# The result variables in which the optimal model will be stored after the execution of the loop. You can query these variables to read the results of the run
maxF <- 0
maxRecall <- 0
maxPrecision <- 0
metrics <- list()
model <- list()
classifier <- list()

for(i in 1:(length(combinations)/n)) {
  # print a status indicator
  print(i)
  
  # select a combination of metrics from the data
  tempData <- data[combinations[,i]]
  
  # build and evaluate the classifier
  tempModel <- NB(as.logical(data[, response]) ~ ., data=tempData)
  tempClassifier <- evaluate_Weka_classifier(tempModel, numFolds = 10, seed = 1)
  
  # compute precision and recall from the confusion matrix
  truePositive = tempClassifier$confusionMatrix[2, 2]
  falsePositive = tempClassifier$confusionMatrix[1, 2]
  falseNegative = tempClassifier$confusionMatrix[2, 1]
  
  precision = truePositive / (truePositive + falsePositive)
  if((truePositive + falsePositive) == 0) {
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
  
  # see if the current model is more optimal than the current max
  if(fMeasure > maxF) {
    maxF <- fMeasure
    maxRecall <- recall
    maxPrecision <-  precision
    metrics <- el
    model <- tempModel
    classifier <- tempClassifier
  }
}