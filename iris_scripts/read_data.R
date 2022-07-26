# attach the iris dataset to the environment
data(iris)

# rename the dataset
dataset <- iris

colnames(dataset) <- c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")

write.csv(dataset,'iris.csv',row.names = FALSE)
