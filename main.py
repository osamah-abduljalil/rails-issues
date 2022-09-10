from DataScraping import GithubAPI
api=GithubAPI()
issues = api.getIssues("https://api.github.com/repos/rails/rails/issues",5)
print(issues)