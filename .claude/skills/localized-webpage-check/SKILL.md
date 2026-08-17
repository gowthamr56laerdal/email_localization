---
name: localized-webpage-check
description: >
    Validate a webpage across all Laerdal locales and confirm each localized page's content language matches the mapping table. Use when the user gives a URL containing a "{Site Domain}" placeholder (or asks to check a page "across all languages/locales") and wants each localized version validated and language-checked.
---

# Localized Webpage Check

Given a URL template containing a `{Site Domain}` placeholder, validate every localized version of that page and confirm its content language matches the expected locale.

## Steps

1. Read `reference-library/language-mapping.md` to get the full list of `Language | Language Code | Site Domain` rows.
2. Build the full URL list by substituting each row's `Site Domain` into the `{Site Domain}` placeholder in the user's URL template. De-duplicate by domain if multiple language rows share the same Site Domain.
3. Invoke the `webpage-validator` agent (via the Agent tool) with:
   - The full list of built URLs, each paired with its expected `Language Code`.
   - Explicit instruction that this is an ad-hoc URL list, NOT an Excel file, so it should skip the Excel-reading steps and fetch the URLs directly.
   - Instruction to determine the actual content language of each fetched page and compare it against the expected `Language Code`, flagging MATCH/MISMATCH.
   - Instruction to return results (one row per URL) with columns:
    `# | URL | Status | Actual Content Language | Expected Language Code | Match | Notes`.
4. Write the returned results as a CSV file using the Write tool to `.temp/localized-webpage-check/{from the input URL}.csv`, with a header row matching the columns above. Do this automatically - do not ask the user first, and do not print the table in the terminal.
5. After writing the file, tell the user the file path and give a short one-line summary (e.g. how many rows, any mismatches/errors/redirects). If any row is a mismatch, error, or redirect, call it out explicitly in that summary.

## Notes

- This skill is read-only against the repo (only reads `language-mapping.md`) and always writes its results to a CSV under `.temp/localized-webpage-check/` - it never dumps the full table into the terminal.
- If the user's URL template has no `{Site Domain}` placeholder but otherwise implies "check across all locales," ask where in the URL the domain/locale segment goes before proceeding.
- Do NOT use the excel MCP server for CSV output, even if asked to use "only excel MCP server." That server can only open pre-existing valid `.xlsx` zip binaries — it fails on both a brand-new file (`system cannot find the file`) and a plain-text `.csv` (`zip: not a valid zip file`). It cannot originate a CSV. Use the Write tool and, if the user specifically insisted on excel MCP only, explain this limitation before falling back to Write.
