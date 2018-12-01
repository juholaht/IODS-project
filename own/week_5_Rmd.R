# Week 5 R for Rmd


# Packages ----------------------------------------------------------------

library(GGally)
library(ggplot2)
library(dplyr)
library(corrplot)
library(tidyr)
library(FactoMineR)
# Import data -------------------------------------------------------------



human <- read.csv("C:/Users/juhol/OneDrive/Documents/GitHub/IODS-project/data/human.csv", sep  =",", header = T, row.names = 1)



# Lookup data -------------------------------------------------------------

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)


# visualize the 'human' variables


my_fn <- function(data, mapping, ...){
  p <- ggplot(data = data, mapping = mapping) + 
    geom_point() + 
    geom_smooth(method=loess, fill="red", color="red", ...) +
    geom_smooth(method=lm, fill="blue", color="blue", ...)
  p
}



ggpairs(human, lower = list(continuous = my_fn))

# compute the correlation matrix and visualize it with corrplot
cor(human)

cor(human)

cor(human) %>% corrplot


# PCA not standardized ----------------------------------------------------

pca_human_not_std <- prcomp(human)

sum_pca_human_not_std <- summary(pca_human_not_std)

# rounded percetanges of variance captured by each PC
pca_pr_not_std <- round(100*sum_pca_human_not_std$importance[2, ], digits = 3)

# print out the percentages of variance
pca_pr_not_std

# create object pc_lab to be used as axis labels
pc_lab_not_std <- paste0(names(pca_pr_not_std), " (", pca_pr_not_std, "%)")

# draw a biplot
biplot(pca_human_not_std, cex = c(0.8, 1), col = c("grey40", "deeppink2"), xlab = pc_lab_not_std[1], ylab = pc_lab_not_std[2])


# PCA standardized --------------------------------------------------------

human_std <- scale(human)

pca_human <- prcomp(human_std)

sum_pca_human <- summary(pca_human)

# rounded percetanges of variance captured by each PC
pca_pr <- round(100*sum_pca_human$importance[2, ], digits = 3)

# print out the percentages of variance
pca_pr

# create object pc_lab to be used as axis labels
pc_lab <- paste0(names(pca_pr), " (", pca_pr, "%)")

# draw a biplot
biplot(pca_human, cex = c(0.8, 1), col = c("grey40", "deeppink2"), xlab = pc_lab[1], ylab = pc_lab[2])




# Tea time ----------------------------------------------------------------


# Import data -------------------------------------------------------------


tea <- read.table("http://factominer.free.fr/book/tea.csv",header=TRUE,sep=";")

colnames(tea)



# Overlook in tea data ----------------------------------------------------

str(tea)

summary(tea)

# Splitting the plot

colnames(tea)

tea_subset_1 <- dplyr::select(tea, breakfast:pub)

tea_subset_2 <- dplyr::select(tea, variety:frequency) %>% select(-age)

tea_subset_3 <- dplyr::select(tea, exotic:no.effect.health)

# visualize the dataset

gather(tea_subset_1) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar() + theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))
  
gather(tea_subset_2) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar() + theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))

gather(tea_subset_3) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar() + theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))


# MCA ---------------------------------------------------------------------
 
# Lets select subset of data. Why people are drinking tea?

tea_time <- dplyr::select(tea, exotic, spirituality, good.for.health, diuretic, friendliness, iron.absorption, feminine, refined, slimming, stimulant, relaxant, no.effect.health)

gather(tea_time) %>% ggplot(aes(value)) + facet_wrap("key", scales = "free") + geom_bar() + theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8))


# multiple correspondence analysis
mca <- MCA(tea_time, graph = FALSE)

# summary of the model
summary(mca)

# visualize MCA
plot(mca, invisible=c("ind"), habillage = "quali")
