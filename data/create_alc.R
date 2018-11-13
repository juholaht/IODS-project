# Juho Lahteenmaa

# 13/11/2018

# Data wrangling, week 3, data "Student Performance Data Set"

# https://archive.ics.uci.edu/ml/datasets/Student+Performance


####################################################################
# Packages
library(dplyr)
####################################################################




# Lets read both student-mat.csv and student-por.csv from data/student/ directory

data_student_mat <- read.csv("C:/Users/juhol/OneDrive/Documents/GitHub/IODS-project/data/student/student-mat.csv", header = T, sep = ";")

colnames(data_student_mat)

str(data_student_mat)

dim(data_student_mat)

summary(data_student_mat)

#View(data_student_mat)

data_student_por <- read.csv("C:/Users/juhol/OneDrive/Documents/GitHub/IODS-project/data/student/student-por.csv", header = T, sep = ";")

colnames(data_student_por)

str(data_student_por)

dim(data_student_por)

summary(data_student_por)

#View(data_student_por)








# Lets combine datasets

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(data_student_mat, data_student_por, by = join_by, suffix = c(".math", ".por"))

colnames(math_por)

str(math_por)

dim(math_por)

summary(math_por)

#View(math_por)




# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(data_student_mat)[!colnames(data_student_mat) %in% join_by]

# print out the columns not used for joining
notjoined_columns

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# glimpse at the new combined data

glimpse(alc)


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

glimpse(alc)


# Write data in csv

setwd("C:/Users/juhol/OneDrive/Documents/GitHub/IODS-project/data")

write.csv(alc, file = "alc.csv")
