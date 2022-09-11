# Are there any periods in which we get more issues?
issues <- read.csv("issues.csv")
#---------------------------------------------------
issues$created_at <- as.POSIXlt(issues$created_at) 

# ============= grouping by day ================
issues_grp_date = issues %>% group_by(created_at)  %>% summarise(total_issues = n())
issues_grp_date$day_name <- format(issues_grp_date$created_at,format="%u") 
ct<- cor.test(as.numeric(issues_grp_date$day_name),issues_grp_date$total_issues)
print(ct)

issues_grp_day = issues_grp_date %>% group_by(day_name)  %>% summarise(total_issues = sum(total_issues))


png(file = "boxplot.png")
# Plot the chart.
boxplot(issues_grp_date$total_issues ~ as.numeric(issues_grp_date$day_name), data = mtcars, xlab = "Days of the week", ylab = "Number of issues", main = "Number of Issues Distribution Data")

# Save the file.
dev.off()
