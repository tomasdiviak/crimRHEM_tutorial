######## corruption networks - Sarclad - RHEM data processing ########

library(lubridate)
library(dplyr)
library(stringr)
library(readxl)

#setwd("yourDir")

# plan: 1) import attributes and create Sarclad var rows and add.actor events 
# - this should have 2*n actors rows; for add.actor, give weight 1
# for Sarclad, weight = Sarclad var; add source + target (copy of the same)
# 2) rbind Sarclad & add.actor, then give them all the same earliest date
# 3) import the edgelist with events and filter day, time, source, target & type
# - merge day & time into date + give all events weight 1 
# 4) rbind the two datasets (check the same var names) 
# 5) give all events unique ID based on date and export to .csv

# loading the attribute data
SarAtt <- read_excel("Sarclad_relEvents.xlsx", sheet = 2, col_names = TRUE) 

# nr of actors 
numSarc <- length(SarAtt$actor)

# create a DF with "Sarclad" events
dummySarc <- data.frame(SarAtt$actor, SarAtt$actor,
                           rep("2004-06-10 00:00:00", numSarc),
                           rep("sarclad", numSarc),
                           SarAtt$Sarclad)
# add variable names
colnames(dummySarc) <- c("source", "target", "date", "type", "weight")

# reate a DF with "add.actor" events 
dummyAct <- data.frame(SarAtt$actor, SarAtt$actor,
                        rep("2004-06-10 00:00:00", numSarc),
                        rep("add.actor", numSarc),
                        rep(1, numSarc))
# add variable names
colnames(dummyAct) <- c("source", "target", "date", "type", "weight")

# bind them together
initEvents <- rbind(dummyAct, dummySarc)

# loading the rel events data
SarEv <- read_excel("Sarclad_relEvents.xlsx", sheet = 1, col_names = TRUE) 

# merging day and time into date and selecting only relevant columns
SarEv <- SarEv %>% 
  mutate(day = ymd(day),
         time2 = str_extract(time, pattern = "\\d+:\\d+:\\d+"),
         date = ymd_hms(paste(day, time2))) %>% 
  select(source, target, date, type)

# converting the date to character to preserve the format
SarEv$date <- as.character(SarEv$date)

# giving the same weight to all events
SarEv <- SarEv %>% 
  mutate(weight = 1)

# merge initial events and relational events
Sarclad <- rbind(initEvents, SarEv)

# generating event IDs based on the same time
Sarclad <- Sarclad %>%
  mutate(date_index = group_indices(., date) - 1) %>% 
  arrange(date_index)

# export to .csv
write.csv(Sarclad, "SarcladRHEM.csv")



