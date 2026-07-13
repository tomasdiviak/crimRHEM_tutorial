##### Relational Hyperevent Model example - US co-offending network #####

# install & load the package survival for fitting Cox PH models
install.packages("survival")
library(survival)

# set the working directory
#setwd("yourDir")

# read the output data of eventnet - violent offences
violEv <- read.table("UScooffSubsetEventsUp_VIOLENT.txt", 
                     header = TRUE, sep = "\t")
head(violEv)

# distribution of event sizes (number of participants)
summary(violEv$num.participants[violEv$IS_OBSERVED == 1])
sum(violEv$IS_OBSERVED == 1)  # 1605

# square-root standardisation of network predictors
violEv[,c(21:ncol(violEv))] <- sqrt(violEv[,c(21:ncol(violEv))])

# Cox PH model for violent offences
violRHEM1 <- coxph(Surv(time = rep(1,nrow(violEv)), event = violEv$IS_OBSERVED) ~
                     avg.age + diff.age + avg.male + diff.male + 
                     avg.black + avg.white + diff.race
                   + violent.repetition
                   #+ violent.sub.rep.1 
                   #+ violent.sub.rep.2
                   + violent.sub.rep.GW
                   + violent.degree
                   + violent.closure
                   + property.repetition
                   #+ property.sub.rep.1 
                   #+ property.sub.rep.2
                   + property.sub.rep.GW
                   + property.degree
                   + property.closure
                   + strata(TIME)
                   , control = coxph.control(iter.max = 40)
                   , data = violEv)
summary(violRHEM1)

# Cox PH model
violRHEM2 <- coxph(Surv(time = rep(1,nrow(violEv)), event = violEv$IS_OBSERVED) ~
                     avg.age + diff.age + avg.male + diff.male + 
                     avg.black + avg.white + diff.race
                   #+ violent.repetition
                   + violent.sub.rep.1 
                   #+ violent.sub.rep.2
                   + violent.sub.rep.GW
                   + violent.degree
                   + violent.closure
                   #+ property.repetition
                   + property.sub.rep.1 
                   #+ property.sub.rep.2
                   + property.sub.rep.GW
                   + property.degree
                   + property.closure
                   + strata(TIME)
                   , control = coxph.control(iter.max = 40)
                   , data = violEv)
summary(violRHEM2)

# read the output data of eventnet - property offences
propEv <- read.table("UScooffSubsetEventsUp_PROPERTY.txt", 
                     header = TRUE, sep = "\t")
head(propEv)

# distribution of event sizes (number of participants)
summary(propEv$num.participants[propEv$IS_OBSERVED == 1])
sum(propEv$IS_OBSERVED == 1)  # 1555

# square-root standardisation of network predictors
propEv[,c(21:ncol(propEv))] <- sqrt(propEv[,c(21:ncol(propEv))])

# Cox PH model for violent offences
propRHEM1 <- coxph(Surv(time = rep(1,nrow(propEv)), event = propEv$IS_OBSERVED) ~
                     avg.age + diff.age + avg.male + diff.male + 
                     avg.black + avg.white + diff.race
                   + violent.repetition
                   #+ violent.sub.rep.1 
                   #+ violent.sub.rep.2
                   + violent.sub.rep.GW
                   + violent.degree
                   + violent.closure
                   + property.repetition
                   #+ property.sub.rep.1 
                   #+ property.sub.rep.2
                   + property.sub.rep.GW
                   + property.degree
                   + property.closure
                   + strata(TIME)
                   , control = coxph.control(iter.max = 40)
                   , data = propEv)
summary(propRHEM1)

# Cox PH model
propRHEM2 <- coxph(Surv(time = rep(1,nrow(propEv)), event = propEv$IS_OBSERVED) ~
                     avg.age + diff.age + avg.male + diff.male + 
                     avg.black + avg.white + diff.race
                   #+ violent.repetition
                   + violent.sub.rep.1 
                   #+ violent.sub.rep.2
                   + violent.sub.rep.GW
                   + violent.degree
                   + violent.closure
                   #+ property.repetition
                   + property.sub.rep.1 
                   #+ property.sub.rep.2
                   + property.sub.rep.GW
                   + property.degree
                   + property.closure
                   + strata(TIME)
                   , control = coxph.control(iter.max = 40)
                   , data = propEv)
summary(propRHEM2)