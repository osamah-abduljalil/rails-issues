issues <- read.csv("issues.csv")
issues$week_num <- strftime(issues$created_at, format = "%V") # add new coulmn which holds the number of week or the order of the week over all the year
issues$created_at <- as.POSIXlt(issues$created_at)  

# ============= grouping by day ===============================================
issues_grp_date = issues %>% group_by(created_at)  %>% summarise(total_issues = n())
issues.time<-issues_grp_date$total_issues # get only the number of issues
time1.ts<- ts(issues.time,frequency=2) # convert the number of issues into time series data type
time1.stl<- stl(time1.ts,s.window="periodic") # to decompose a time series into seasonal, trend and irregular components
png(file = "time-seies.png")
plot(time1.stl)
dev.off()