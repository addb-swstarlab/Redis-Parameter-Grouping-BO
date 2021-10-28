library(ggplot2)
library(dplyr)

# 1. 필수 메인 함수 - 데이터와 축을 지정한다.
ggplot(data = iris,
       mapping = aes(x=Sepal.Length,
                     y=Sepal.Width))


# 2. 그래프 그리기 함수 -geom_ 그래프 계열
## geom_point,, geom_line, geom_boxplot, geom_histogram, geom_bar
ggplot(data = iris, 
       mapping = aes(x=Sepal.Length,
                     y=Sepal.Width)) + geom_point()

# 2.1 그래프에서 옵션 추가
## color = '색상', pch = 모양, size = 크기
ggplot(data = iris, 
       mapping = aes(x=Sepal.Length,
                     y=Sepal.Width)) + geom_point(color='red',
                                                  pch=2,
                                                  size=2)

# 2.2 그룹별로 옵션 다르게 지정
## color = '색상', pch = 모양, size = 크기
ggplot(data = iris, 
       mapping = aes(x=Sepal.Length,
                     y=Sepal.Width)) + geom_point(color=c('purple', 'blue', 'green')[iris$Species],
                                                  pch=c(0,2,20)[iris$Species],
                                                  size=c(1,1.5,2)[iris$Species])

# 3. annotate()
g<-ggplot(data = iris, 
       mapping = aes(x=Sepal.Length,
                     y=Sepal.Width)) + geom_point(color=c('purple', 'blue', 'green')[iris$Species],
                                                  pch=c(0,2,20)[iris$Species],
                                                  size=c(1,1.5,2)[iris$Species])



## 3.1 iris$Species 데이터가 모두 겹치는 구역 표시


# 4. 외부 옵션- coord_, labs
## coord_flip() 축변환
## coord_cartensian() 축 범위
## labs() 라벨링

---

# grouped bar graph
library(ggplot2)
library(ggthemes)

# create a dataset
specie <- c(rep("sorgho" , 3) , rep("poacee" , 3) , rep("banana" , 3) , rep("triticum" , 3) )
condition <- rep(c("normal" , "stress" , "Nitrogen") , 4)
value <- abs(rnorm(12 , 0 , 15))
data <- data.frame(specie,condition,value)

# Grouped
ggplot(data, aes(fill=condition, y=value, x=specie)) + 
  geom_bar(position="dodge", stat="identity")+theme_calc() 

# test1
# create a dataset
specie <- c(rep("grouping and bo" , 9) , rep("bo" , 9) )
condition <- rep(c('default',"lightgbm" , "xgboost" , "decisiontree", 'gradientboosting', 'randomforest', 'ridge', 'lasso', 'linearregression') , 2)
grouping_bo_value <- c(
  57467.329000000005,
  60213.48099999999,
  56282.203,
  61835.605,
  57572.34500000001,
  59107.960999999996,
  59630.539000000004,
  60607.15,
  58607.36699999999
)

bo_value <- c(
  57467.329000000005,
  59641.50600000001,
  58003.39200000001,
  58348.412999999986,
  58039.027,
  57668.90499999999,
  57668.90499999999,
  55759.522,
  57874.71800000001
)
total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

# Grouped
ggplot(data1, aes(fill=condition, y=total_value, x=specie)) +  geom_bar(position="dodge", stat="identity")+ coord_cartesian(ylim =c(54000, 60000) )

ggplot(data1, aes(fill=condition, y=total_value, x=specie)) +  geom_bar(position="dodge", stat="identity")+ coord_flip(ylim = c(54000, 62000))


---
# test2 확정
# test1
# create a dataset
# rdb1:1  55422.96699999999
specie <- c(rep("grouping and bo" , 8) , rep("bo" , 8) )
condition <- rep(c("Lightgbm" , "XGBoost" , "DecisionTree", 'Gradient\nBoosting', 'Random\nForest', 'Ridge', 'Lasso', 'Linear\nRegression') , 2)
grouping_bo_value <- c(
  60218,
  57254,
  60401,
  60629,
  60467,
  58515,
  60538,
  60766
  )

bo_value <- c(
  57734,
  56484,
  59377,
  56246,
  57265,
  57964,
  54363,
  59429
)
total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

