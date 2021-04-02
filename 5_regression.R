# regression analysis results

# rm(list=ls())

library(MASS)
library(tidyverse)
library(plm)
library(pglm)
library(glmmML)
library(ggplot2)
library(ggpubr)

env <- read.csv("env_final.csv") %>% 
  filter(time!=16)
wel <- read.csv("wel_final.csv") %>% 
  filter(time!=16)

# 245~271국회: 노무현
# 272~313국회: 이명박
# 314~350국회: 박근혜
# 351~ : 문재인

# env
# 1~21789: pre 노무현
# 21790~53301: pre 이명박
# 53302~76335: pre 박근혜
# 76336~ : pre 문재인

colnames(env)[1] <- "no"
colnames(env)[10] <- "maj"
env$pres <- env$ruling <- NA
env$pres[1:21789] <- "노무현"
env$pres[21790:53301] <- "이명박"
env$pres[53302:76335] <- "박근혜"
env$pres[76336:nrow(env)] <- "문재인"

env$ruling[env$party=="열린우리당" & env$time==17 & env$pres=="노무현"] <- 1
env$ruling[env$party!="열린우리당" & env$time==17 & env$pres=="노무현"] <- 0
env$ruling[env$party=="한나라당" & env$time==17 & env$pres=="이명박"] <- 1
env$ruling[env$party!="한나라당" & env$time==17 & env$pres=="이명박"] <- 0

env$ruling[env$party=="한나라당" & env$time==18] <- 1
env$ruling[env$party!="한나라당" & env$time==18] <- 0

env$ruling[env$party=="새누리당" & env$time==19] <- 1
env$ruling[env$party!="새누리당" & env$time==19] <- 0

env$ruling[env$party=="새누리당" & env$time==20 & env$pre=="박근혜"] <- 1
env$ruling[env$party!="새누리당" & env$time==20 & env$pre=="박근혜"] <- 0
env$ruling[env$party=="더불어민주당" & env$time==20 & env$pre=="문재인"] <- 1
env$ruling[env$party!="더불어민주당" & env$time==20 & env$pre=="문재인"] <- 0

env <- na.omit(env)



# wel
# 1~20419: pre 노무현
# 20420~32257: pre 이명박
# 32258~57160: pre 박근혜
# 57161~ : pre 문재인

colnames(wel)[1] <- "no"
colnames(wel)[9] <- "maj"
wel$pres <- wel$ruling <- NA
wel$pres[1:20419] <- "노무현"
wel$pres[20420:32257] <- "이명박"
wel$pres[32258:57160] <- "박근혜"
wel$pres[57161:nrow(wel)] <- "문재인"

wel$ruling[wel$party=="열린우리당" & wel$time==17 & wel$pres=="노무현"] <- 1
wel$ruling[wel$party!="열린우리당" & wel$time==17 & wel$pres=="노무현"] <- 0
wel$ruling[wel$party=="한나라당" & wel$time==17 & wel$pres=="이명박"] <- 1
wel$ruling[wel$party!="한나라당" & wel$time==17 & wel$pres=="이명박"] <- 0

wel$ruling[wel$party=="한나라당" & wel$time==18] <- 1
wel$ruling[wel$party!="한나라당" & wel$time==18] <- 0

wel$ruling[wel$party=="새누리당" & wel$time==19] <- 1
wel$ruling[wel$party!="새누리당" & wel$time==19] <- 0

wel$ruling[wel$party=="새누리당" & wel$time==20 & wel$pre=="박근혜"] <- 1
wel$ruling[wel$party!="새누리당" & wel$time==20 & wel$pre=="박근혜"] <- 0
wel$ruling[wel$party=="더불어민주당" & wel$time==20 & wel$pre=="문재인"] <- 1
wel$ruling[wel$party!="더불어민주당" & wel$time==20 & wel$pre=="문재인"] <- 0

wel <- na.omit(wel)


envdata <- env %>% 
  select(-speech) %>% 
  filter(outside==0) %>% 
  select(-outside)

weldata <- wel %>% 
  select(-speech)

data <- rbind(envdata, weldata)
data$no <- 1:nrow(data)

colnames(data)
count <- data %>% 
  group_by(name, time, maj, ruling, chair, sex, age, seniority, prop, wnominate) %>% 
  summarize(speech=n(), intrpt=sum(interrupt)) %>% 
  filter(speech>100)%>% 
  filter(chair==0)

