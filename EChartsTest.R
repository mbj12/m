## use REmap
library(REmap)
#############################################################################
origin = rep("beijing",6)
destination =c('shanghai','tianjin','chongqing','haerbin','wuhan','qiqihaer')
dat <- data.frame(origin,destination)
out <- remap(dat,title = '迁移地图',theme = get_theme("Dark"))
plot(out)


## use recharts interface for echarts
#https://yihui.name/recharts/examples.html
# Echart gov :http://echarts.baidu.com/echarts2/doc/doc.html#Option

chippy = function(x) sin(cos(x)*exp(-x/2))
x = seq(-8, 7, length = 100)
y = chippy(x)
eLine(y)
# Line chart
dat <- data.frame(x,y)
eLine(dat,xvar = x,yvar = y,title = 'Line Plot',theme = 'Dark')

# Bar chart
eBar(y)

# ScatterPlot
ePoints(dat,xvar = x, yvar = y)

## wordcloud2 package
library(wordcloud2)
wordcloud2(wordFreqDf_chs,size=1,shape = 'diamond') # 词云图

