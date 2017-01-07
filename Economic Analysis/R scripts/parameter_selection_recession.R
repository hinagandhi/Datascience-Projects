install.packages("Boruta")
library(Boruta)

setwd('/Users/hinagandhi/Desktop')
#testdata <- subset(testdata, select=c(2:15,17))
Boston<-read.csv("dataset_new.csv")
Boston <- subset(Boston, select=c(1:16,18))
#View(Boston)


set.seed(123)
boruta.train <- Boruta(recession~., data = Boston, doTrace = 2)
print(boruta.train)


plot(boruta.train, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.train$ImpHistory),function(i)
  boruta.train$ImpHistory[is.finite(boruta.train$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.train$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(boruta.train$ImpHistory), cex.axis = 0.7)

