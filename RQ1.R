issues <- read.csv("issues.csv")
issues$week_num <- strftime(issues$created_at, format = "%V")
issues$created_at <- as.POSIXlt(issues$created_at)  

# ============= grouping by day ===============================================
issues_grp_date = issues %>% group_by(created_at)  %>% summarise(total_issues = n())
issues.time<-issues_grp_date$total_issues
time1.ts<- ts(issues.time,frequency=2)
time1.stl<- stl(time1.ts,s.window="periodic")
png(file = "time-seies.png")
plot(time1.stl)
dev.off()