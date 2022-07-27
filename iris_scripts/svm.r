# install.packages("caret", dependencies=c("Depends", "Suggests"),repos = "http://cran.us.r-project.org")

# install.packages("gower",repos = "http://cran.us.r-project.org")
# install.packages("parallelly",repos = "http://cran.us.r-project.org")
# install.packages("ModelMetrics",repos = "http://cran.us.r-project.org")
library(caret)

dataset<-read.csv("train.csv")
sapply(dataset, class)
head(dataset)
dataset$Species <- as.factor(dataset$Species)

# Run algorithms using 10-fold cross validation
control <- readRDS("control.rds")
metric <- "Accuracy"

# kNN
set.seed(7)
# c) advanced algorithms
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)

saveRDS(fit.svm, "svm.rds")