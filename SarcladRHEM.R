##### Relational Hyperevent Model example - Sarclad network #####

# install & load the package survival for fitting Cox PH models
install.packages("survival")
library(survival)

# set the working directory
#setwd("yourDir)

# read the output data of eventnet 
events <- read.table("SarcladRHEMnew_EMAILS_RANDOM_SENDER.txt", 
                     header = TRUE, sep = "\t")
head(events)

# distribution of event sizes (number of receivers)
summary(events$num.receivers[events$IS_OBSERVED == 1])
sum(events$IS_OBSERVED == 1)  # 112

# square-root standardisation of network predictors (columns 14-22)
events[,14:22] <- sqrt(events[,14:22])

rhem1 <- coxph(Surv(time = rep(1,nrow(events)), 
                    event = events$IS_OBSERVED) ~ 
                    receiver.avg.sarclad + sender.sarclad
                    + sender.receiver.abs.diff.sarclad 
                    + repetition + undirected.repetition
                    + sub.rep.receiver.GW
                    + sub.rep.sender.receiver.GW
                    + outdegree.receiver + indegree.sender + reciprocation 
                    + transitive.closure + cyclic.closure
                    + strata(EVENT_INTERVAL) 
                    , data = events
                    , control = coxph.control(iter.max = 180) 
)
summary(rhem1)

rhem2 <- coxph(Surv(time = rep(1,nrow(events)), 
                    event = events$IS_OBSERVED) ~ 
                 receiver.avg.sarclad + sender.sarclad
               + sender.receiver.abs.diff.sarclad 
               + repetition #+ undirected.repetition
               + sub.rep.receiver.GW
               + sub.rep.sender.receiver.GW
               + outdegree.receiver + indegree.sender + reciprocation 
               + transitive.closure + cyclic.closure
               + strata(EVENT_INTERVAL) 
               , data = events
               , control = coxph.control(iter.max = 180) 
)
summary(rhem2)
