from DataScraping import GithubAPI
import csv
api=GithubAPI()
issues = api.getIssues("https://api.github.com/repos/rails/rails/issues",5)
print('issues:')
print(issues)
with open("issues.csv", 'a', encoding='utf-8' ,newline="") as file:
        writer = csv.writer(file)

        writer.writerow(("id", "number", "issue_url", "repo_url", "events_url", "state", "html_url",
        "milestone", "title", "comments", "created_at", "uploaded_at", "closed_at"))

        for issue in issues:
            writer.writerow((issue["id"], issue["number"], issue["issue_url"], issue["repo_url"], issue["events_url"], issue["state"],
            issue["html_url"], issue["milestone"], issue["title"],
            issue["comments_count"], issue["created_at"], issue["updated_at"], issue["closed_at"]))


        # =======================================================================================
        print ("Creating labels.csv...")

with open("labels.csv", 'a', encoding='utf-8', newline="") as file:
        writer = csv.writer(file)

        writer.writerow(("issue_repo_url", "issue_id","issue_number", "label_id", "label"))

        for issue in issues:
            labels = issue["labels"]
            for label in labels:
                writer.writerow(( label["issue_repo_url"], label["issue_id"], label["issue_number"], label["label_id"], label["label"] ))