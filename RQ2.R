# Are there any periods in which we get more issues?
issues <- read.csv("issues.csv")
#---------------------------------------------------
print(max(issues$created_at))
print(difftime(max(issues$created_at),min(issues$created_at), units = "days"))