count$intrpt_prop <- 100* (count$intrpt / count$speech)

col <- RColorBrewer::brewer.pal(3, "Set2")

remotes::install_github("coolbutuseless/ggpattern")
library(ggpattern)

ass17 <- count %>% filter(time==17) %>% 
  ggplot(aes(reorder(name, intrpt_prop), intrpt_prop, 
             fill=as.factor(ruling))) +
  geom_col() + scale_fill_manual(values=col[2:3]) +
  xlab("국회의원") + ylab("전체 발언 대비 중도방해 발언 비율 (%)") +
  ggtitle("17대 국회") +
  # annotate("text", x=20, y=20, label="17대 국회", fontface=2, size=9) +
  coord_flip() + theme_grey(base_size=15) + 
  theme(legend.position=c(.85, .20),
        legend.title=element_text(size=13),
        legend.text=element_text(size=10)) +
  scale_fill_discrete(name="정당 소속", labels=c("야당", "여당"))

ass18 <- count %>% filter(time==18) %>% 
  ggplot(aes(reorder(name, intrpt_prop), intrpt_prop, 
             fill=as.factor(ruling))) +
  geom_col() + scale_fill_manual(values=col[2:3]) +
  xlab("") + ylab("전체 발언 대비 중도방해 발언 비율 (%)") +
  ggtitle("18대 국회") +
  # annotate("text", x=20, y=20, label="18대 국회", fontface=2, size=9) +
  coord_flip() + theme_grey(base_size=15) + 
  theme(legend.position=c(.85, .20),
        legend.title=element_text(size=13),
        legend.text=element_text(size=10)) +
  scale_fill_discrete(name="정당 소속", labels=c("야당", "여당"))

ass19 <- count %>% filter(time==19) %>% 
  ggplot(aes(reorder(name, intrpt_prop), intrpt_prop, 
             fill=as.factor(ruling))) +
  geom_col() + scale_fill_manual(values=col[2:3]) +
  xlab("") + ylab("전체 발언 대비 중도방해 발언 비율 (%)") +
  ggtitle("19대 국회") +
  # annotate("text", x=20, y=20, label="19대 국회", fontface=2, size=9) +
  coord_flip() + theme_grey(base_size=15) + 
  theme(legend.position=c(.85, .20),
        legend.title=element_text(size=13),
        legend.text=element_text(size=10)) +
  scale_fill_discrete(name="정당 소속", labels=c("야당", "여당"))

ass20 <- count %>% filter(time==20) %>%
  ggplot(aes(reorder(name, intrpt_prop), intrpt_prop, 
             fill=as.factor(ruling))) +
  geom_col() + scale_fill_manual(values=col[2:3]) +
  xlab("") + ylab("전체 발언 대비 중도방해 발언 비율 (%)") +
  ggtitle("20대 국회") +
  # annotate("text", x=20, y=20, label="20대 국회", fontface=2, size=9) +
  coord_flip() + theme_grey(base_size=15) + 
  theme(legend.position=c(.85, .20),
        legend.title=element_text(size=13),
        legend.text=element_text(size=10)) +
  scale_fill_discrete(name="정당 소속", labels=c("야당", "여당"))
 
  
ggarrange(
  ass17, ass18, ass19, ass20,
  common.legend=F, legend="bottom", ncol=4, nrow=1
)

############################################################################
opptorul_name <- c("강병원","권미혁","기동민","김상희","남인순","서형수","송옥주","신창현","오제세",
              "이용득","인재근","전혜숙","한정애")

opptorul_value_0 <-count %>% filter(time==20) %>% 
  filter(name=="강병원" | name=="권미혁" | name=="기동민" | name=="김상희" | name=="남인순" |
           name=="서형수" | name=="송옥주" | name=="신창현" | name=="오제세" | name=="이용득" |
           name=="인재근" | name=="전혜숙" | name=="한정애") %>% 
  filter(ruling==0)
opptorul_value_0 <- opptorul_value_0$intrpt_prop
opptorul_value_1 <-count %>% filter(time==20) %>% 
  filter(name=="강병원" | name=="권미혁" | name=="기동민" | name=="김상희" | name=="남인순" |
           name=="서형수" | name=="송옥주" | name=="신창현" | name=="오제세" | name=="이용득" |
           name=="인재근" | name=="전혜숙" | name=="한정애") %>% 
  filter(ruling==1)
