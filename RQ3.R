# Is there anyone who reports more issues than others?
issues <- read.csv("issues.csv")
library(dplyr) #install.packages("dplyr")

issues_grp_user = issues %>% group_by(user_name)  %>%
                    summarise(total_iussues = n())

print(issues_grp_user)
png(file ="users_issues.png")
plot(issues_grp_user$total_iussues)
dev.off()