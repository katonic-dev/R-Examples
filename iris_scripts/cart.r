# install.packages("caret", dependencies=c("Depends", "Suggests"),repos = "http://cran.us.r-project.org")
#testing
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

# b) nonlinear algorithms
# CART
set.seed(7)
fit.cart <- train(Species~., data=dataset, method="rpart", metric=metric, trControl=control)
saveRDS(fit.cart, "cart.rds")