urlData="https://archive.ics.uci.edu/ml/machine-learning-databases/car/car.data"

if(!file.exists("data.csv")){
  download.file(urlData,"data.csv",cacheOK=TRUE)
}
allData<-read.csv(file = "data.csv", stringsAsFactors=FALSE)

library(caret)
library(rattle)
library(ISLR)
library(class)

names(allData)<-c("buying","maint","doors","persons","lug_boot","safety","class")

if(!file.exists("modelGBM.rda")){
  set.seed(82016)
  inTrain<-createDataPartition(allData$class,p=0.8)[[1]]
  
  allData$buying<-as.character(allData$buying)
  allData$maint<-as.character(allData$maint)
  allData$doors<-as.character(allData$doors)
  allData$persons<-as.character(allData$persons)
  allData$lug_boot<-as.character(allData$lug_boot)
  allData$safety<-as.character(allData$safety)
  
  
  training<-allData[inTrain,]
  testing<-allData[-inTrain,]
  modelGBM<-train(class~.,method="gbm",data=training)
  save(modelGBM,file="modelGBM.rda")
  
}else{
  load(file="modelGBM.rda")
}

predictions<-function(buying,maint,doors,persons,lug_boot,safety){
  newData<-data.frame(renderText(buying), 
                      renderText(maint),
                      renderText(doors),
                      renderText(persons),
                      renderText(lug_boot),
                      renderText(safety))
  #     
  names(newData)<-c("buying", "maint","doors","persons","lug_boot","safety")
  # #     newData$class<-NA
  #     
#   predict(modelGBM,newdata=as.matrix(newData))
  
}
  
  

shinyServer(
  function(input, output) { 
     output$buying <- renderPrint(input$buying)
#     verbatimTextOutput(buying)
     buying<-renderText(input$buying)
     maint <- renderText(input$maint)
    doors <- renderText(input$doors)
    persons <- renderText(input$persons)
    lug_boot <- renderText(input$lug_boot)
    safety <- renderText(input$safety)
#     newData<-data.frame(renderText(input$buying), 
#                         maint,
#                         doors,
#                         persons,
#                         lug_boot,
#                         safety)
# #     
#     names(newData)<-c("buying", "maint","doors","persons","lug_boot","safety")
# # #     newData$class<-NA
# #     
#     pGBM<-predict(modelGBM,newdata=as.matrix(newData))
    output$prediction<-predictions(input$buying,input$maint,input$doors,input$persons,input$lug_boot,input$safety)
  }
)
