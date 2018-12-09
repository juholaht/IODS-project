# IODS week 6

# Analysis of longitudinal data

# Wrangling

##########################################################
# Packages

library(dplyr)
library(tidyr)
##########################################################

BPRS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", stringsAsFactors = F, sep = "", header = T)

RATS <- read.csv("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", stringsAsFactors = F, sep = "\t", header = T)

View(BPRS)

str(BPRS)

colnames(BPRS)

summary(BPRS)


View(RATS)

str(RATS)

colnames(RATS)

summary(RATS)


# Categorical variables to factors

BPRS$treatment <- as.factor(BPRS$treatment)

BPRS$subject <- as.factor(BPRS$subject)


RATS$ID <- as.factor(RATS$ID)

RATS$Group <- as.factor(RATS$Group)

# Data sets to long form

BPRSL <-  BPRS %>% 
  gather(key = weeks, value = bprs, -treatment, -subject) %>%
  mutate(week = as.integer(substr(weeks, 5, 5)))


RATSL <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD, 3,4))) 

# Summarys for long form data

View(BPRSL)

str(BPRSL)

colnames(BPRSL)

summary(BPRSL)


View(RATSL)

str(RATSL)

colnames(RATSL)

summary(RATSL)


# Write data in csv

setwd("C:/Users/juhol/OneDrive/Documents/GitHub/IODS-project/data")

write.csv(BPRSL, file = "BPRS_WRANGLED.Rdata")
write.csv(RATSL, file = "RATSL_WRANGLED.Rdata")
