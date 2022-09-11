# Is there anyone who reports more issues than others?
issues <- read.csv("issues.csv")

library(dplyr) #install.packages("dplyr")

issues_grp_user = issues %>% group_by(user_name)  %>%
                    summarise(total_iussues = n())

print(nrow(issues_grp_user$total_iussues)) # count of users
print(min(issues_grp_user$total_iussues)) # count of minimum contributer
print(max(issues_grp_user$total_iussues)) # count of maximum contributer



users_stat <- issues_grp_user %>% group_by(total_iussues)  %>% summarise(count = n())
print(summary( users_stat))

max_user <- issues_grp_user %>% filter(total_iussues == max(issues_grp_user$total_iussues))
print(max_user[1]$user_name)

max_user_issues <- issues %>% filter(user_name == max_user[1]$user_name)

max_user_state <- max_user_issues %>% group_by(state)  %>% summarise(count = n())
print(max_user_state)

max_user_closed_issues <- max_user_issues %>% filter(state == "closed")


max_user_closed_issues$created_at <- as.Date(max_user_closed_issues$created_at,format = "%Y-%m-%d")  
max_user_closed_issues$closed_at <- as.Date(max_user_closed_issues$closed_at,format = "%Y-%m-%d")  


max_user_closed_issues$days_age <- as.numeric(difftime(max_user_closed_issues$closed_at,max_user_closed_issues$created_at,units="days"))
print(summary(max_user_closed_issues))

max_user_closed_issues_ages <- max_user_closed_issues %>% group_by(days_age)  %>% summarise(count = n())
print(max_user_closed_issues_ages)

max_user_closed_issues_comments <- max_user_closed_issues %>% group_by(comments_count)  %>% summarise(count = n())
print(max_user_closed_issues_comments)

max_user_closed_issues_labels <- max_user_closed_issues %>% group_by(labels_count)  %>% summarise(count = n())

print((max_user_closed_issues_labels))
print(summary(max_user_closed_issues_labels))