opptorul_value_1 <- opptorul_value_1$intrpt_prop
opptorul <- data.frame(name=opptorul_name,
                       value.0=opptorul_value_0, value.1=opptorul_value_1)
ggplot(opptorul) +
  geom_point(size=3, aes(value.0, name, color=col[3])) +
  geom_point(size=3, aes(value.1, name, color=col[2])) +
  geom_segment(aes(x=value.0, xend=value.1, y=name, yend=name), size=1, alpha=0.4,
               arrow=arrow(length=unit(0.3, "cm"))) +
  xlab("중도방해 발언 비율 (%)") + ylab("국회의원") +
  scale_color_discrete(name="정당 소속", labels=c("야당", "여당")) +
  theme_grey(base_size=20)
############################################################################
############################################################################
rultoopp_name <- c("김순례","김승희","문진국","송석준","신보라","임이자","장석춘","정춘숙","하태경")

rultoopp_value_0 <-count %>% filter(time==20) %>% 
  filter(name=="김순례" | name=="김승희" | name=="문진국" | name=="송석준" | name=="신보라" |
           name=="임이자" | name=="장석춘" | name=="정춘숙" | name=="하태경") %>% 
  filter(ruling==0)
rultoopp_value_0 <- rultoopp_value_0$intrpt_prop
rultoopp_value_1 <-count %>% filter(time==20) %>% 
  filter(name=="김순례" | name=="김승희" | name=="문진국" | name=="송석준" | name=="신보라" |
           name=="임이자" | name=="장석춘" | name=="정춘숙" | name=="하태경") %>% 
  filter(ruling==1)
rultoopp_value_1 <- rultoopp_value_1$intrpt_prop
rultoopp <- data.frame(name=rultoopp_name,
                       value.0=rultoopp_value_0, value.1=rultoopp_value_1)
ggplot(rultoopp) +
  geom_point(size=3, aes(value.0, name, color=col[3])) +
  geom_point(size=3, aes(value.1, name, color=col[2])) +
  geom_segment(aes(x=value.1, xend=value.0, y=name, yend=name), size=1, alpha=0.4,
               arrow=arrow(length=unit(0.3, "cm"))) +
  xlab("중도방해 발언 비율 (%)") + ylab("국회의원") +
  scale_color_discrete(name="정당 소속", labels=c("야당", "여당")) +
  theme_grey(base_size=20)
  
formula1 <- intrpt_prop ~ as.factor(time) + ruling + age + sex + seniority + prop
reg1 <- lm(formula1, count)
summary(reg1)
summary(reg1, vcov=vcovHC(reg1, type="HC4"))
lmtest::coeftest(reg1, vcov=vcovHC(reg1, type="HC4"))
library(lmtest)

count2$time <- as.factor(count2$time)
count2$time <- relevel(count2$time, ref=1)
formula2 <- intrpt_prop ~ as.factor(time) + ruling + age + sex + seniority + prop
reg2 <- lm(formula2, count)
summary(reg2)
summary(reg2, vcov=vcovHC(reg2, type="HC4"))
lmtest::coeftest(reg2, vcov=vcovHC(reg2, type="HC4"))
library(lmtest)

bptest(reg1)
##### ideological distance

countdata2 <- count %>% 
  filter(time!=20)

countdata2 %>% 
  filter(ruling==1) %>% 
  group_by(time) %>% 
  summarize(mean=mean(wnominate))
# -0.575, 0.563, 0.655

countdata2$idistance[countdata2$time==17] <- abs(
  countdata2$wnominate[countdata2$time==17] - (-0.575))
countdata2$idistance[countdata2$time==18] <- abs(
  countdata2$wnominate[countdata2$time==18] - (0.563))
countdata2$idistance[countdata2$time==19] <- abs(
  countdata2$wnominate[countdata2$time==19] - (0.655))

countdata3 <- countdata2
countdata3$time <- as.factor(countdata3$time)
countdata3$time <- relevel(countdata3$time, ref=1)
formula3 <- intrpt_prop ~ as.factor(time) + ruling + idistance + age + sex + seniority + prop
reg3 <- lm(formula3, countdata3)
summary(reg3, vcov=vcovHC(reg3, type="HC4"))
bptest(reg3)

