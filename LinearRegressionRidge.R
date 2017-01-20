library(MASS)

#load dataset
traindata <- read.table("/Users/zhangjackie/Documents/book//R/Rscript/dataset/train2762_20170103.txt",header = TRUE)
testdata <- read.table("/Users/zhangjackie/Documents/book//R/Rscript/dataset/test2762_20170103.txt",header = TRUE)

#rename
# names(traindata) <- c("area_id","y","x1","x2","x3","x4","x5","x6","x7")
# names(testdata) <- c("area_id","y","x1","x2","x3","x4","x5","x6","x7")

# least square method
# traindata
data1 <-(traindata$x2+1)*log(traindata$x3+1)/(traindata$x3+1)
data2 <-(traindata$x4/traindata$x5)
data3 <-(traindata$x6/traindata$x7)
data4 <-traindata$x3+traindata$x2
data5 <-(traindata$x2+1)/(traindata$x3+1)

traindata$data1 <- data1
traindata$data2 <- data2
traindata$data3 <- data3
traindata$data4 <- data4
traindata$data5 <- data5

#testdata
data11 <-(testdata$x2+1)*log(testdata$x3+1)/(testdata$x3+1)
data22 <-(testdata$x4/testdata$x5)
data33 <-(testdata$x6/testdata$x7)
data44 <-testdata$x3+testdata$x2
data55 <-(testdata$x2+1)/(testdata$x3+1)

testdata$data1 <- data11
testdata$data2 <- data22
testdata$data3 <- data33
testdata$data4 <- data44
testdata$data5 <- data55


ols <- lm(y~data1+data2+data3,traindata)
model <-summary(ols)

## 四个检验图
# par(mfrow=c(2,2))
# plot(ols)

## 逐步回归 根据AIC赤池准则挑选变量
# step(ols)


# stepAIC(ols)  # y ~ x1 + x2 + x3 + x4 + x6   

# 根据ATC值，去掉了x5和x7两个变量
# ols <- lm(y~x1+x2+x3+x4+x6,traindata)
# model <- summary(ols)



newdata <- testdata[,c('data1','data2','data3')]
#newdata <- testdata[,c('x2','x3')]
# newdata <- testdata[,'x2']
# newdata1 <- data.frame(x2 =newdata)
predictValue <- predict(ols,newdata)  # 预测值
predict <- data.frame(minute_phase= testdata$minute_phase, predictValue)


realValue <- read.table("/Users/zhangjackie/Documents/book//R/Rscript/dataset/exactValue2762_20170103.txt",header = TRUE)
result <- merge(realValue,predict)

## 模型性能指标
R2 <- model$r.squared # R^2
MAE <- mean(abs(result$avg_peisong_time-result$predictValue))

## plot figure out
plot(result$minute_phase,result$avg_peisong_time,type = 'l',col='blue',xlab = 'phase' , ylab='value',main='area_id = 2627')
#points(result$minute_phase,result$avg_peisong_time)
lines(result$minute_phase,result$predictValue,col='red')
#points(result$minute_phase,result$predictValue,col='red')


##
# ridge regresson method
# library(ridge)
# rid <- linearRidge(y~x3+x4+x6,data = data0103)
# summary(rid)


