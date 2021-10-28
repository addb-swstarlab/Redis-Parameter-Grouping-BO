# 슬기로운 통계생활


## 중간고사, 기말고사 성정 데이터
mydata <-
  read.csv('https://www.theissaclee.com/ko/courses/rstat101/examscore2.csv', header=TRUE)

head(mydata)

## 중간고사, 기말고사 합을 기준으로 나눈다.
mydata$highlow <-
  ifelse(mydata$midterm + mydata$final < 150, 'low', 'high')

head(mydata)

---
  
## 기본 layer 
library(ggplot2)

## 1. 데이터 로드 및 테마 
p <- ggplot(data = mydata) +s
  
  ## 그래프 테마 선택 (black white)theme(text = element_text(size = 12, family = 'KakaoRegular'))

  theme_bw()
p

## 2. scatter ploting
p <- p + 
  ## insert scatter plot info 
  geom_point(aes(x=midterm, y=final))  ### aes 는 속성

p

## 3. labs - 산점도 제목, 소제목, 축제목 등
p<-p+labs(title = '학생들 성적 분포도',
     subtitle = '중간 vs. 기말 성적',
     x = '중간고사',
     y = '기말고사',
     caption = 
       'https://statisticsplaybook.tistory.com/18')

p

## 4. 속성과 데이터를 연결시켜주는 aes()
### 점 속성 - color, size, shape, alpha

p <- p + 
  aes(
    color = gender,  # 성별 색상 다르게
    size = rep(c(2.5,5), each=15),  # 사이즈 처음 15개 2.5, 나머지 15개 5
    
    shape = highlow,  # 성별 모양 다르게  
    alpha = 0.8  # 전체 투명도 0.8
  )
p

## 5. 점 색상 마음대로 바꾸기
p + scale_color_manual(values = c('red', 'blue'),  ### 색상 설정
                   labels = c('여자', '남자'))   ### key 값 설정


## 5.1 brewer를 이용한 색상 설정
p + scale_color_brewer(
  palette = 'Set1',
  labels = c('여자', '남자')  
)+
  scale_shape_discrete(
  labels = c('상위권', '하위권')
)

p

## 6. 확정 지어주기, 투명도와 크기 확정지어 주기
p <- p +
  scale_alpha_identity()+
  scale_size_identity()

# 축 범례 설정
## legend, legend title, key, keylabel
## tick mark, tick label, 축, 축 제목, 

### 범례위치 - theme(legend.position = '옵션') -> right, left, bottom, top, none(범례삭제)
### 범례 배치 - guides(속성 = guid_legend()) -> title, ncol, byrow, reverse, orde...
### 범례 변경 - scale_속성_discrete(labels = )

mygender <- guide_legend(
  title = '성별', ncol = 2,
  reverse = TRUE, order = 1
)

myhighlow <- guide_legend(
  title = '성적별',ncol = 2,
  order = 2
)

p <- p+
  guides(color = mygender,
         shape = myhighlow) +
  theme(legend.position = 'bottom')
p

## 축 설정 scale_축_continuous(limits = , breaks, labels =)
p + scale_x_continuous(
  limits = c(10, 105),
  breaks = 1:5*20,  ### tick 결정 20 40, 60, 80, 100
  labels = pastse0(1:5*20, '점')
)

---
  
  # aof1:0
specie <- c(rep("grouping and bo" , 8) , rep("bo" , 8) )
condition <- rep(c("Lightgbm" , "XGBoost" , "DecisionTree", 'Gradient\nBoosting', 'Random\nForest', 'Ridge', 'Lasso', 'Linear\nRegression') , 2)
grouping_bo_value <- c(
  45221,  # lightgbm  45220.503
  45184,   # xgb  45183.899
  47100,   # dt  47099.909
  45660,   # gbm  45660.441
  45071,   # rf  45070.5
  46611,   # ridge   46611.313
  45115,   # lasso  45114.971000000005
  46344   # lr  46343.687
)

bo_value <- c(
  37213,   # lightgbm  37213.261
  44035,   # xgb  44034.628
  46718,   # dt  46717.721000000005
  40076,   # gbm  40075.537
  43262,   # rf  43262.386999999995
  44780,   # ridge  44779.873
  42592,   # lasso  42592.235
  45213   # lr  45213.363
)
total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

