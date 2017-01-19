Ye <-rnorm(100,mean = 0,sd=1)
Y <- list(length(Ye))

## MA(1)
Y[1] <-Ye[1]
for(i in 2:length(Ye)){
  Y[i] <- Ye[i]-(-0.8)*Ye[i-1]
}
Y <- ts(Y)
plot(Y,type='b',main='MA(1)')
abline(h=0)

## MA(2)
Y[1] <-Ye[1]
Y[2] <-Ye[2]-(-0.8)*Ye[1]
for(i in 2:length(Ye)){
  Y[i] <- Ye[i]-(-0.8)*Ye[i-1]#-(-0.9)*Ye[i-2]
}
Y <- ts(Y)
plot(Y,type='b',main='MA(2)')
abline(h=0)


## AR(1)
Y[1] <-Ye[1]
for(i in 2:length(Ye)){
  Y[i] <- Ye[i]-(-0.8)*Y[i]
  x <- Y[i]
}
Y <- ts(Y)
plot(Y,type='b',main='AR(1)')
abline(h=0)


##ARMA(1,1)
Y[1] <-Ye[1]
for(i in 2:length(Ye)){
  Y[i] <- Ye[i]-(-0.8)*Y[i-1]-(-0.9)*Ye[i-1]
}
Y <- ts(Y)
plot(Y,type='b',main='MA(1)')
abline(h=0)


# 一次指数平滑
alpha <- 0.8
Y <-list(length(Ye))
Y[1] <-Ye[1]
for(i in 2:length(Ye)){
  Y[i] <- alpha*Ye[i]+(1-alpha)*Y[i-1]
}
plot(Y)


## example
data <- read.csv("/Users/zhangjackie/Documents/book//R/Rscript/dataset/monthly-milk-production-pounds-p.csv",header = TRUE)

milkprod <- ts(data[2],start=c(1962,1), end = c(1975,12), frequency = 12) # 转化为 timeseries 格式

plot.ts(milkprod)
abline(lm(milkprod~time(milkprod))) # 增加拟合线

milkprodcomponents <- decompose(milkprod) # 分解为三部分 趋势性，季节性和随机性
plot(milkprodcomponents)

## 验证序列平稳性
library(tseries)
adf.test(milkprod,alternative = 'stationary',k=0)
# 平稳性检验
acf(diff(milkprod),lag.max = 10)
acf(diff(diff(milkprod)),lag.max = 10)


library(TTR)
milkprodSMA<- SMA(milkprod,n= 3) # 移动平均

milkprodseasonaladjusted <- milkprod - milkprodcomponents$seasonal # 去除季节性
plot(milkprodseasonaladjusted)
milkprodtrendadjusted <- milkprod - milkprodcomponents$trend # 去除趋势性
plot(milkprodtrendadjusted)

## 一次指数平滑


# 3次指数平均法
# milkproddiff <- diff(milkprod) #一阶差分 去除了时间序列数据中的趋势性
# milkproddiff2 <- diff(milkprod,differences = 2) # 二次差分  equare to diff(diff(milkprod))

## HoltWinters 模型
milkprodforecast <- HoltWinters(milkprod)
plot(milkprodforecast)
## ARIMA模型
milkprodforecastARIMA <- auto.arima(milkprod)

# 预测未来12个月milk production
library(forecast)
library(zoo)
# Holt-Winter Model Prediction
milkprodforecast12 <-forecast.HoltWinters(milkprodforecast,h=12)
plot(milkprodforecast12)
# ARIMA Model Prediction
milkprodforecastARIMA12 <- forecast.Arima(milkprodforecastARIMA,h=12)
plot(milkprodforecastARIMA12)



