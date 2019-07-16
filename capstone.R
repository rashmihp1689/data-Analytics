getwd()
setwd("E:/jig/cap")
data=read.csv("sampletelecomfinal.csv",stringsAsFactors = T)
library(dplyr)


#data quality report

#install.packages("dataQualityR")
library(dataQualityR)
checkDataQuality(data,out.file.num="Numeric1.csv",out.file.cat="Character1.csv")
?`dataQualityR-package`
summary(data)
colnames(data)
tele<-data[,-c(46,47,48,49,52,55,61,62,63,64,66,72)]


colnames(tele)

tele<-tele[,-c(56)]


# Frequency Distribution of the binary dependent variable 

table(tele$churn)
table(tele$churn)/nrow(tele)
summary(tele)
#--crosstab of crclscod and churn
table(tele$crclscod,tele$churn)



tele$New_refurb=ifelse(tele$refurb_new=="R",1,0)
dim(tele)
tele<-select(tele,-refurb_new)
dim(tele)



#asl_flag 
tele$asl_flag<-ifelse(tele$asl_flag=="Y",1,0)
str(tele)


#Checking for missing values in all the columns

colSums(is.na(tele))

summary(tele)
colnames(tele)
sum(is.na(tele))
str(tele)

#derived variables
tele$comp_per<-tele$comp_vce_Mean/tele$plcd_vce_Mean
colnames(tele)
#Missing Value treatment for variable "retdays" and Creating Dummy Variable
summary(tele$retdays)
sort(unique(tele$retdays), na.last = F)
tele$retdays1<-ifelse(is.na(tele$retdays)==TRUE, 0, 1)
str(tele$retdays1)
summary(tele$retdays1)

colnames(tele)
tele<-tele[,-c(47)]

#install.packages("VIM",dependencies = T)
#install.packages("abind",dependencies = T)
#library(abind)
library(VIM)
tele=kNN(tele)
summary(tele)
colnames(tele)
tele=select(tele,-c(68:134))





tele$East<-ifelse(tele$area=="TENNESSEE aREA" | tele$area=="OHIO AREA" |tele$area=="GREAT LAKES AREA"|tele$area=="NEW ENGLAND AREA"|
                    tele$area=="DC/MARYLAND/VIRGINIA AREA"|tele$area=="NEW YORK CITY AREA"|tele$area=="CHICAGO AREA" | tele$area=="PHILADELPHIA AREA",1,0)

tele$North<-ifelse(tele$area=="NORTHWEST/ROCKY MOUNTAIN AREA",1,0)

tele$South<-ifelse(tele$area=="CENTRAL/SOUTH TEXAS AREA" | tele$area=="HOUSTON AREA" |
                      tele$area=="ATLANTIC SOUTH AREA" | tele$area=="SOUTHWEST AREA"
                    | tele$area=="NORTH FLORIDA AREA"|tele$area=="DALLAS AREA"|tele$area=="SOUTH FLORIDA AREA",1,0)
tele$West<-ifelse(tele$area=="MIDWEST AREA"|tele$area=="LOS ANGELES AREA"|tele$area=="CALIFORNIA NORTH AREA",1,0)
tele<-select(tele,-area)


#table(tele$ethnic,tele$churn)
tele$ethnicgp1<-ifelse(tele$ethnic=="X"|tele$ethnic=="C"|tele$ethnic=="P"|tele$ethnic=="M"|tele$ethnic=="Z",1,0)
tele$ethnicgp2<-ifelse(tele$ethnic=="F"|tele$ethnic=="N"|tele$ethnic=="B"|tele$ethnic=="I"|tele$ethnic=="J"|tele$ethnic=="U"|tele$ethnic=="H"|tele$ethnic=="S"|tele$ethnic=="G"|tele$ethnic=="R",1,0)
tele$ethnicgp3<-ifelse(tele$ethnic=="D"|tele$ethnic=="O",1,0)
tele<-select(tele,-ethnic)


tele$non_optimal<-tele$ovrrev_Mean/tele$totrev
tele$non_optimal_rateplan<-ifelse(tele$ovrrev_Mean>0,tele$non_optimal,0)
tele<-select(tele,-non_optimal)

#table(tele$marital,tele$churn)
tele$maritalA<-ifelse(tele$marital=="A",1,0)
tele$maritalB<-ifelse(tele$marital=="B",1,0)
tele$maritalM<-ifelse(tele$marital=="M",1,0)
tele$maritalS<-ifelse(tele$marital=="S",1,0)
tele$maritalU<-ifelse(tele$marital=="U",1,0)

tele<-select(tele,-marital)

#table(tele$car_buy,tele$churn)
tele$car_buy1<-ifelse(tele$car_buy=="New",1,0)
tele$car_buy2<-ifelse(tele$car_buy=="UNKNOWN",1,0)
tele<-select(tele,-car_buy)

