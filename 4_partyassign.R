library(tidyverse)
library(readxl)

############## env com data cleaning #######################

env16 <- read.csv("legis_env16.csv")
env17 <- read.csv("legis_env17.csv")
env18 <- read.csv("legis_env18.csv")
env19 <- read.csv("legis_env19.csv")
env20 <- read.csv("legis_env20.csv")

env16$com <- env17$com <- env18$com <- env19$com <- env20$com <- "env"
env16$time <- 16
env17$time <- 17
env18$time <- 18
env19$time <- 19
env20$time <- 20

colnames(env20)

env <- rbind(env16, env17, env18, env19, env20) %>% 
  select(time, com, speaker, speech, interrupt, party)

#write.csv(unique(env$speaker), "envspeaker.csv")  
###
envconflict <- read_excel("envconflict.xlsx")
envspeaker <- read.csv("envspeaker.csv")

env$outside <- 0

for (i in 1:nrow(env)) {
  for (j in 1:nrow(envconflict)){
    if (env$speaker[i]==envconflict$speaker[j]) {
      env$speech[i] <- envconflict$speech[j]
      env$outside[i] <- 1
    }
  }
}

env$chair <- 0

for (i in 1:nrow(env)) {
  for (j in 1:nrow(envspeaker)) {
    if (env$speaker[i]==envspeaker$name[j]) {
      env$speaker[i] <- envspeaker$change[j]
      env$chair[i] <- envspeaker$chair[j]
    }
  }
}

env <- env %>% 
  filter(speaker!="이재용")

############## wel com data cleaning #######################

wel16 <- read.csv("legis_wel16.csv")
wel17 <- read.csv("legis_wel17.csv")
wel18 <- read.csv("legis_wel18.csv")
wel19 <- read.csv("legis_wel19.csv")
wel20 <- read.csv("legis_wel20.csv")

wel16$com <- wel17$com <- wel18$com <- wel19$com <- wel20$com <- "wel"
wel16$time <- 16
wel17$time <- 17
wel18$time <- 18
wel19$time <- 19
wel20$time <- 20

colnames(wel20)

wel <- rbind(wel16, wel17, wel18, wel19, wel20) %>% 
  select(time, com, speaker, speech, interrupt, party)

#write.csv(unique(wel$speaker), "welspeaker.csv")  
###
#welconflict <- read_excel("welconflict.xlsx")
welspeaker <- read.csv("welspeaker.csv")


# wel$outside <- 0

#for (i in 1:nrow(wel)) {
#  for (j in 1:nrow(welconflict)){
#    if (wel$speaker[i]==welconflict$speaker[j]) {
#      wel$speaker[i] <- welconflict$name[j]
#      wel$speech[i] <- welconflict$speech[j]
#      wel$outside[i] <- 1
#    }
#  }
#}

#wel %>% 
#  filter(outside==1)

wel$chair <- 0

#wel <- na.omit(wel)
for (i in 1:nrow(wel)) {
  for (j in 1:nrow(welspeaker)) {
    if (wel$speaker[i]==welspeaker$name[j]) {
      wel$speaker[i] <- welspeaker$change[j]
      wel$chair[i] <- welspeaker$chair[j]
    }
  }
}


# if TRUE/FALSE error appears, try this code then rerun the above code:
# wel <- na.omit(wel)
# error msg appears because the speaker in the original dataset is not a legislator
# minor coding error issue
# na.omit code helps detect the non-legislator speaker and deletes it


##double-check
env <- na.omit(env)
wel <- na.omit(wel)

colnames(env)[3] <- colnames(wel)[3] <- "name"

write.csv(env, "env.csv")
write.csv(wel, "wel.csv")

rawenv <- env
rawwel <- wel

## count-data modeling

#env_count <- env %>% 
#  group_by(time,com,speaker) %>% 
#  summarize(n=sum(interrupt))

#wel_count <- wel %>% 
#  group_by(time,com,speaker) %>% 
#  summarize(n=sum(interrupt))

envinfo <- read_excel("env_info.xlsx", sheet=1)
welinfo <- read_excel("wel_info.xlsx", sheet=1)

envinfo$time <- as.numeric(envinfo$time)
welinfo$time <- as.numeric(welinfo$time)

wel$name[wel$name=="김경순"] <- "김성순"
wel$name[wel$name=="문희"] <- "문희상"
wel$name[wel$name=="현애장"] <- "현애자"
wel$name[wel$name=="현재아"] <- "현애자"
wel$name[wel$name=="현재아"] <- "현애자"
wel$name[wel$name=="곽성숙"] <- "곽정숙"
wel$name[wel$name=="곽성숙"] <- "곽정숙"
wel$name[wel$name=="신장진"] <- "신상진"
wel$name[wel$name=="김명수"] <- "이명수"
wel$name[wel$name=="민형주"] <- "민현주"
wel$name[wel$name=="김상준"] <- "김상훈"

env$name[env$name=="김낙기"] <- "김락기"
env$name[env$name=="김악기"] <- "김락기"
env$name[env$name=="정두원"] <- "정두언"
env$name[env$name=="시용교"] <- "서용교"

envinfo$com[envinfo$com=="환노위"] <- "env"
welinfo$com[welinfo$com=="복지위"] <- "wel"

env <- env %>% 
  select(-party)
wel <- wel %>% 
  select(-party)

env_final <- left_join(env, envinfo, by=c("time","name","com"))
wel_final <- left_join(wel, welinfo, by=c("time","name","com"))

write.csv(env_final, "env_final.csv")
write.csv(wel_final, "wel_final.csv")
