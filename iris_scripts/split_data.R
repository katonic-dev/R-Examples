
dataset<-read.csv("iris.csv")
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
head(validation)

percentage <- prop.table(table(dataset$Species)) * 100
cbind(freq=table(dataset$Species), percentage=percentage)

# summarize attribute distributions
summary(dataset)

write.csv(dataset,'train.csv',row.names=FALSE)
write.csv(validation,'validation.csv',row.names=FALSE)