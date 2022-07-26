
library(caret)
dataset<-read.csv("train.csv")
sapply(dataset, class)
head(dataset)
dataset$Species <- as.factor(dataset$Species)

# Run algorithms using 10-fold cross validation
control <- readRDS("control.rds")
metric <- "Accuracy"

# a) linear algorithms
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)

saveRDS(fit.lda, "lda.rds")