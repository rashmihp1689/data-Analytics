setwd("G:/B5/logistic")
#Read given csv file for analysys

goodForU <- read.csv("goodforu.csv", header=T, stringsAsFactors = T)
#Quick View of data using some functions in R to know some basic details

str(goodForU)
dim(goodForU)
head(goodForU)
tail(goodForU)
names(goodForU)
summary(goodForU) 

library(dplyr)
library(gains)
library(irr)
library(ROCR)
View(goodForU)


#Prepare for Brand A

goodForUBrandA <- select(goodForU,X2,X9,X16,X23,X30)


#Quick Check Brand A

View(goodForUBrandA)
summary(goodForUBrandA)


colnames(goodForUBrandA) <- c("Farm_grown_ingredients_Chips","zero_grams_transfat_Chips","Natural_oil_Used_Chips","10Good_1Bad_Rate_Chips","10Minimally_1Heavily_processed_Chips")


#Version1 : Create a Column to show Good bad target Identification with Rate >=5(6 to 10) from goodForUBrandA
goodForUBrandA_Cleaned <- goodForUBrandA%>%mutate('10Good_1Bad_Rate_Chips_TargetRate'=ifelse(goodForUBrandA$'10Good_1Bad_Rate_Chips'>=5,1,0))


#Version2: Add similary one more Column to show Minimally or Heavily processed identification with Rate < (5 to 1) to goodForUBrandA_Cleaned

goodForUBrandA_Cleaned <- goodForUBrandA_Cleaned%>%mutate('10Minimally_1Heavily_processed_Chips_Rate'= ifelse(goodForUBrandA$'10Minimally_1Heavily_processed_Chips'<5,"Heavily Processed","Minimally Processed"))



View(goodForUBrandA_Cleaned)
names(goodForUBrandA_Cleaned)




colSums(is.na(goodForUBrandA_Cleaned))



Final <- goodForUBrandA_Cleaned[, -c(4,5)]

library(corrgram)
?corrgram
cormat<-corrgram(Final)

write.csv(cormat,"Correlation.csv")

View(Final)
names(Final)
summary(Final)




table(Final$`10Good_1Bad_Rate_Chips_TargetRate`) / nrow(Final)
#install.packages("corrplot")
#library(corrplot)


logRegModel <- glm(data = Final,Final$`10Good_1Bad_Rate_Chips_TargetRate`~.,family = "binomial")
summary(logRegModel)



confint(logRegModel)


#Finding Predicted Values

?glm

logRegModel$fitted.values


predicted <- logRegModel$fitted.values
predicted
class(predicted)
str(predicted)
head(predicted)
length(predicted)

head(Final$`10Good_1Bad_Rate_Chips_TargetRate`)

#Confusion Matrix
predbkt<-ifelse(predicted>0.5,'G','B')
table(predbkt,Final$`10Good_1Bad_Rate_Chips_TargetRate`)

# At 0.5 cut-off "correctly - "True Negatives"

#True Positive+ True Negative should be high. 

# Accuracy = (TP+TN)/(P+N)

# Accuracy = (443+88)/(88+123+46+443)probability:-
# 435 good customers were predicted as "good' correctly - "True Positive"
# 118 bad customers were predicted as "bad
(8608+8717)/(8608+8717+3237+3552)

# To find accuracies for different cut-off probabilities

# There are a lot of performance parameters available in ROCR package

#install.packages("ROCR")
library(ROCR)


# The prediction function of the ROCR library basically creates 
# a structure to validate our predictions with actual values

pred<-prediction(predicted,Final$`10Good_1Bad_Rate_Chips_TargetRate`)

perf <- performance(pred,"acc")
class(perf)
perf

# x values contain the cut-off probabilities

#use @ to access the slots

class(perf@x.values)
cutoffprob <- as.numeric(unlist(perf@x.values))

cutoffprob
class(perf@y.values)
accuracies <- as.numeric(unlist(perf@y.values))

cutoffs <- data.frame(cutoffprob, accuracies )
# In the decreasing order of accuracy
cutoffs <- cutoffs[order(cutoffs$accuracies, decreasing=TRUE),]

# Accuracy is highest at 0.5746324
predbkt<-ifelse(predicted>0.5746324,'G','B')
table(predbkt,Final$`10Good_1Bad_Rate_Chips_TargetRate`)

(9147+7954)/(9147+7954+4000+3013)
perf<-performance(pred,"tpr","fpr") #tpr=TP/P fpr=FP/N
plot(perf,col="red")

#Validation of Model
#Predicted values

predictedvalues <- predict(logRegModel, type="response",newdata = Final)
head(predictedvalues)
tail(predictedvalues)


table(Final$`10Good_1Bad_Rate_Chips_TargetRate` / nrow(Final))






Q1 <- Final%>%group_by(Farm_grown_ingredients_Chips)%>%summarise(Count=n(),Percent_Count = n()/count(Final))%>%ungroup()%>%data.frame()
str(Q1)
View(Q1)

Q2 <- Final%>%group_by(zero_grams_transfat_Chips)%>%summarise(Count=n(),Percent_Count = n()/count(Final))%>%ungroup()%>%data.frame()
str(Q2)
View(Q2)


Q3 <- Final%>%group_by(Natural_oil_Used_Chips)%>%summarise(Count=n(),Percent_Count = n()/count(Final))%>%ungroup()%>%data.frame()
str(Q3)
View(Q3)