# Are there any periods in which we get more issues?
issues <- read.csv("issues.csv")
#---------------------------------------------------
issues$created_at <- as.POSIXlt(issues$created_at)  


# ============= grouping by day ================
issues_grp_date = issues %>% group_by(created_at)  %>% summarise(total_issues = n())