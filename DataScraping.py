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

   