g<-ggplot(data1, aes(fill=specie, y=total_value, x=condition)) +  
  geom_bar(position="dodge2", stat="identity", width=0.85)+
  coord_cartesian(ylim =c(52500, 61500) )+ 
  theme_light() + 
  xlab("Read:Write=1:1_RDB")+ylab("Troughput(ops/sec)")+ 
  theme(
    legend.position =  'top',
    
    legend.text = element_text(face='bold',
                               size=15),
    
    # x axis value
    axis.text.x = element_text(face="bold", , 
                               size=15),
    
    # y axis value
    axis.text.y = element_text(face="bold", , 
                               size=15),
    plot.title = element_text(size=20, face="bold", 
                              margin = margin(0, 10, 10, 0)),
    # x 축 라벨
    axis.title.x=element_text(size=20, face='bold'),
    
    # y 축 라벨
    axis.title.y=element_text(size=18, face='bold'),  # x라벨 크기
    
  )+
  #  ggtitle('Temperature')+
  geom_hline(yintercept=56705.91199999999, linetype='dashed', color='black', size=0.8, alpha=0.5)+
  scale_fill_discrete(,labels=c('Total Parameters', 'Grouped Parameters'))+ 
  guides(fill = guide_legend(title = NULL))+ 
  geom_text(aes(label=total_value), vjust = -0.3, position=position_dodge(.9))
g


# rdb1:0
specie <- c(rep("grouping and bo" , 8) , rep("bo" , 8) )
condition <- rep(c("Lightgbm" , "XGBoost" , "DecisionTree", 'Gradient\nBoosting', 'Random\nForest', 'Ridge', 'Lasso', 'Linear\nRegression') , 2)
grouping_bo_value <- c(
  61105,
  59432,
  60648,
  59807,
  58705,
  58831,
  56719,
  60036
)


bo_value <- c(
  59342,
  57047,
  58754,
  55798,
  56872,
  56212,
  56056,
  55539
)
total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

g<-ggplot(data1, aes(fill=specie, y=total_value, x=condition)) +  
  geom_bar(position="dodge2", stat="identity", width=0.85)+
  coord_cartesian(ylim =c(52500, 61500) )+ 
  theme_light() + 
  xlab("Write-Only_RDB")+ylab("Troughput(ops/sec)")+ 
  theme(
    legend.position =  'top',
    
    legend.text = element_text(face='bold',
                               size=15),
    
    # x axis value
    axis.text.x = element_text(face="bold", , 
                               size=15),
    
    # y axis value
    axis.text.y = element_text(face="bold", , 
                               size=15),
    plot.title = element_text(size=20, face="bold", 
                              margin = margin(0, 10, 10, 0)),
    # x 축 라벨
    axis.title.x=element_text(size=20, face='bold'),
    
    # y 축 라벨
    axis.title.y=element_text(size=18, face='bold'),  # x라벨 크기
    
  )+
  #  ggtitle('Temperature')+
  geom_hline(yintercept=56269.69300000001, linetype='dashed', color='black', size=0.8, alpha=0.5)+
  scale_fill_discrete(,labels=c('Total Parameters', 'Grouped Parameters'))+ 
  guides(fill = guide_legend(title = NULL))+ 
  geom_text(aes(label=total_value), vjust = -0.3, position=position_dodge(.9))
g


---

# aof1:1
specie <- c(rep("grouping and bo" , 8) , rep("bo" , 8) )
condition <- rep(c("Lightgbm" , "XGBoost" , "DecisionTree", 'Gradient\nBoosting', 'Random\nForest', 'Ridge', 'Lasso', 'Linear\nRegression') , 2)
grouping_bo_value <- c(
  47599,
  46738,
  48181,
  47223,
  44560,
  48138,
  45938,
  48321
  )

bo_value <- c(
  46798,
  45805,
  46237,
  46215,
  43553,
  45654,
  42204,
  47610
)
total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

