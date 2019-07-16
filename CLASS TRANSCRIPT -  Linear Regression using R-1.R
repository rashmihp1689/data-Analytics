# Case study on Marketing Mix Model (MMX).

setwd("G:/Linear Regression")
mmix <- read.csv("simpleotc.csv", header = T, stringsAsFactors = T)

# Data Exploration

dim(mmix)
str(mmix)
View(mmix)
summary(mmix)

# Data Tabulation

table(mmix$Website.Campaign)
table(mmix$NewspaperInserts)
unique(mmix$Website.Campaign)

# Data Summaries

summary(mmix)

# Check for outliers in the dependent variable

hist(mmix$NewVolSales)

?boxplot
x <- boxplot(mmix$NewVolSales)
x
out <- x$out
out

# Remove Outliers from the dependent variable

index <- which(mmix$NewVolSales %in% x$out)
index
mmixnonout <- mmix[-index,]
dim(mmixnonout)

# Check for missing values

summary(mmix)

library("ggplot2")

# Univariate visualization

qplot(mmixnonout$NewVolSales)
hist(mmixnonout$NewVolSales)  # positively skewed
hist(mmixnonout$Price) # negatively skewed

# Bivariate Visualization

qplot(mmixnonout$Price, mmixnonout$NewVolSales)
with(mmixnonout,qplot(Price,NewVolSales)) # Negative Correlation
with(mmixnonout,qplot(Instore,NewVolSales)) # Positive Correlation
qplot(mmixnonout$NewVolSales,mmixnonout$Radio) # No correlation


# Check correlation values

cor(mmixnonout$NewVolSales, mmixnonout$Price)
cor(mmixnonout$NewVolSales, mmixnonout$Radio)
with(mmixnonout, cor(NewVolSales, Radio))
with(mmixnonout, cor(NewVolSales, Instore))



# Plotting after doing Log Transformation
with(mmixnonout,qplot(Instore, log(NewVolSales)))


# Convert categoric to numeric variables or dummy variables

mmixnonout$npinsert <- ifelse(mmixnonout$NewspaperInserts == "Insert",1,0)
mmixnonout$fb <- ifelse(mmixnonout$Website.Campaign == 'Facebook',1,0)
mmixnonout$tw <- ifelse(mmixnonout$Website.Campaign == 'Twitter',1,0)
mmixnonout$webcamp <- ifelse(trimws(mmixnonout$Website.Campaign) == "Website Campaign",1,0)
#try  doing the abov ething for a single column instead of doing it separetely
View(mmixnonout)

# Log transformation

mmixnonout$LnSales = log(mmixnonout$NewVolSales)
mmixnonout$LnPrice = log(mmixnonout$Price)
mmixnonout$offlineSpend = mmixnonout$Radio+ mmixnonout$TV + mmixnonout$Instore


# Creating Price Buckets

summary(mmixnonout$Price)
mmixnonout$Price_Bkt[mmixnonout$Price <= 2.71] <- 'Low'
mmixnonout$Price_Bkt[mmixnonout$Price >= 2.71 & mmixnonout$Price <= 2.732] <- 'Avg'
mmixnonout$Price_Bkt[mmixnonout$Price >= 2.732 & mmixnonout$Price <= 2.75] <- 'High'
mmixnonout$Price_Bkt[mmixnonout$Price >=  2.75] <- 'Very High'

or

mmixnonout[mmixnonout$Price<=2.71,"pricebkt"]<-"Low"

View(mmixnonout)

str(mmixnonout)


# ==== Data Exploration & Preparation ends=====#

# ----------Building the model -----------------#

?lm

# lm function is used to fit linear models. 
# It can be used to carry out regression.

# Sinple Linear Regression

Reg <- lm(NewVolSales ~ Price, data = mmixnonout)
Reg
summary(Reg)

#NewVolsales=98162-28633(here 98162 is Beta0)

# When price is increased by INR 1, NewVolSales decreases by 28633

# Multivariate Linear Regression Iteration # 1

