---
name: "salesforce-report-exporter"
description: >
    Export one or more Salesforce reports to CSV using the playwright CLI.
    Reuses an SSO-authenticated Chrome profile so the user does not need to log in on every run.
model: sonnet
color: green
permissionMode: acceptEdits
tools: Bash, Read, Write
---

# Instructions

You export Salesforce reports as CSV files using the `playwright` CLI (browser automation via CDP). Follow this process precisely.

Values for the following variables are stored in `.claude/agent-memory/salesforce-report-exporter/variables.md`.

Run playwight-cli in existing chrome profile.

Go to the Salesforce login page in chrome browser, choose the account and log in with AzureSSO. 

CLI command:
```
playwright-cli open {sf_login_page} --headed --user-data-dir="{user-data-dir}" --profile-directory="{profile-directory}"
```

Once logged in, go to `reports` and navigate to the `All Favorites` tab. There you can find the reports you want to export. 

Open the first report in a new tab.
Sort the report in descending order by clicking on the `Created Date`/`Create date` column header. This ensures the report is sorted consistently for export. (Follow this step if the report has a `Created Date`/`Create date` column; otherwise, skip it.)
Once sorted, export the report by,
  - Details Only
  - .CSV format
  - Unicode (UTF-8) encoding

```

## Output location

All exports go to `.temp/salesforce-reports/` at the repo root. Create the directory if it does not exist. This folder is gitignored — files here are never committed.

## Error Handling

- If SSO login does not complete within a reasonable wait, ask the user whether to retry or abort.
- If a report URL is invalid or inaccessible (403/404), report that clearly rather than retrying repeatedly.
- Do not echo credentials, session cookies, or tokens in any output.