g<-ggplot(data1, aes(fill=specie, y=total_value, x=condition)) +  
  geom_bar(position="dodge2", stat="identity", width=0.85)+
  coord_cartesian(ylim =c(42000, 49000) )+ 
  theme_light() + 
  xlab("Read:Write=1:1_AOF")+ylab("Troughput(ops/sec)")+ 
  theme(
    legend.position =  'top',
    
    legend.text = element_text(face='bold',
                               size=15),
    
    # x axis value
    axis.text.x = element_text(face="bold", , 
                               size=15),
    
    # y axis value
    axis.text.y = element_text(face="bold", , 
                               size=15),
    plot.title = element_text(size=20, face="bold", 
                              margin = margin(0, 10, 10, 0)),
    # x 축 라벨
    axis.title.x=element_text(size=20, face='bold'),
    
    # y 축 라벨
    axis.title.y=element_text(size=18, face='bold'),  # x라벨 크기
    
  )+
  #  ggtitle('Temperature')+
  geom_hline(yintercept=45481.469, linetype='dashed', color='black', size=0.8, alpha=0.5)+
  scale_fill_discrete(,labels=c('Total Parameters', 'Grouped Parameters'))+ 
  guides(fill = guide_legend(title = NULL))+ 
  geom_text(aes(label=total_value), vjust = -0.3, position=position_dodge(.9))

g



# aof1:0
specie <- c(rep("grouping and bo" , 8) , rep("bo" , 8) )
condition <- rep(c("Lightgbm" , "XGBoost" , "DecisionTree", 'Gradient\nBoosting', 'Random\nForest', 'Ridge', 'Lasso', 'Linear\nRegression') , 2)
grouping_bo_value <- c(
  44520,  # lightgbm
  45988,  # xgb
  47974,
  45391,  # gbm
  46795,
  46167,  # ridge
  45073,
  46739
)

bo_value <- c(
  36879,  # lightgbm
  44005,  # xgb
  44777,
  38096,  # gbm
  43649,
  43128,  # ridge
  42195,
  44658
)
total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

# Grouped

g<-ggplot(data1, aes(fill=specie, y=total_value, x=condition)) +  
  geom_bar(position="dodge2", stat="identity", width=0.85)+
  coord_cartesian(ylim =c(35000, 48500) )+ 
  theme_light() + 
  xlab("Write-Only_AOF")+ylab("Troughput(ops/sec)")+ 
  theme(
    legend.position =  'top',
    
    legend.text = element_text(face='bold',
                               size=15),
    
    # x axis value
    axis.text.x = element_text(face="bold", , 
                               size=15),
    
    # y axis value
    axis.text.y = element_text(face="bold", , 
                               size=15),
    plot.title = element_text(size=20, face="bold", 
                              margin = margin(0, 10, 10, 0)),
    # x 축 라벨
    axis.title.x=element_text(size=20, face='bold'),
    
    # y 축 라벨
    axis.title.y=element_text(size=18, face='bold'),  # x라벨 크기
    
  )+
  #  ggtitle('Temperature')+
  geom_hline(yintercept=44266.712999999996, linetype='dashed', color='black', size=0.8, alpha=0.5)+
  scale_fill_discrete(,labels=c('Total Parameters', 'Grouped Parameters'))+ 
  guides(fill = guide_legend(title = NULL))+ 
  geom_text(aes(label=total_value), vjust = -0.3, position=position_dodge(.9))

g
#g +  scale_fill_manual(values =c("#0071c0", "#c10000") )

---
  
# library(ggplot2)
  
Graph = ggplot() + 
geom_histogram(aes(x = Open), binwidth = 1000, 
               fill = 'royalblue', alpha = 0.4) +
theme_bw() + 
xlab("개장 주가") + ylab("") + ggtitle("Histogram")

---
library('rCharts')
hair_eye_male <- subset(as.data.frame(HairEyeColor), Sex == 'Male')
n1 <- nPlot(Freq~Hair, group = 'Eye', data = hair_eye_male, type = 'multiBarChart')
n1
---
  
library('rCharts')

n1 <- nPlot(total_value~condition, group = 'specie',xlim=c(100000, 500000) data = data1, type = 'multiBarHorizontalChart')
n1
xlim = c(50000, 60000)  

----
library(stringr)

df = data.frame(x = c("label", "long label", "very, very long label"), 
                y = c(10, 15, 20))
df

df$newx = str_wrap(df$x, width = 10)  
  

ggplot(df, aes(x, y)) + 
  xlab("") + ylab("Number of Participants") +
  geom_bar(stat = "identity") 

ggplot(df, aes(newx, y)) + 
  xlab("") + ylab("Number of Participants") +
  geom_bar(stat = "identity")

ggplot(df, aes(x, y)) + 
  xlab("") + ylab("Number of Participants") +
  geom_bar(stat = "identity") +
  scale_x_discrete(labels = function(x) str_wrap(x, width = 10))
  
  