MulReg <- lm(NewVolSales ~ Price+Instore+webcamp, mmixnonout)
MulReg
summary(MulReg)

# Multivariate Linear Regression Iteration # 2

str(mmixnonout)
MulReg <- lm(NewVolSales ~ Price+Radio+StockOut.+TV+Discount
             +npinsert+Instore+fb+tw+webcamp, mmixnonout)
class(MulReg)
MulReg
summary(MulReg)
formula(MulReg)

# Multivariate Linear Regression Iteration # 3

MulReg <- lm(NewVolSales ~ Price+StockOut.+Instore+webcamp, mmixnonout)
MulReg
summary(MulReg)
formula(MulReg)

# Multivariate Linear Regression Iteration # 4

colnames(mmixnonout)
MulReg <- lm(NewVolSales ~ Price+Radio+StockOut.+TV+Instore+
               Discount+npinsert+fb+tw+webcamp, mmixnonout)
step(MulReg,direction = "backward")

# Multivariate Linear Regression Iteration # 5

MulReg <- lm(NewVolSales ~ Price + Radio + StockOut. + Instore + Discount + 
               tw + webcamp, mmixnonout)
summary(MulReg)





#Finding predicted values
predsales <- predict(MulReg, data = mmixnonout)
predsales
class(predsales)
length(predsales)
head(predsales)
mmixnonout$pred <- predsales

#Finding Residuals

?resid
resi <- resid(MulReg)
resi

# Predicted values and residuals can also be extracted 
# from MulReg object

MulReg$fitted.values
MulReg$residuals
mmixnonout$residuals <- MulReg$residuals
View(mmixnonout)
summary(mmixnonout$residuals)

#Residuals should be homoscedastic


plot(mmixnonout$residuals)
View(mmixnonout)
qplot(mmixnonout$pred,mmixnonout$residuals)


#residuals should be normally distributed

hist(mmixnonout$residuals)
install.packages("car")
library(car)

qqPlot(mmixnonout$residuals)




# Creating Fit Chart(ploting actual and predicted together)

library(ggplot2)

qplot(mmixnonout$NewVolSales,mmixnonout$pred)
dat<-data.frame(act=mmixnonout$NewVolSales,est=mmixnonout$pred)
rnum<-as.numeric(rownames(dat))
View(rnum)


p<-ggplot(dat,aes(x=rnum,y=act))
p+geom_line(color="blue")+geom_line(data=dat,aes(y=est),color="green")



#mean Absolute percentage error(MAPE)[average og absolute percentage error]   ((actual-predicate)/actual)*100

mmixnonout$PE<-(abs(mmixnonout$residuals)/mmixnonout$NewVolSales)*100

MAPE<-mean(mmixnonout$PE)

MAPE

#MAPE below 5% is good





p<-ggplot(mmixnonout,aes(x=as.numeric(rownames(mmixnonout))))
p+geom_line(aes(y=mmixnonout$NewVolSales, color = "green"))+geom_line(aes(y= mmixnonout$pred,color="blue"))

#Scatter plot between actual and predicted
qplot(mmixnonout$NewVolSales, mmixnonout$pred)
cor(mmixnonout$NewVolSales, mmixnonout$pred)

# Checking multicollinearity
#install.packages("corrgram")
library(corrgram)
cormic<-corrgram(mmixnonout)
cormat<-corrgram(mmixnonout[,c(2:7,10:13,17)])
write.csv(cormat,"Correlation.csv")
#Using vif function

install.packages("car",dependencies = T)
library(car)
?vif
vif(MulReg)
#vif-Variance inflation factor
# Low vif values (<5) indicate absence of multicollinearity


#there is no multicollinearity
#Checking for heteroscadeasticity
p<-ggplot(mmixnonout,aes(x=as.numeric(rownames(mmixnonout))))
p+geom_point(aes(y=mmixnonout$residuals, color = "red"))

# Checking for normality of residuals

hist(mmixnonout$residuals)
summary(mmixnonout$residuals)

