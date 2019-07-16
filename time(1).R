setwd("G:/timeseries")
#install.packages("forecast")
library(forecast)

#install.packages("tseries")
library(tseries)
milk<-read.csv("milk.csv",stringsAsFactors = F)
View(milk)
milk<-milk[-1]#milk<-milk[,-1]
View(milk)
dim(milk)
sum(is.na(milk))# if there are missing values impute or ask for the data
class(milk)
warnings()



#convert the type of milk from dataframe to timeseries

?ts
ml<-ts(milk,start=1962,frequency=12)
class(ml)
ml
start(ml)
end(ml)
frequency(ml)
cycle(ml)
plot(ml)



#Explore the time series

#Aggregating the time series

?aggregate
aggregate(ml)
plot(aggregate(ml))

#increasing trend

aggregate(ml,FUN=mean)
plot(aggregate(ml,FUN=mean))

aggregate(ml,FUN=sum)
plot(aggregate(ml,FUN=sum))

#milk production has been increasingg year after year
#boxplot create boxplot for each month

b1<-boxplot(ml~cycle(ml))
b1



#partiontiong is not possible in time series ,so we window function
#two window function(1962-1971dec)  and (1972 jan to 1974 dec)
#creating training and testing dataset resp.
#frequency is the no.of time period in a year

mltr<-window(ml,start=c(1962,1),end=c(1971,12),frequency=12)
dim(mltr)



mlt<-window(ml,start=c(1972,1),end=c(1974,12),frequency=12)
dim(mlt)

plot(mltr)
plot(mlt)

#we shall create a time series model on (1962-1972)
# and forecast for the period (1972-1974) 
#we shallthen compare the forecasts with the actual time series

#data has both trend and sesonality
#Decompose the time series into seasonal,trend and irregular
#components with additive seasonality


?decompose
dec<-decompose(mltr)
plot(dec)

#top panel contains the original time series
#second panel contains the trend

#3rd contains the sesonality
#4th contains random

#exponential smoothing on training window dataset

#naive method based on last month
#avg is based on taking avg of previous months
#SES- simple exponential smoothing(takes moving avg and gives more weightage to recent obs)


?ses
#to forecast milk production for the next 10 months

es<-ses(mltr,h=10)#h =no. of periods for forecasting


plot(es)
summary(es)

es$x
es$fitted
es$residuals


100*es$residuals/es$x  #PE
mean(abs(100*es$residuals/es$x)) #MAPE


#Finding the accuracy of exponential smoothing model(with respect to testing model)
accuracy(es,mlt)

#checking residuals
checkresiduals(es)

#there is a pattern in the residuals, therefore this forecast is 
#not sufficiently an accurate forecast,
#hence we use Holt's method



#Fitting Holt's model
hol<-holt(mltr,h=10)#forecasting for 10 periods
plot(hol)
summary(hol)
accuracy(hol,mlt)
checkresiduals(hol)


?Box.test
Box.test(hol$residuals,lag=20,type="Ljung-Bo")

?checkresiduals
#blue line is slightly elevated,meaning that this forecast is between the previous one.
#the Ljung-Box test reveals that p-value is low
#Ho:Data is identically and independently distributed (white noise)
#Ha:Data is not identically and independently distributed(exihibits serial correlation)
#Therefore we reject Ho and conclude tat data exhibits serial correlation


#clearly the series is seasonal so sesonal component is required
?hw
hwts<-hw(mltr,h=10)
hwts

plot(hwts)
accuracy(hwts,mlt)
summary(hwts)
checkresiduals(hwts)


#p-value is 0.1154 is high, indicating that data ia identically and independently distributed
#All spikes are below the blue line
#there is no pattern in the residuals
#Histogram is also closer to bell-shaped

#Automating model building using ets()
?ets()#Exponential smoothing state space model
auto<-ets(mltr)
summary(auto)


#the MAPE is less than 7 and it seems like a good MAPE

foc<-forecast(auto,h=10)
foc
plot(foc)

checkresiduals(foc)


#p-value is greater than 0.05


#ARIMA(Auto Regressive integrated Moving Average)

auto.arima(mltr)
#ARIMA(0,1,0)(0,1,1)[12] --->p=0,d=1,q=0(trend),p=0.d=1.q=1 for seasonal

?arima
mltrarima<-arima(mltr,c(0,1,0),seasonal=list(order=c(0,1,1),period=12))
mltrarima
summary()

mltrarimaF<-forecast(mltrarima,h=10)
plot(mltrarimaF)


#validating the model
checkresiduals(mltrarimaF)
mltrarimaF




#related to capstone project

install.packages("dataQualityR")
library(dataQualityR)
checkDataQuality(mtcars,out.file.num="Numeric.csv",out.file.cat="Character.csv")
getwd()
