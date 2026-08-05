# Webpage Validator Process

Exact process to follow when validating laerdal.com links from a user-provided Excel file:

1. Load `mcp__excel__excel_describe_sheets` and `mcp__excel__excel_read_sheet` via ToolSearch before calling them.
2. Call `excel_describe_sheets` first to discover the sheet name (do NOT assume "Sheet1" — the sheet is typically named "Translations").
3. Call `excel_read_sheet` on the correct sheet to get all cell values.
4. Extract all cell values containing `laerdal.com` (ignore CDN/image URLs from stripocdn.email — only check laerdal.com links). Skip any links matching `URL-exceptions.md`.
5. Load `WebFetch` via ToolSearch.
6. Check all laerdal.com links in parallel, but cap each parallel batch at ~10 WebFetch calls (not all 24+ locales at once) to avoid misattributing a result to the wrong URL when collating many simultaneous results.
7. Build the URL→status mapping keyed explicitly by the exact URL string (not by list position/order), so a result can never silently shift onto the wrong row.
8. Before finalizing, verify the number of mapped results equals the number of URLs checked, and spot-check any locale whose result is inconsistent with sibling locales/links for the same page family (e.g., a locale that works for 3 of 4 links but fails on the 4th, or vice versa) — re-fetch that one directly to confirm rather than trusting the batch result.
9. Report results in chat in the format: `URL: Status`
10. Create an output CSV file in the SAME folder as the input file. Filename: `{input_filename}_URL_LOG.csv`. The Excel MCP cannot create new files from scratch - use the Write tool to create the CSV directly. Columns: `Webpage link`, `Status`. Status values: Available, 404 Not Found, Does not exist, Unavailable, Other errors.

**Why:** Confirmed as the correct process after a successful run on the TEST CAMPAIGN file. Step 10 (CSV output) was added after the output file was missing — it is required by the agent definition. Steps 6-8 (batch cap, explicit keying, consistency spot-check) were added 2026-07-02 after a large 24-locale parallel batch produced a false positive: laerdal.com/fr/.../scaffolding-learning-in-cbe-with-simzones-and-vrclinicals/ was logged as "Available" in the CSV but a manual re-check confirmed it actually 404s. Likely cause: result misattribution across a large parallel WebFetch batch.

**How to apply:** Every time this agent is invoked, follow steps 1-10 above without deviation. Do NOT skip the CSV output file creation. Do NOT batch more than ~10 WebFetch calls at once, and always spot-check inconsistent-looking results before trusting them.
