#-------Importing the data---------
setwd("G:/logistic")
hr<-read.csv("HR dataset for Employee Attrition.csv")

# Data Exploration

dim(hr)
str(hr)
View(hr)

# Convert Attrition to numeric variable

hr$AttritionTarget <- as.numeric(hr$Attrition)-1  #in levels No-1 and Yes-2 so to make yes as 1 and no as 0,we have made this conversion
View(hr)

# What is the ratio of Attrited vs. not Attritted?

# Frequency Distribution of the binary dependent variable 

table(hr$AttritionTarget)
table(hr$AttritionTarget)/nrow(hr)

#Checking for missing values in all the columns

colSums(is.na(hr))

# No missing values

# Partition the dataset into training and validation dataset

sampling<-sort(sample(nrow(hr), nrow(hr)*.7))

length(sampling)

#Row subset and create training and validation samples using the index numbers

train<-hr[sampling,]
test<-hr[-sampling,]
nrow(train)
nrow(test)

# Checking the frequency Distribution of the target variable 

table(train$AttritionTarget)
table(train$AttritionTarget)/1029
table(test$AttritionTarget)/441

#Renaming Age column

colnames(train)
names(train)[1] <- "Age"
colnames(test)
names(test)[1] <- "Age"

#Are any of the independent variables correlated?

#install.packages("corrplot", dependencies = T)
#install.packages("corrplot")

library(corrplot)

#Finding correlation between numeric variables 

str(train)
traincor<-cor(train[,c(1,4,6,7,11,13,14,15,17,19,20,21,24,25,26,28:35)])
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
myresult<-glm(data=train,AttritionTarget ~ Age+BusinessTravel+
+DailyRate+Department+DistanceFromHome+Education+
EnvironmentSatisfaction+Gender+HourlyRate+JobInvolvement+
JobSatisfaction+MaritalStatus+MonthlyIncome+MonthlyRate+
NumCompaniesWorked+OverTime+PercentSalaryHike+
RelationshipSatisfaction+StandardHours+StockOptionLevel+
TrainingTimesLastYear+WorkLifeBalance+YearsAtCompany+
YearsInCurrentRole+YearsSinceLastPromotion+YearsWithCurrManager,family=binomial)

summary(myresult)

#Coefficients: (1 not defined because of singularities)
#Estimate Std. Error z value Pr(>|z|)    
#(Intercept)                       4.701e+00  1.344e+00   3.499 0.000467 ***
#  Age                              -5.151e-02  1.543e-02  -3.338 0.000844 ***(as age increases log(odds ratio of prob decreases by -5.151e-02))




#(Dispersion parameter for binomial family taken to be 1)

#Null deviance: 909.34  on 1028  degrees of freedom
#Residual deviance: 561.00  on 1000  degrees of freedom(should be less than Null deviance)
#AIC: 619(Akaike information criteria,measure of lack of fit,the lower the model)
#Gives best fitted model
#To choose a good model


#gives best fitted model
#to choose a good model
?step
reduced<-step(myresult,direction="backward")


# Iteration 2: 
myresult<-glm(data=train,AttritionTarget ~ Age + BusinessTravel + DailyRate + Department + 
                DistanceFromHome + EnvironmentSatisfaction + Gender + JobInvolvement + 
                JobSatisfaction + MaritalStatus + MonthlyIncome + NumCompaniesWorked + 
                OverTime + RelationshipSatisfaction + TrainingTimesLastYear + 
                WorkLifeBalance + YearsAtCompany + YearsInCurrentRole + YearsSinceLastPromotion + 
                YearsWithCurrManager,family=binomial)

summary(myresult)

# Creating dummy variables

train$BTF <- ifelse(train$BusinessTravel == "Travel_Frequently",1,0)
train$OTY <- ifelse(train$OverTime == "Yes",1,0)

train$MS<-ifelse(train$MaritalStatus=="Single",1,0)

test$BTF <- ifelse(test$BusinessTravel == "Travel_Frequently",1,0)
test$OTY <- ifelse(test$OverTime == "Yes",1,0)
test$MS<-ifelse(test$MaritalStatus=="Single",1,0)
#Iteration # 3:9Retain significant variables)


myresult<-glm(data=train,AttritionTarget ~ Age+BTF +DistanceFromHome+ EnvironmentSatisfaction + JobInvolvement + 
                JobSatisfaction +MS+ MonthlyIncome + NumCompaniesWorked + 
                OTY +RelationshipSatisfaction+YearsInCurrentRole+ YearsSinceLastPromotion,family=binomial)

summary(myresult)

# Iteration # 4


myresult<-glm(data=train,AttritionTarget ~ BTF + EnvironmentSatisfaction + JobInvolvement + 
                JobSatisfaction + MonthlyIncome +  
                OTY,family=binomial)

summary(myresult)


#Finding Predicted Values

?glm

myresult$fitted.values


train$predicted <- myresult$fitted.values
train$predicted


# Compare with actual data

head(train$AttritionTarget)

head(train$predicted)

# Let us convert the probabilities also into Attrited/Not response 
# based on a cut-off probability

#Confusion Matrix
train$predclass<-ifelse(train$predicted>0.5,1,0)
table(train$predclass,train$AttritionTarget)

#True Positive+ True Negative should be high. 

# Accuracy = (TP+TN)/(P+N)

(837+72)/(837+72+94+26)

# For different cutoff probabilities, the confusion matrix will be different

# To find accuracies for different cut-off probabilities

# There are a lot of performance parameters available in ROCR package

#install.packages("ROCR")#receiver operating characteristic curve
library(ROCR)


# The prediction function of the ROCR library basically creates 
# a structure to validate our predictions with actual values

pred<-prediction(train$predicted,train$AttritionTarget)
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

train$predclass <- ifelse(train$predicted>0.5406100,1,0)

# Kappa values and Confusion Matrix from caret package
install.packages("caret",dependencies = TRUE)
install_formats("caret")
library(caret)
install.packages("irr")
library(irr)

kappa2(data.frame(train$AttritionTarget,train$predclass))

install.packages("e1071")
library(e1071)
confusionMatrix(as.factor(train$AttritionTarget),as.factor(train$predclass), positive = "1")


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


gains(as.numeric(train$AttritionTarget),train$predicted, groups =10)
quantile(train$predicted, seq(0,1,0.1))

targeted <- which(train$predicted >= 0.965606757)

targeted

# To obtain predictions from the model, use the predict() function.

?predict()
test$pred <- predict(myresult, type = "response",newdata = test)


# The value 'response' to the parameter type would make sure 
# that these predictions are returned as probability of events.