g<-ggplot(data1, aes(fill=specie, y=total_value, x=condition)) +  
  geom_bar(position="dodge", stat="identity", width=0.8)+
  coord_cartesian(ylim =c(42000, 50000) )+ 
  theme_light() + 
  xlab(" ")+ylab("Troughput(ops/sec)")+ 
  theme(
    legend.position =  'top',
    axis.text.x = element_text(face="bold", , 
                               size=10),
    axis.text.y = element_text(face="bold", , 
                               size=10),
    plot.title = element_text(size=20, face="bold", 
                              margin = margin(0, 10, 10, 0))
  )+
#  ggtitle('Temperature')+
  geom_hline(yintercept=46374.969999999994, linetype='dashed', color='black', size=1)+
  scale_fill_discrete(,labels=c('Total Parameters', 'Grouped Parameters'))+ 
  guides(fill = guide_legend(title = NULL))+ geom_text(aes(label=total_value), vjust = -0.3)
g
#g +scale_fill_manual(values =c("#009900", "#006699") )



g<-  + coord_cartesian(ylim =c(35000, 47500) ) +  theme(legend.position ='top')+  geom_hline(yintercept=46374.969999999994, linetype='dashed', color='black', size=1)+scale_fill_discrete(,labels=c('Total Parameters', 'Grouped Parameters'))+ guides(fill = guide_legend(title = NULL))+ geom_text(aes(label=total_value), vjust = -0.3)


# 색상변경버전
g <- ggplot(data1, aes(fill=specie, y=total_value, x=condition)) + 
  theme_light()+
  geom_bar(position="dodge", stat="identity", width=0.8, )+
  labs(
        #title = '학생들 성적 분포도',
        #subtitle = '중간 vs. 기말 성적',
        x = 'Read:Write=1:1_AOF',
        y = 'Troughput(ops/sec)',
        )+
  scale_color_manual(
    values = c('#009900', '#006699'),  ### 색상 설정
    labels = c('T', 'G'))+   ### key 값 설정
  scale_fill_manual(values =c("#009900", "#006699")) +
  theme_set(theme_grey(base_family = 'AppleGothic'))+
  coord_cartesian(ylim =c(35000, 47500))+
  theme_set(theme_grey(base_family = 'AppleGothic'))+
  theme(legend.position ='top', axis.title=element_text(size=30))
g

total_value <- c(grouping_bo_value, bo_value)
data1 <- data.frame(specie,condition,total_value)

g<-ggplot(data1, aes(fill=specie, y=total_value, x=condition)) +  
  geom_bar(position="dodge2", stat="identity", width=0.8)+
  coord_cartesian(ylim =c(52500, 61500) )+ 
  theme_light() + 
  xlab("Read:Write=1:1_RDB")+ylab("Troughput(ops/sec)")+ 
  theme(
    legend.position =  'top',
    plot.title = element_text(size=20, face="bold", 
                              margin = margin(0, 10, 10, 0)),
    # x 축 라벨
    axis.title.x=element_text(size=20),  # x라벨 크기
    
    # x axis value
    axis.text.x = element_text(face="bold", , 
                               size=10),
    
    # y axis value
    axis.text.y = element_text(face="bold", , 
                               size=10),
    
    
  )+
  #  ggtitle('Temperature')+
#  geom_hline(yintercept=56705.91199999999, linetype='dashed', color='black', size=1)+  
#  geom_hline(data = default_val, mapping = aes(yintercept=y_values))+
#  scale_linetype_manual(name = "limit", values = 56705.91199999999, 
#                        guide = guide_legend(override.aes = list(color = c("blue"))))+  
#  
  geom_hline(aes(yintercept= 55000, linetype = "Current Year Mean"), colour= 'green') +
  geom_hline(aes(yintercept= 57500, linetype = "2010 Mean"), colour= 'black') +
  scale_linetype_manual(name ="", values = c('dotted','dotted')) 
  
  
#  geom_hline(aes(yintercept=56705.91199999999, colour='limit'), linetype='dashed', size=1, show.legend = TRUE)+
#  scale_color_manual(name="Default", values=c(limit="red")) +
  scale_fill_discrete(labels=c('Total Parameters', 'Grouped Parameters'))+ 
  guides(fill = guide_legend(title = NULL))+ 
  geom_text(aes(label=total_value),  
            vjust = 0.99, 
            position=position_dodge(.9)  # position=position_dodge(width=1)
            )  
g


default_val <- data.frame(y_values = 56705.91199999999)






