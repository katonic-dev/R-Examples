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
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)


saveRDS(fit.knn, "knn.rds")

