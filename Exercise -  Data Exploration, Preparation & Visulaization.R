########## PROBLEM STATEMENT ############### 

# To predict the (charges) medical expenses by customers

########## DATA EXPLORATION ###########

# Step I : Create a data dictionary first and find out the data types

setwd("E:\\Data Science with R\\Datasets")
expenses <- read.csv("expenses.csv", stringsAsFactors = T)

dim(expenses)
str(expenses)
View(expenses)

# Step II: Data Tabulation

table(expenses$sex)
table(expenses$smoker)
table(expenses$region)


# Cross tabulation

table(expenses$sex, expenses$smoker)
table(expenses$sex, expenses$smoker, expenses$region)


# Step III : Data Summaries
# Check for missing NA values -  Many models do not work with missing values


summary(expenses)
fivenum(expense$age)
is.na(expenses$bmi)
sum(is.na(expenses$bmi))

colSums(is.na(expense))


missindex <- which(is.na(expense$bmi))
missindex

# Step IV: Univariate and Bivariate visualization

summary(expenses$age)

# Check for outliers and report them

x <- boxplot(expense$age)
x
class(x)
class(x$out)
list <- x$out

b <- boxplot(expenses$bmi)
b$out
summary(expense$bmi)
# There are two outliers 90 and 95

# At which positions are the outliers lying?

index <- which(expense$age %in% list)
index

# 15th and 16th elements are outliers

expenses$age[index]
expenses$age[15]
expenses$age[16]

# Univariate Visualization

library("ggplot2")
qplot(expense$bmi)
hist(expense$bmi)
hist(expense$age)


# Bivariate Visualization

plot(expense$age,expense$charges)
qplot(expense$age,expense$charges)
with(expense,qplot(age, charges))


# Answer the following Questions as part of Data Exploration


# Do males generally have higher expenses than females?

library(dplyr)
expense %>% group_by(sex) %>% summarise(mean(charges))
# Ans: yes


# Is there any relationship between region and medical expenses?

expense %>% group_by(region) %>% summarise(mean(charges))

summary(expense)
str(expenses)
# Do patients with less or no children have lower medical expenses?


plot(expenses$children,expenses$charges)

expenses %>% group_by(children) %>% summarise(mean(charges))

qplot(expenses$children, expenses$charges)

plot(expenses$children, expenses$charges)

boxplot(expenses$children, expenses$charges)

# Not necessarily. In fact, people with 4 or 5 children have less medical expenses.

# Does smoking lead to higher medical expenses?

expenses %>% group_by(smoker) %>% summarise(mean(charges))

# Ans. Yes

# What is the correlation between bmi and medical expenses?

plot(expenses$bmi,expenses$charges)



########### DATA PREPARATION ##########

# First treat outliers and then treat missing values

# There are 3 ways to deal with outliers & missing values

# Ignore or remove or impute

# Easiest way to replace with mean or median depending upon skewness

# Impute with mean

index <- which(expenses$age %in% list)
index

mean(expenses$age)
index
age_without_outliers <- expenses$age[-index]

mean_sw <- mean(age_without_outliers)
mean_sw

expenses$age[index]

expenses$age[index] <- mean_sw

expenses$age[index]

y <- boxplot(expenses$age)
y
summary(expenses$age)

seq(1,10,5)


x <- boxplot(expenses$age)
x
list<-x$out
list
index <- which(expenses$age %in% list)
index
quantile(expense$age,seq(0,1,0.01))
expenses$age[index] <- 64




# Outliers can also be replaced with percentile values

expense$age[which(ntile(expense$age,100)==99)]


# Treating missing values


# Removing all observations containing missing values from dataset

summary(expenses)
missindex <- which(is.na(expenses$bmi))
missindex

expenseswithoutmissing  <- expenses[-missindex,]

# expenseswithoutmissing = na.omit(expenses) can also be used

summary(expenseswithoutmissing)
dim(expenseswithoutmissing)
missindex <- which(is.na(expenseswithoutmissing$bmi))
missindex

# Imputing individual column missing values with mean

missindex <- which(is.na(expenses$bmi))
missindex


missindex <- which(is.na(expenses$bmi))
expenses$bmi[missindex] <-  mean(expenses$bmi, na.rm = T)




missindex <- which(is.na(expenses$bmi))
missindex
summary(expenses)
dim(expenses)

cor(x=expense$bmi,y=expense$charges)

# 23.	Transform qualitative data into quantitative data

expenses$female<- ifelse(expenses$sex == 'female',1,0) 

# Partition the data (70/30) into training and validation datasets.

?sample
sampling<-sort(sample(nrow(expense), nrow(expense)*.7))

class(sampling)
nrow(expense)
nrow(expense)*.7
length(sampling)
colSums(is.na(expense))
#Row subset and create training and validation samples using the index numbers

train<-expenses[sampling,]
test<-expenses[-sampling,]
nrow(train)
nrow(test)

