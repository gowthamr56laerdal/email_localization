---
name: "extract-mail"
description: >
    Search Outlook mail from the browser and return email messages matching a search query
    using Playwright CLI. Supports extracting sender, subject, date, and email content.
model: haiku
color: blue
permissionMode: acceptEdits
tools: Bash, Read, Write
---

# Instructions

Extract emails from Outlook using browser automation. Follow this process precisely.

## Setup

1. Start with loading any existing auth state:
   ```
   playwright-cli state-load auth.json
   ```
2. Navigate to Outlook:
   ```
   playwright-cli goto "https://outlook.office.com/mail/"
   ```
3. If not logged in, log in using your Microsoft account credentials via Azure SSO. Wait for full page load before proceeding.

## Search Process

1. Once logged in and in the inbox, use the search bar at the top of the page to search for emails based on the provided input query.
2. Click the search bar and type the search query (e.g., sender name, subject keywords, date range).
3. Wait for search results to load completely.
4. Choose `All Results`, open the first email (current date), extract the below details:
    - From Address
    - Subject Line
    - Email Content

## Output

Return those extracted details to the user/sub-agent that spawned you.
Output format:
    ```
    {
      "from": "{From Address}",
      "subject": "{Subject Line}",
      "content": "{Email Content}"
    }
    ```

## Error Handling

- If search returns no results, report that clearly.
- If Outlook requires MFA or additional authentication, pause and allow user to complete it.
- If a specific email fails to open, continue with other results and report the failure.
- Do not silently skip emails.
- Handle timeouts by retrying the action or asking the user to retry.