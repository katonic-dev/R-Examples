dataset<-read.csv("train.csv")

sapply(dataset, class)
head(dataset)
dataset$Species <- as.factor(dataset$Species)
# split input and output
x <- dataset[,1:4]
y <- dataset[,5]

head(dataset)
summary(dataset)

# boxplot for each attribute on one image
par(mfrow=c(1,4))
for(i in 1:4) {
  boxplot(main=names(iris)[i],x[,i])
}

print(y)


# barplot for class breakdown
plot(y)

# scatterplot matrix
featurePlot(x=x, y=y, plot="ellipse")


# box and whisker plots for each attribute
featurePlot(x=x, y=y, plot="box")

scales <- list(x=list(relation="free"), y=list(relation="free"))
featurePlot(x=x, y=y, plot="density", scales=scales)

control <- trainControl(method="cv", number=10)

saveRDS(control, "control.rds")

write.csv(x,"features.csv",row.names=FALSE)
write.csv(y,"target.csv",row.names=FALSE)

