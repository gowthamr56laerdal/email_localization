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

Empty the `.temp/salesforce-reports/` folder before starting the export, if any files are present. 

Export Salesforce reports as CSV files using the `playwright` CLI (browser automation via CDP). Follow this process precisely.

Go to the Salesforce login page in chrome browser, choose the account and log in with AzureSSO. 

Initial CLI commands:
```
playwright-cli open
playwright-cli state-load auth.json
playwright-cli goto "https://laerdal.lightning.force.com/lightning/page/home"
```

Note: `playwright-cli open` must be run first to start the browser session, otherwise `state-load`/`goto` will fail with "Browser 'default' is not open".

If `auth.json` is stale/expired, `goto` will redirect to the Salesforce login page. Click "Log in with AzureSSO" and wait; the Microsoft sign-in may auto-complete (passkey/Windows Hello) without further input. After a successful login, immediately run `playwright-cli state-save auth.json` to refresh the stored session for next time.

After logging in,
1. Read `.claude\agent-memory\salesforce-report-exporter\variables.jsonl` to get the list of Salesforce report URLs.
2. Sort the report in descending order by clicking on the drop-down next to the `Created Date`/`Create date`/`Member First Associated Date` column header. This ensures the report is sorted consistently for export. 
    - Follow this step if the report has a `Created Date`/`Create date` column; otherwise, skip it.
    - This column can be virtualized out of view (hidden behind many other columns, e.g. UTM fields). Scroll the grid horizontally before concluding the column doesn't exist. 
3. Wait until the table gets sorted. Then, export the report by,
    - Details Only
    - .CSV format
    - Unicode (UTF-8) encoding
4. After submitting, if you're asked for verification code, spawn `.claude\agents\extract-mail.md` agent by providing the search query as `Verify your identity in Salesforce`. Extract the verification code from the sub-agent's output and enter it in the browser to complete the export.
5. Save the exported file in the `.temp/salesforce-reports/` folder. While saving, give the name same as the report name. 
    - For example: If the Salesforce report name is `Salesforce Accounts`, save the file as `Salesforce Accounts.csv`.
6. Check each .csv file to ensure if it's sorted in descending order by `Created Date`/`Create date` column. If not, go back to salesforce and re-export the particular report based on my previous instructions.
    - Large report exports can take 10-30+ seconds to register as downloaded — poll for the file rather than assuming failure right away.
7. After successfully exporting the first report, work parellelly by spawning additional instances to export the remaining reports. Open each report in a new tab.

## Output location

All exports go to `.temp/salesforce-reports/` at the repo root. Create the directory if it does not exist.

## Error Handling

- If SSO login does not complete within a reasonable wait, ask the user whether to retry or abort.
- If a report URL is invalid or inaccessible (403/404), report that clearly rather than retrying repeatedly.
- Retry the failed browser action when appropriate.
- Do not silently skip a required export.
- Do not echo credentials, session cookies, or tokens in any output.
- Determine whether the failure is caused by page loading, Salesforce UI state, authentication, or browser automation.
- If Azure SSO or MFA requires user interaction, pause and allow the user to complete it.