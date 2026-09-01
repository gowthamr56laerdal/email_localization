---
name: loc-reach-out
description: Draft a localization reach-out message to all the CSOs for a given campaign, pulling campaign details from Airtable and building the campaign's Airtable review link. Use when the user asks to "draft a reach-out", "reach out message", or "loc reach-out" for a named campaign.
---

# Local Reach-Out

Draft the standard localization reach-out message to all the CSOs for a named campaign, filling all placeholders from Airtable.

## Message template

```
Hello {local marketer},
This is regarding the new campaign {campaign name} from {GPMM} and we would like to roll it out on {CSO}. We've created the canvas, translated the EBs and set up the dates in Airtable. The campaign will be scheduled/activated on {date}. You're provided with 3 weeks for the review. In case if you find any hardstops, pause campaign, move date, modify EBs or anything else, please let me know by the activation date.

Airtable link:
{link}

Please let me know if you have question/doubts. Thank you
```

## Inputs

- Campaign name (required), provided as an argument when the skill is called.

## Placeholder mapping (Airtable fields)

1. `{local marketer}` - leave literally as `{local marketer}` in the output. Do not fill it in.
2. `{campaign name}` - the campaign's `Campaign Name` field.
3. `{GPMM}` - the campaign's `Initiator` field.
4. `{CSO}` - the name of one participating sales org. One message is generated per CSO (not one combined message with the whole `Participating Sales Orgs` list).
5. `{date}` - that specific CSO's EB1 `Send Date`, read from its own record in the `Emails` table. Each sales org has its own negotiated EB1 date - do NOT use the campaign-level `Global Send Date - EB1` field on the `Campaigns` table, it does not reflect per-org dates.
6. `{link}` - that specific CSO's `Campaign Canvases` record ID, built into the Airtable review link as per `.claude/skill-memory/airtable-url-params.md`. Do NOT use the `Campaigns` table's own record ID - the "Local Input Needed (Canvas)" interface page is sourced from the `Campaign Canvases` table, so a link built from the parent campaign record does not open a valid detail panel for that CSO.

## Steps

1. Use the Airtable MCP tools to find the campaign record:
   - `search_bases` for the "OneMarketing OS" base (base ID `appHeT6F6et4Sq3CR` per `.claude/skill-memory/airtable-url-params.md` - confirm it still resolves, don't assume it's unchanged).
   - `list_tables_for_base` to find the campaigns table and its fields.
   - `search_records` (or `list_records_for_table` with a filter) for the record whose `Campaign Name` matches the input campaign name given by the user.
2. From that record, read the `Initiator` field directly, and the `Participating Sales Orgs` field as the list of CSOs to loop over (one message per CSO, not one field pasted verbatim).
3. Resolve each CSO's own EB1 date:
   - For each participating sales org, query the `Emails` table filtered by `Email Campaign` = the campaign record, `EB` = `EB1`, and `Sales Org` = that CSO's record, then read that matching record's `Send Date` field.
   - If there is no matching record, or its `Send Date` is empty, skip that CSO's message and flag it to the user instead of guessing (see Notes).
4. Resolve each CSO's own `Campaign Canvases` record (for `{link}`):
   - For each participating sales org, find the `Campaign Canvases` record where `Campaign` = the campaign record and `Sales Orgs` = that CSO's record (match on the linked record, not by parsing the canvas record's name string).
   - Take that record's own Airtable record ID (`recXXXXXXXXXXXXXX`) - this is the CSO's record ID for the link, never the parent `Campaigns` record's ID.
   - If there is no matching `Campaign Canvases` record for a CSO, skip that CSO's message and flag it to the user instead of guessing (see Notes).
5. Build `{link}` following the pattern documented in `.claude/skill-memory/airtable-url-params.md`:
   `https://airtable.com/{Base ID}/{Page ID}?{Query param name}={Record ID}`
   Reuse the same Base ID, Page ID ("Local Input Needed (Canvas)" interface), and query param name shown in that file's example - only the record ID changes, and it changes per CSO (not just per campaign).
6. For each participating CSO, fill the message template with that CSO's own `{CSO}`, `{date}`, and `{link}` (and the shared `{campaign name}`, `{GPMM}`), leaving `{local marketer}` untouched.
7. Save all the drafted messages to a single file at `.temp\loc-reach-out\{campaign name}.txt` - one message block per CSO, separated by a blank line/divider so it's clear which message belongs to which CSO.

## Notes

- If the campaign name doesn't match any record, or a required field is empty, tell the user what's missing instead of guessing or leaving a raw placeholder in the output.
- Never invent or reuse a record ID/link from a different campaign or a different CSO. Every CSO's link must resolve to that CSO's own `Campaign Canvases` record - never fall back to the parent `Campaigns` record ID.
- Keep this sentence `You're provided with 3 weeks for the review` in a CSO's message only if the total no. of days between the current date and that CSO's own EB1 `Send Date` is greater than 17. This is evaluated per CSO (their dates differ), not once for the whole campaign. Otherwise, skip that sentence in that CSO's message.