#table(tele$hnd_webcap,tele$churn)
tele$hnd_webcap1<-ifelse(tele$hnd_webcap=="UNKW",1,0)
tele$hnd_webcap2<-ifelse(tele$hnd_webcap=="WC",1,0)
tele$hnd_webcap3<-ifelse(tele$hnd_webcap=="WCMB",1,0)
tele<-select(tele,-hnd_webcap)


#table(tele$prizm_social_one,tele$churn)
tele$prizm_socialSUTC<-ifelse(tele$prizm_social_one=="S"|tele$prizm_social_one=="U"|tele$prizm_social_one=="T"|tele$prizm_social_one=="C",1,0)
tele$prizm_socialR<-ifelse(tele$prizm_social_one=="R",1,0)
tele<-select(tele,-prizm_social_one)


colnames(tele)
mobi<-tele[,-c(31)]
set.seed(200)
sampling<-sort(sample(nrow(mobi), nrow(mobi)*.7))

length(sampling)


#Row subset and create training and validation samples using the index numbers

train<-mobi[sampling,]
test<-mobi[-sampling,]
nrow(train)

nrow(test)

# Checking the frequency Distribution of the target variable 

table(tele$churn)/13259
table(train$churn)/9281
table(test$churn)/3978




str(test)
str(train)
install.packages("corrplot",dependencies = T)
library(corrplot)

#Finding correlation between numeric variables 

colnames(train)
traincor<-cor(train)
install.packages("corrgram",dependencies = T)
install.packages("fpc")
library(corrgram)
??corrgram #The corrgram function produces a graphical 
#display of a correlation matrix, called a correlogram. 
#The cells of the matrix can be shaded or colored to show the correlation value.

cormat<-corrgram(traincor)

write.csv(cormat,"Correlation.csv")


library(rio)
#install.packages("rio")
#install_formats("rio")



str(train)
colnames(train)
?glm()
# Family of dependent variable is binary or binomial 
myresult<-glm(data=train,churn ~ mou_Mean+totmrc_Mean+rev_Mean+change_mou+drop_blk_Mean+
                owylis_vce_Range+mou_opkv_Range+months+totcalls+income+eqpdays+
                custcare_Mean+callwait_Mean+iwylis_vce_Mean+ccrndmou_Range+
                ovrmou_Mean+asl_flag+prizm_socialSUTC+East+North+South+
                hnd_webcap1+hnd_webcap2+maritalU+maritalB+maritalM+maritalS+ethnicgp2+
                ethnicgp3+age1+age2+models+hnd_price+uniqsubs+forgntvl+opk_dat_Mean+avgrev+
                mtrcycle+truck+recv_sms_Mean+blck_dat_Mean+mou_pead_Mean+car_buy1+da_Mean+
                datovr_Mean+drop_dat_Mean+retdays1+New_refurb+comp_per+non_optimal_rateplan,family=binomial)


summary(myresult)



?step
reduced<-step(myresult,direction="backward")

summary(reduced)

myresult1<-glm(data=train,churn ~ mou_Mean + totmrc_Mean + rev_Mean + change_mou + 
                 owylis_vce_Range + months + eqpdays + ovrmou_Mean + asl_flag + 
                 prizm_socialSUTC + East + North + hnd_webcap2 + ethnicgp2 + 
                 ethnicgp3 + age1 + models + hnd_price + uniqsubs + avgrev + 
                 blck_dat_Mean + mou_pead_Mean + retdays1 + comp_per + non_optimal_rateplan,family = binomial)

summary(myresult1)

reduced<-step(myresult1,direction="backward")
summary(reduced)
myresult2<-glm(data=train,churn ~ mou_Mean + totmrc_Mean + rev_Mean+owylis_vce_Range+ 
                 months + eqpdays +  asl_flag + North +  ethnicgp2 + 
                 ethnicgp3 + age1 + models + hnd_price + uniqsubs + 
                 avgrev + retdays1 + comp_per + 
                 non_optimal_rateplan,family=binomial)

summary(myresult2)


#Finding Predicted Values

?glm

myresult2$fitted.values


train$predicted <- myresult2$fitted.values
train$predicted

# Compare with actual data

head(train$churn)

head(train$predicted)

# Let us convert the probabilities also into churn/Not  response 
# based on a cut-off probability

#Confusion Matrix
train$predclass<-ifelse(train$predicted>0.5,1,0)
table(train$predclass,train$churn)







#True Positive+ True Negative should be high. 

# Accuracy = (TP+TN)/(P+N)

(7033+75)/(7033+75+52+2121)


#install.packages("ROCR")
library(ROCR)
#Reciever Operating Characteristic Curve = ROCR

