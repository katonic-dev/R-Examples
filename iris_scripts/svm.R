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