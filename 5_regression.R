library(MASS)
library(tidyverse)
library(plm)
library(pglm)
library(glmmML)
library(ggplot2)
library(ggpubr)

env <- read.csv("env_final.csv")
wel <- read.csv("wel_final.csv")

colnames(env)

envdata <- env %>% 
  select(-speech) %>% 
  filter(outside==0)

weldata <- wel %>% 
  select(-speech)

envdata <- pdata.frame(envdata, index=c("name","time"))
envdata <- envdata[c(-1,-2,-3),]
weldata <- pdata.frame(weldata, index=c("name","time"))

################

#LOGIT

formula1 <- interrupt ~ ruling + chair + age + sex + seniority + prop + wnominate
logit_env <- glm(formula1, envdata[envdata$time==t,], family="binomial")  
summary(logit_env)
exp(logit_env$coefficients)
logit_wel <- glm(formula1, weldata[weldata$time==t,], family="binomial")
summary(logit_wel)
exp(logit_wel$coefficients)

#LOGIT with FIXED EFFECTS, using glmmboot (using cluster)
formula2 <- interrupt ~ ruling + chair + age + seniority + prop + wnominate
felogit_env <- glmmboot(formula2, family=binomial(link="logit"), data=envdata, cluster=name)
felogit_wel <- glmmboot(formula2, family=binomial(link="logit"), data=weldata, cluster=name)

summary(felogit_env)
exp(felogit_env$coefficients)
summary(felogit_wel)
exp(felogit_wel$coefficients)

#POISSON MODEL
envdata_count <- envdata %>% 
  group_by(name, time, ruling, chair, sex, age, seniority, prop, wnominate) %>% 
  summarize(speech_total=n(), interrupt_total=sum(interrupt)) %>% 
  filter(speech_total>100) %>% 
  filter(chair==0)

envdata_count %>% 
  group_by(time) %>% 
  summarize(mean=mean(wnominate, na.rm=T))
# -0.0693, -0.191, 0.320, 0.157, -0.052
envdata_count$idistance <- NA
envdata_count$idistance[envdata_count$time==16] <- abs(envdata_count$wnominate - -0.0693)
envdata_count$idistance[envdata_count$time==17] <- abs(envdata_count$wnominate - -0.191)
envdata_count$idistance[envdata_count$time==18] <- abs(envdata_count$wnominate - 0.320)
envdata_count$idistance[envdata_count$time==19] <- abs(envdata_count$wnominate - 0.157)
envdata_count$idistance[envdata_count$time==20] <- abs(envdata_count$wnominate - -0.052)

weldata_count <- weldata %>% 
  group_by(name, time, ruling, chair, sex, age, seniority, prop, wnominate) %>% 
  summarize(speech_total=n(), interrupt_total=sum(interrupt)) %>% 
  filter(speech_total>100)%>% 
  filter(chair==0)

weldata_count %>% 
  group_by(time) %>% 
  summarize(mean=mean(wnominate, na.rm=T))
# -0.104, -0.194, 0.193, 0.236, -0.0892
weldata_count$idistance <- NA
weldata_count$idistance[weldata_count$time==16] <- abs(weldata_count$wnominate - -0.104)
weldata_count$idistance[weldata_count$time==17] <- abs(weldata_count$wnominate - -0.194)
weldata_count$idistance[weldata_count$time==18] <- abs(weldata_count$wnominate - 0.193)
weldata_count$idistance[weldata_count$time==19] <- abs(weldata_count$wnominate - 0.236)
weldata_count$idistance[weldata_count$time==20] <- abs(weldata_count$wnominate - -0.0892)

envdata_count$com <- "env"
weldata_count$com <- "wel"

formula3 <- interrupt_total ~ as.factor(time) + ruling + age + sex + seniority + prop + idistance
ppois_env <- glm(formula3, envdata_count, family="poisson")
ppois_wel <- glm(formula3, weldata_count, family="poisson")
summary(ppois_env)
exp(ppois_env$coefficients)
summary(ppois_wel)
exp(ppois_wel$coefficients)

countdata <- rbind(envdata_count, weldata_count)
colnames(countdata)
countdata <- countdata %>% 
  group_by(name, time, ruling, chair, sex, age, seniority, prop, wnominate, idistance) %>% 
  summarize(speech_total=sum(speech_total), interrupt_total=sum(interrupt_total))

formula4 <- interrupt_total ~ as.factor(time) + as.factor(com) +
  ruling + age + sex + seniority + prop + idistance
ppois <- glm(formula4, countdata, family="poisson")
summary(ppois)

formula5 <- intprop ~ as.factor(time) + as.factor(com) +
  ruling + age + sex + seniority + prop + idistance
lm5 <- lm(formula5, countdata)
summary(lm5)



ass16 <- countdata %>% na.omit() %>% filter(time==16) %>% 
  ggplot(aes(reorder(name, intprop), intprop, fill=as.factor(ruling))) +
  geom_col(show.legend=F) + xlab("국회의원") + ylab("전체 발언 대비 중도방해 발언 비율 (%)") +
  coord_flip() 
  

ass17 <- countdata %>% na.omit() %>% filter(time==17) %>% 
  ggplot(aes(reorder(name, intprop), intprop, fill=as.factor(ruling))) +
  geom_col(show.legend=F) + coord_flip() +
  xlab("전체 발언 대비 중도방해 발언 비율") + ylab("국회의원")

ass18 <- countdata %>% na.omit() %>% filter(time==18) %>% 
  ggplot(aes(reorder(name, intprop), intprop, fill=as.factor(ruling))) +
  geom_col(show.legend=F) + coord_flip() +
  xlab("전체 발언 대비 중도방해 발언 비율") + ylab("국회의원")

ass19 <- countdata %>% na.omit() %>% filter(time==19) %>% 
  ggplot(aes(reorder(name, intprop), intprop, fill=as.factor(ruling))) +
  geom_col(show.legend=F) + coord_flip() +
  xlab("전체 발언 대비 중도방해 발언 비율") + ylab("국회의원")

ass20 <- countdata %>% na.omit() %>% filter(time==20) %>% 
  ggplot(aes(reorder(name, intprop), intprop, fill=as.factor(ruling))) +
  geom_col() + coord_flip() +
  xlab("전체 발언 대비 중도방해 발언 비율") + ylab("국회의원")

ggarrange(
  ass16, ass17, ass18, ass19, ass20,
           common.legend=T, legend="bottom", ncol=5, nrow=1
  )


ggplot(countdata, aes(reorder(name,intprop), intprop,
                     fill=as.factor(ruling), color=as.factor(ruling))) +
  geom_col(show.legend=F) +
  coord_flip() +
  facet_grid(~time)

