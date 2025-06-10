setwd("")
library(ggplot2)
library(reshape2)

table<-read.csv("interaction-score.csv",header=TRUE)

#table<-tapply(table$Range,list(table$Group))

# 绘图
p<-ggplot(data=table, aes(x=Group, y=Length, fill=Interaction_propensity_score)) +
  geom_bar(stat="identity")+
  #geom_text(aes(y=label_ypos, label=len), vjust=1.6, 
  #          color="white", size=3.5)+
  scale_fill_gradient(low = "white",high = "red")+
  facet_wrap(~Group,scales = "free_y",ncol = 1)+
  coord_flip()+
  theme_minimal()

p
ggsave(p, file="bar_SLUGmRNA.pdf", width=20, height=3,limitsize = FALSE)

#####################Combination Point##############################################3
Pre<-read.csv("PRE_Combination_point.csv",header=TRUE)
Mature<-read.csv("Mature_Combination_point.csv",header=TRUE)

Pre$Group<-"Pre"
Mature$Group<-"Mature"

all_data<-rbind(Pre,Mature)

p_pre_1<-ggplot(all_data)+
      geom_bar(aes(x = Position_B,fill=Group))+
      #geom_density(aes(x = Position_B,fill=Group))+
      scale_fill_manual(values=c("#00AFBB", "#E7B800"))+
      facet_wrap(~Group,scales = "free",ncol = 1)+
      theme_minimal()

p_pre_2<-ggplot(all_data)+
  #geom_bar(aes(x = Position_B,fill=Group))+
  geom_density(aes(x = Position_B,color=Group))+
  scale_color_manual(values=c("#00AFBB", "#E7B800"))+
  facet_wrap(~Group,scales = "free",ncol = 1)+
  theme_minimal()

p_pre_1
p_pre_2
ggsave(p_pre_1, file="barplot_SLUGmRNA.pdf", width=6, height=3,limitsize = FALSE)
ggsave(p_pre_2, file="density_SLUGmRNA.pdf", width=6, height=3,limitsize = FALSE)
