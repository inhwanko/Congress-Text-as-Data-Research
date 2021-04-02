
# 1. Load necessary packages
## Installing rJava and KoNLP requires the latest version of Rtools. Please use its version higher than 4.0.

# install.packages(c("tm","backports","tidyverse","tidytext","topicmodels","stringr","lda"))

library(tidyverse)
library(tidytext)
library(tm)
library(stringr)

Sys.setenv(JAVA_HOME="C:\\Program Files\\Java\\jre1.8.0_261")
# install.packages("rJava")
library(rJava)

# remotes::install_github("haven-jeon/KoNLP", upgrade="never", INSTALL_opts=c("--no-multiarch"))
library(KoNLP)


# 2. 16 ENV

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/3rd analysis - minutes/env16" 

env_16 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "○")

head(env_16)

speaker <- speech <- NULL
split <- strsplit(env_16$speech, "\n\n")

for (i in 1:nrow(env_16)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_env_16 <- data.frame(speaker=speaker, speech=speech)
unique_env_16 <- unique(result16)

write.csv(unique_env_16, "env16.csv")



# 3. 17 ENV

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/3rd analysis - minutes/env17" 

env_17 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "○")

head(env_17)

speaker <- speech <- NULL
split <- strsplit(env_17$speech, "\n\n")

for (i in 1:nrow(env_17)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_env_17 <- data.frame(speaker=speaker, speech=speech)
unique_env_17 <- unique(result17)

write.csv(unique_env_17, "env17.csv")



# 4. 18 ENV

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/3rd analysis - minutes/env18" 

env_18 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "○")

head(env_18)

speaker <- speech <- NULL
split <- strsplit(env_18$speech, "\n\n")

for (i in 1:nrow(env_18)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_env_18 <- data.frame(speaker=speaker, speech=speech)
unique_env_18 <- unique(result18)

write.csv(unique_env_18, "env18.csv")


# 5. 19 ENV

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/3rd analysis - minutes/env19" 

env_19 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "○")

head(env_19)

speaker <- speech <- NULL
split <- strsplit(env_19$speech, "\n\n")

for (i in 1:nrow(env_19)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_env_19 <- data.frame(speaker=speaker, speech=speech)
unique_env_19 <- unique(result19)

write.csv(unique_env_19, "env19.csv")


# 6. 20 ENV

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/3rd analysis - minutes/env20" 

env_20 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "○")

head(env_20)

speaker <- speech <- NULL
split <- strsplit(env_20$speech, "\n\n")

for (i in 1:nrow(env_20)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_env_20 <- data.frame(speaker=speaker, speech=speech)
unique_env_20 <- unique(result20)

write.csv(unique_env_20, "env20.csv")


# 7. 16 WEL

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/disruptminute/wel16" 

wel_16 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "○")

head(wel_16)

speaker <- speech <- NULL
split <- strsplit(wel_16$speech, "\n\n")

for (i in 1:nrow(wel_16)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_wel_16 <- data.frame(speaker=speaker, speech=speech)
unique_wel_16 <- unique(result_wel_16)

write.csv(unique_wel_16, "wel16.csv")


# 8. 17 WEL

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/disruptminute/wel17" 

wel_17 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "◯")

head(wel_17)

speaker <- speech <- NULL
split <- strsplit(wel_17$speech, "\n\n")

for (i in 1:nrow(wel_17)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_wel_17 <- data.frame(speaker=speaker, speech=speech)
unique_wel_17 <- unique(result_wel_17)

write.csv(unique_wel_17, "wel17.csv")


# 9. 18 WEL

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/disruptminute/wel18" 

wel_18 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "◯")

head(wel_18)

speaker <- speech <- NULL
split <- strsplit(wel_18$speech, "\n\n")

for (i in 1:nrow(wel_18)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_wel_18 <- data.frame(speaker=speaker, speech=speech)
unique_wel_18 <- unique(result_wel_18)

write.csv(unique_wel_18, "wel18.csv")


# 10. 19 WEL

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/disruptminute/wel19" 

wel_19 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "◯")

head(wel_19)

speaker <- speech <- NULL
split <- strsplit(wel_19$speech, "\n\n")

for (i in 1:nrow(wel_19)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_wel_19 <- data.frame(speaker=speaker, speech=speech)
unique_wel_19 <- unique(result_wel_19)

write.csv(unique_wel_19, "wel19.csv")


# 11. 20 WEL

dir <- "C:/Users/inhwa/OneDrive - UW/Research/KorCongress/disruptminute/wel20" 

wel_20 <- VCorpus(DirSource(dir, encoding = "UTF-8"),
                  readerControl = list(language = "ko")) %>% 
  tidy() %>% 
  select(id, text) %>% 
  unnest_tokens(speech, text, token = stringr::str_split, pattern = "◯")

head(wel_20)

speaker <- speech <- NULL
split <- strsplit(wel_20$speech, "\n\n")

for (i in 1:nrow(wel_20)){
  speaker[i] <- split[[i]][1]
  speech[i] <- paste(unlist(split[[i]][-1]), collapse=" ")
}
result_wel_20 <- data.frame(speaker=speaker, speech=speech)
unique_wel_20 <- unique(result_wel_20)

write.csv(unique_wel_20, "wel20.csv")