# The prediction function of the ROCR library basically creates 
# a structure to validate our predictions with actual values

pred<-prediction(train$predicted,train$churn)
class(pred)

?performance

perf <- performance(pred,"acc") #acc considers accuracy for all possible cut-offs
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
View(cutoffs)

# In the decreasing order of accuracy
cutoffs <- cutoffs[order(cutoffs$accuracies, decreasing=TRUE),]

# Pick cutoff for which Accuracy is highest 

train$predclass <- ifelse(train$predicted>0.5235211,1,0)

# Kappa values and Confusion Matrix from caret package

#install.packages("caret")
library(caret)
#install.packages("irr")
library(irr)

kappa2(data.frame(train$churn,train$predclass))  


#install.packages("e1071")
library(e1071)
confusionMatrix(as.factor(train$churn),as.factor(train$predclass), positive = "1")


## computing a simple ROC curve 

?  performance

perf<-performance(pred,"tpr","fpr") #tpr=TP/P fpr=FP/N
plot(perf,col="red")


?abline
abline(0,1, lty = 8, col = "blue")




auc<-performance(pred,"auc")
auc

#Creating a Gains chart

#install.packages("gains")

#install.packages("gains")
library(gains)


gains(as.numeric(train$churn),train$predicted, groups =10)
quantile(train$predicted, seq(0,1,0.1))  #divides into 10 parts

#From gains chart, More than 70% of the people are with 1 attribute (means who are likely to quit)
#Looking at deciles we get the % above which we neeed to capture.
#at 70% it is 0.26925714. Picking those above this % gives the top 70% who are likely to leave

targeted <- which(train$predicted >= 0.26925714)
targeted

# To obtain predictions from the model, use the predict() function.

?predict()
test$pred <- predict(myresult2, type = "response",newdata = test)
test$pred
#model name is myresult2
View(test)

# The value 'response' to the parameter type would make sure 
# that these predictions are returned as probability of events.


#testing the model with test sample

# Compare with actual data

head(test$churn)

head(test$pred)

# Let us convert the probabilities also into churn/Not response 
# based on a cut-off probability

#Confusion Matrix
test$predclass<-ifelse(test$pred>0.5,1,0)
table(test$predclass,test$churn)







#True Positive+ True Negative should be high. 

# Accuracy = (TP+TN)/(P+N)

(3028+26)/(3028+26+27+897)


#install.packages("ROCR")
library(ROCR)
#Reciever Operating Characteristic Curve = ROCR


pred1<-prediction(test$pred,test$churn)
class(pred1)

?performance

perf <- performance(pred1,"acc") #acc considers accuracy for all possible cut-offs
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
View(cutoffs)

# In the decreasing order of accuracy
cutoffs <- cutoffs[order(cutoffs$accuracies, decreasing=TRUE),]

# Pick cutoff for which Accuracy is highest 

test$predclass <- ifelse(test$pred>0.6814172,1,0)

# Kappa values and Confusion Matrix from caret package

#install.packages("caret")
library(caret)
#install.packages("irr")
library(irr)

kappa2(data.frame(test$churn,test$predclass))  


#install.packages("e1071")
library(e1071)
confusionMatrix(as.factor(test$churn),as.factor(test$predclass), positive = "1")




perf<-performance(pred1,"tpr","fpr") #tpr=TP/P fpr=FP/N
plot(perf,col="red")


?abline
abline(0,1, lty = 8, col = "blue")


# Area under the curve should be more than 50%

auc<-performance(pred1,"auc")
auc

#Creating a Gains chart

#install.packages("gains")

#install.packages("gains")
library(gains)


gains(as.numeric(test$churn),test$pred, groups =10)
quantile(test$pred, seq(0,1,0.1))  #divides into 10 parts

#From gains chart, More than 70% of the people are with 1 attribute (means who are likely to quit)
#Looking at deciles we get the % above which we neeed to capture.
#at 70% it is 0.26587086355. Picking those above this % gives the top 70% who are likely to leave

targeted <- which(test$pred >= 0.27008961)
targeted










summary(mobi$totrev)

# Creating a table of target group of customers with high revenue range and high probability of churn

test$Targetgrp<-ifelse(test$pred<0.2,"Low",ifelse(test$pred>=0.2&test$pred<0.3,"Med","High"))

test$revgrp<-ifelse(test$totrev>1100,"High_Rev",
                    ifelse(test$totrev>600,"Medium_Rev","Low_Rev"))

table(test$Targetgrp,test$revgrp)

#Extracting rows of test data where probability of churn is high and revenue is also high
Target_customer_IDs<-filter(test, Targetgrp=="High" | revgrp=="High_Rev")
Target_customer_IDs
# Customer IDs of such customers with high revenue and high probability of churn
TCID<-Target_customer_IDs$Customer_ID
View(TCID)


