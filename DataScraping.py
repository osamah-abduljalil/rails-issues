from unittest import result
import requests
import collections
from openpyxl import Workbook


class GithubAPI:
    results = []
    raw = []
    issues_payload = {
        "per_page": 100,
        "page": 1,
        "state": "all",
    }
    auth = {"Authorization": "token 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"}

    def getIssues(self, url,pages):

        self.issues_payload = {
        "per_page": 100,
        "page": 1,
        "state": "all",
        }

        self.raw = []

        r = requests.get(url, params=self.issues_payload, headers=self.auth).json()
        
        for i in range(pages):
            self.raw += r

            if len(r) == 100:
                self.issues_payload["page"] += 1
                r = requests.get(url, params=self.issues_payload, headers=self.auth).json()
            else:
                break
        for e in self.raw:
            print("Checking issue " + str(e["number"]))

            issue = collections.OrderedDict()
            issue["id"] = e["id"]
            issue["number"] = e["number"]
            issue["repo_url"] = e["repository_url"]
            issue["issue_url"] = e["url"]
            issue["events_url"] = e["events_url"]
            issue["state"] = e["state"]
            issue["html_url"] = e["html_url"]
            issue["title"] = e["title"]
            issue["description"] = e["body"]
            issue["comments"] = e["comments"]
            issue["created_at"] = e["created_at"]
            issue["updated_at"] = e["updated_at"]
            issue["closed_at"] = e["closed_at"]
            if not e["milestone"]:
                 issue["milestone"] = "null"
            else:
                 issue["milestone"] = e["milestone"]["title"]

            

            self.results.append(issue)

   