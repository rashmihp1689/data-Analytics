#-------Importing the data---------
setwd("G:/logistic")
pat<-read.csv("Patient Data.csv")

# Data Exploration

dim(pat)
str(pat)
View(pat)


pat$Male<-ifelse(pat$SEX=="M",1,0)
pat$Female<-ifelse(pat$SEX=="F",1,0)


# Frequency Distribution of the binary dependent variable 

table(pat$HEARTFAILURE)
table(pat$HEARTFAILURE)/nrow(pat)


colSums(is.na(pat))


# No missing values

# Partition the dataset into training and validation dataset

sampling<-sort(sample(nrow(pat), nrow(pat)*.7))

length(sampling)



#Row subset and create training and validation samples using the index numbers

train<-pat[sampling,]
test<-pat[-sampling,]
nrow(train)
nrow(test)



# Checking the frequency Distribution of the target variable 

table(pat$HEARTFAILURE)
table(train$HEARTFAILURE)/7559
table(test$HEARTFAILURE)/3241



#install.packages("corrplot",dependencies = T)
library(corrplot)

#Finding correlation between numeric variables 

str(train)
traincor<-cor(train[,-c(5,6)])
#install.packages("corrgram")
library(corrgram)


train$FAMILYHISTORY<-as.numeric(train$FAMILYHISTORY)-1 
test$FAMILYHISTORY<-as.numeric(test$FAMILYHISTORY)-1 

train$SMOKERLAST5YRS<-as.numeric(train$SMOKERLAST5YRS)-1 
test$SMOKERLAST5YRS<-as.numeric(test$SMOKERLAST5YRS)-1 

#Finding correlation between numeric variables 

str(train)

traincor<-cor(train[,-c(5,7)])
#install.packages("corrgram")
library(corrgram)



?corrgram
cormat<-corrgram(traincor)

write.csv(cormat,"Correlation.csv")


library(rio)
#install.packages("rio")
#install_formats("rio")
# After Conditional formatting, we find :
# High correlation between:
# Job Level and Monthly Income
# Job Level and Total Working Years
# Monthly Income and Total Working Years
# Percent Salary Hike and Performance Rating

str(train)
colnames(train)
?glm()
# Family of dependent variable is binary or binomial 
myresult<-glm(data=train,HEARTFAILURE ~ AVGHEARTBEATSPERMIN+PALPITATIONSPERDAY+CHOLESTEROL+BMI+SEX+
                AGE+FAMILYHISTORY+SMOKERLAST5YRS+EXERCISEMINPERWEEK,family=binomial)


summary(myresult)


?step
reduced<-step(myresult,direction="backward")



# Iteration 2: 
myresult<-glm(data=train,HEARTFAILURE ~ AVGHEARTBEATSPERMIN + PALPITATIONSPERDAY + CHOLESTEROL + 
  BMI + AGE + FAMILYHISTORY + SMOKERLAST5YRS + EXERCISEMINPERWEEK)

summary(myresult)

# Iteration 3:
myresult<-glm(data=train,HEARTFAILURE ~ AVGHEARTBEATSPERMIN + PALPITATIONSPERDAY + 
                BMI + FAMILYHISTORY + SMOKERLAST5YRS + EXERCISEMINPERWEEK)

summary(myresult)






#Finding Predicted Values

?glm

myresult$fitted.values


train$predicted <- myresult$fitted.values
train$predicted


# Compare with actual data

head(train$HEARTFAILURE)

head(train$predicted)



# Let us convert the probabilities also into heartfailure/Not response 
# based on a cut-off probability

#Confusion Matrix
train$predclass<-ifelse(train$predicted>0.5,1,0)
table(train$predclass,train$HEARTFAILURE)



#True Positive+ True Negative should be high. 

# Accuracy = (TP+TN)/(P+N)

(6120+357)/(6120+357+178+904)

# There are a lot of performance parameters available in ROCR package

#install.packages("ROCR")#receiver operating characteristic curve
library(ROCR)


# The prediction function of the ROCR library basically creates 
# a structure to validate our predictions with actual values

pred<-prediction(train$predicted,train$HEARTFAILURE)
pred



?performance



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

# Pick cutoff for which Accuracy is highest 

train$predclass <- ifelse(train$predicted>0.4935620,1,0)

# Kappa values and Confusion Matrix from caret package
install.packages("caret",dependencies = TRUE)
install_formats("caret")
library(caret)
#install.packages("irr")
library(irr)



kappa2(data.frame(train$HEARTFAILURE,train$predclass))


confusionMatrix(as.factor(train$HEARTFAILURE),as.factor(train$predclass), positive = "1")



## computing a simple ROC curve (x-axis: fpr, y-axis: tpr)

perf<-performance(pred,"tpr","fpr") #tpr=TP/P fpr=FP/N
plot(perf,col="red")
# Receiver Operating Characteristic Curve (ROC) a plot of TPR versus FPR 
# for the possible cut-off classification probability values.
# A good ROC curve should be almost vertical in the beginning and 
# almost horizontal in the end.
# "tpr" and "fpr" are arguments of the "performance" function 
# indicating that the plot is between the true positive rate and 
# the false positive rate.

?abline
# Draw a straight line with intercept 0 and slope = 1
# lty is the line type (dotted or dashed etc.)
# The straight line is a random chance line
# ROC curve should be higher than the AB line


abline(0,1, lty = 8, col = "blue")


# Area under the curve should be more than 50%

auc<-performance(pred,"auc")
auc

#Creating a Gains chart

#install.packages("gains")

library(gains)


gains(as.numeric(train$HEARTFAILURE),train$predicted, groups =10)
quantile(train$predicted, seq(0,1,0.1))

targeted <- which(train$predicted >= 0.16995786)

targeted

# To obtain predictions from the model, use the predict() function.

?predict()
test$pred <- predict(myresult, type = "response",newdata = test)
test$pred

# The value 'response' to the parameter type would make sure 
# that these predictions are returned as probability of events.



myresult1<-glm(data=test,HEARTFAILURE ~ AVGHEARTBEATSPERMIN + PALPITATIONSPERDAY + 
                BMI + FAMILYHISTORY + SMOKERLAST5YRS + EXERCISEMINPERWEEK)

summary(myresult1)

