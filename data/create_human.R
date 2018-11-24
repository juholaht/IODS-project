# Juho Lahteenmaa

# 24/11/2018

# IODS week 4

# Data wrangling



##############################################

# Packages

library(dplyr)

##############################################

# Import data

hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Meta files: http://hdr.undp.org/en/content/human-development-index-hdi

# http://hdr.undp.org/sites/default/files/hdr2015_technical_notes.pdf

# hd

View(hd)

str(hd)

dim(hd)

summary(hd)


# gii


View(gii)

str(gii)

dim(gii)

summary(gii)

# Rename variables

# hd

colnames(hd) <- c("rank_hdi", "country", "hdi", "life_exp", "exp_years_education", "mean_years_education", "gni", "gni_min_hdi")

# gii

colnames(gii) <- c("rank_gii", "country", "gii", "maternal_mortality_ratio", "adolescent_birth_rate", "female_parliament", "sec_edu_female", "sec_edu_male", "labour_rate_female", "labour_rate_male")


# New variables

# Ratio of Female and Male populations with secondary education in each country

gii <- mutate(gii, sec_edu_ratio = sec_edu_female/sec_edu_male)

# Ratio of labour force participation of females and males in each country

gii <- mutate(gii, labour_rate_ratio = labour_rate_female/labour_rate_male)


# Combine two datasets

human <- inner_join(hd, gii, by = "country")


View(human)
