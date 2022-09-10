# What is the most popular category (label)? 
labels <- read.csv("labels.csv")

library(dplyr) #install.packages("dplyr")

labels_grp= labels %>% group_by(label)  %>%
                    summarise(count = n())

print(labels_grp)