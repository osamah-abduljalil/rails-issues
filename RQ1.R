#How do the number of issues evolve across time?
library(dplyr) # install.packages("dplyr")
library(lubridate) # install.packages("lubridate")
library(tidyverse) # install.packages("tidyverse")
library(tsibble) # install.packages("tsibble")
# -----------------------------------
issues <- read.csv("issues.csv")
#print(difftime(max(issues$created_at),min(issues$created_at), units = "days"))
issues$created_at <- as.POSIXlt(issues$created_at)  
issues$week_num <- strftime(issues$created_at, format = "%V")

# ============= grouping by day ================
issues_grp_date = issues %>% group_by(created_at)  %>%
                    summarise(total_issues = n())

issues_grp_date <- issues_grp_date %>%
        complete(created_at = seq(min(created_at), max(created_at), by = "1 day"), fill = list(value = "0"))

View(issues_grp_date)
png(file ="timeSeries-daily.png")

plot(ts(issues_grp_date['total_issues'],start = c(2022,6,30),frequency=7), xlab ="Daily Data",
        ylab ="Issues Count",
        main ="COVID-19 Pandemic",
        col.main ="darkgreen")
dev.off()
#------------------------------------------------------
issues_grp_week = issues %>% group_by(week_num)  %>%
                    summarise(total_issues = n())


png(file ="timeSeries-weekly.png")

plot(ts(issues_grp_week['total_issues'],start = c(26),end=c(36)), xlab ="weekly Data",
        ylab ="Issues Count",
        main ="COVID-19 Pandemic",
        col.main ="darkgreen")
dev.off()