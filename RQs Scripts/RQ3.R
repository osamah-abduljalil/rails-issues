# Is there anyone who reports more issues than others?
issues <- read.csv("issues.csv")

library(dplyr) #install.packages("dplyr")

issues_grp_user = issues %>% group_by(user_name)  %>% summarise(total_iussues = n())

print(nrow(issues_grp_user$total_iussues)) # count of users
print(min(issues_grp_user$total_iussues)) # count of minimum contributions
print(max(issues_grp_user$total_iussues)) # count of maximum contributions

users_stat <- issues_grp_user %>% group_by(total_iussues)  %>% summarise(count = n())
print(summary( users_stat))
# --------------------- find the user who has the maximum number of issues
max_user <- issues_grp_user %>% filter(total_iussues == max(issues_grp_user$total_iussues))
print(max_user[1]$user_name)
#-------------------- get only max user issues 
max_user_issues <- issues %>% filter(user_name == max_user[1]$user_name)
#-------------------- get statistics about the state of the max user issues
max_user_state <- max_user_issues %>% group_by(state)  %>% summarise(count = n())
print(max_user_state)
#--------------------- get only closed issues related to max user
max_user_closed_issues <- max_user_issues %>% filter(state == "closed")
# convert created at and closed at into dates
max_user_closed_issues$created_at <- as.Date(max_user_closed_issues$created_at,format = "%Y-%m-%d")  
max_user_closed_issues$closed_at <- as.Date(max_user_closed_issues$closed_at,format = "%Y-%m-%d")  
#------------------- add issue age column ---------------
max_user_closed_issues$days_age <- as.numeric(difftime(max_user_closed_issues$closed_at,max_user_closed_issues$created_at,units="days"))
print(summary(max_user_closed_issues))

max_user_closed_issues_ages <- max_user_closed_issues %>% group_by(days_age)  %>% summarise(count = n())
print(max_user_closed_issues_ages)

max_user_closed_issues_comments <- max_user_closed_issues %>% group_by(comments_count)  %>% summarise(count = n())
print(max_user_closed_issues_comments)

max_user_closed_issues_labels <- max_user_closed_issues %>% group_by(labels_count)  %>% summarise(count = n())

print((max_user_closed_issues_labels))
print(summary(max_user_closed_issues_labels))

#----------------------- find the correlation between ages and labels count -------------------
ct<- cor.test(as.numeric(max_user_closed_issues$days_age),max_user_closed_issues$labels_count)
print(ct)
#-------------------
hist(summary(as.factor(issues$user_name)))
