urlData="https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data"

download.file(urlData,"data.csv",cacheOK=TRUE)
allData<-read.csv(file = "data.csv")

library(caret)
library(rattle)
library(ISLR)
library(class)
# https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.c45-names
# https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.names
# buying:   vhigh, high, med, low.
# maint:    vhigh, high, med, low.
# doors:    2, 3, 4, 5more.
# persons:  2, 4, more.
# lug_boot: small, med, big.
# safety:   low, med, high.
#https://archive.ics.uci.edu/ml/datasets/Car+Evaluation
names(allData)<-c("buying","maint","doors","persons","lug_boot","safety","class")


set.seed(82016)
inTrain<-createDataPartition(allData$class,p=0.8)[[1]]
training<-allData[inTrain,]
testing<-allData[-inTrain,]

modelRF<-train(class~.,method="rf",data=training)
modelGBM<-train(class~.,method="gbm",data=training)
# modelMBt<-train(class~.,method="mboost",data=training)
modelKnn<-train(class~.,method="knn",data=training)
modelRPart<-train(class~.,method="rpart",data=training)
modelNB<-train(class~.,method="nb",data=training)


newData<-data.frame(c("high"), 
                    c("med"),
                    c("4"),
                    c("4"),
                    c("med"),
                    c("high"))
names(newData)<-c("buying", "maint","doors","persons","lug_boot","safety")
pGBM<-predict(modelGBM,newdata=newData)
pGBM
# 
# > pGBM<-predict(modelGBM,newdata=testing)
# > confusionMatrix(pGBM,testing$class)$overall[1]
# Accuracy 
# 0.9766764 
save(modelGBM,file="modelGBM.rda")
save(modelRF,file="modelRF.rda")
save(modelKnn,file="modelKnn.rda")
save(modelRPart,file="modelRPart.rda")
save(modelNB,file="modelNB.rda")
