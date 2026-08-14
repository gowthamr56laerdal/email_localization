---
name: open-links-in-browser
description: >
    Open a list of URLs in the user's default Windows browser using PowerShell
    Start-Process. Use when the user asks to "open these links/URLs in my browser
    /chrome", including opening all links for a specific locale (e.g. "/de/") pulled
    from a validation CSV or Excel file.
---

# Open Links in Browser

Open a set of URLs directly in the user's default browser via PowerShell, without
requiring the Claude in Chrome extension.

## Steps

1. Determine the URL list from context:
   - If the user references a locale (e.g. "all the /de/ urls") and a prior
     `*_URL_LOG.csv` validation output exists, grep that CSV for matching rows and
     extract the URLs.
   - If the user pastes/names URLs directly, use those as-is.
2. Build a PowerShell array of the URLs and open each with `Start-Process`:

   ```powershell
   $urls = @(
   "https://example.com/de/page-one/",
   "https://example.com/de/page-two/"
   )
   foreach ($u in $urls) { Start-Process $u }
   ```

3. Run this via the PowerShell tool. Each `Start-Process $u` call opens the URL in
   the system default browser in a new tab/window — no extension or login required.
4. Confirm to the user how many links were opened and from what source (e.g. "Opened
   all 12 /de/ URLs from the CBE/CPR/HQI EB7 logs").

## Notes

- This does not require the Claude in Chrome extension — it shells out to the OS,
  so it works even if the user has declined that extension.
- Only use this for legitimate, user-approved URLs already present in the project's
  Excel/CSV files or explicitly provided by the user. Do not guess or fabricate URLs.
- If the URL list is large (dozens+), warn the user before opening, since each one
  spawns a new browser tab.
