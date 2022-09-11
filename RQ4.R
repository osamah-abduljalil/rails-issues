# What is the most popular category (label)? 
labels <- read.csv("labels.csv")

library(dplyr) #install.packages("dplyr")

labels_grp <- labels %>% group_by(label)  %>% summarise(count = n())

print(summary(labels_grp))
labels_grp_stat <- labels_grp %>% group_by(count)  %>% summarise(issue_count = n())

print(labels_grp_stat)
max_label <- labels_grp %>% filter(count == max(labels_grp$count))
max_label_data <- labels %>% filter(label == max_label$label)

#----------------------------------------------------------------------
issues <- read.csv("issues.csv")
max_label_issues <- issues %>% filter(number  %in%  max_label_data$issue_number)
#--------------------------------------------------
max_label_state <- max_label_issues %>% group_by(state)  %>%summarise(count = n())
print(max_label_state)
#--------------------------------------------------
max_label_closed <- max_label_issues %>% filter(state == "closed")
max_label_state_reason <- max_label_closed %>% group_by(state_reason)  %>%summarise(count = n())
print(summary(max_label_issues$comments_count))
#----------------- 
hist(summary(as.factor(labels$label)))
