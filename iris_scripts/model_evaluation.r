# summarize accuracy of models
# install.packages("caret", dependencies=c("Depends", "Suggests"),repos = "http://cran.us.r-project.org")

# install.packages("gower",repos = "http://cran.us.r-project.org")
# install.packages("parallelly",repos = "http://cran.us.r-project.org")
# install.packages("ModelMetrics",repos = "http://cran.us.r-project.org")
library(caret)

fit.lda <- readRDS("lda.rds")
fit.cart <- readRDS("cart.rds")
fit.knn <- readRDS("knn.rds")
fit.svm <- readRDS("svm.rds")
fit.rf <- readRDS("rf.rds")

validation<-read.csv("validation.csv")
sapply(validation, class)
head(validation)
validation$Species <- as.factor(validation$Species)

results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf))
summary(results)


# compare accuracy of models
dotplot(results)

# summarize Best Model
print(fit.lda)

predictions <- predict(fit.lda, validation)
confusionMatrix(predictions, validation$Species)