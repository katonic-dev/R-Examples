## installed packages
install.packages("caret", dependencies=c("Depends", "Suggests"))

install.packages("gower")
install.packages("parallelly")
install.packages("ModelMetrics")
library(caret)

# attach the iris dataset to the environment
data(iris)

# rename the dataset
dataset <- iris

colnames(dataset) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")
# create a list of 80% of the rows in the original dataset we can use for training
validation_index <- createDataPartition(dataset$Species, p=0.80, list=FALSE)
# select 20% of the data for validation
validation <- dataset[-validation_index,]
# use the remaining 80% of data to training and testing the models
dataset <- dataset[validation_index,]

# dimensions of dataset
dim(dataset)

sapply(dataset, class)

head(dataset)

percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)

# summarize attribute distributions
summary(dataset)

# split input and output
x <- dataset[,1:4]
y <- dataset[,5]

print(y)

# boxplot for each attribute on one image
par(mfrow=c(1,4))
print(names(iris))
for(i in 1:4) {
  boxplot(main=names(iris)[i],x[,i])
}

# barplot for class breakdown
plot(y)

# scatterplot matrix
featurePlot(x=x, y=y, plot="ellipse")


# box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")

scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)


# Run algorithms using 10-fold cross validation
control <- trainControl(method="cv", number=10)
metric <- "Accuracy"

# a) linear algorithms
set.seed(7)
fit.lda <- train(Species~., data=dataset, method="lda", metric=metric, trControl=control)
# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
# kNN
set.seed(7)
fit.knn <- train(Species~., data=dataset, method="knn", metric=metric, trControl=control)
# c) advanced algorithms
# SVM
set.seed(7)
fit.svm <- train(Species~., data=dataset, method="svmRadial", metric=metric, trControl=control)
# Random Forest
set.seed(7)
fit.rf <- train(Species~., data=dataset, method="rf", metric=metric, trControl=control)


# summarize accuracy of models
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)


# compare accuracy of models
dotplot(results)

# summarize Best Model
print(fit.lda)

predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)