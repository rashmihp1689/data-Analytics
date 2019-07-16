#install.packages("fpp")
library(fpp)
a<-austourists
View(a)
length(a)
sum(is.na(a))# if there are missing values impute or ask for the data
class(a)

start(a)
end(a)
frequency(a)
cycle(a)
plot(a)



#Aggregating the time series

?aggregate
aggregate(a)
plot(aggregate(a))


#increasing trend

aggregate(a,FUN=mean)
plot(aggregate(a,FUN=mean))

aggregate(a,FUN=sum)
plot(aggregate(a,FUN=sum))

#milk production has been increasingg year after year
#boxplot create boxplot for each month

a1<-boxplot(a~cycle(a))
a1



a2<-window(a,start=c(1999,1), end=c(2007,4), frequency=4)
length(a2)



ml<-window(a,start=c(2008,1),end=c(2010,4),frequency=4)
length(ml)

plot(a2)
plot(ml)



#Automating model building using ets()
?ets()#Exponential smoothing state space model
auto<-ets(a2)
summary(auto)



foc<-forecast(auto,h=12)
foc
plot(foc)

checkresiduals(foc)


#ARIMA(Auto Regressive integrated Moving Average)

auto.arima(a2)
#ARIMA(1,0,0)(1,1,0)[4] --->p=0,d=1,q=0(trend),p=0.d=1.q=1 for seasonal

?arima
mlarima<-arima(a2,c(1,0,0),seasonal=list(order=c(1,1,0),period=4))
mlarima
summary(mlarima)

mlarimaF<-forecast(mlarima,h=12)
plot(mlarimaF)


#validating the model
checkresiduals(mlarimaF)
mlarimaF
