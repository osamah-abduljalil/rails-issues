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
        print(pages)
        
        

        return self.results.append(r)

   