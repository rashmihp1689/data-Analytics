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
