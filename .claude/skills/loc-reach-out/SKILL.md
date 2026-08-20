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
4. `{CSO}` - the campaign's `Participating Sales Orgs` field.
5. `{date}` - the campaign's EB1 date (the `Date` on the campaign's EB1 record/field).
6. `{link}` - the Airtable review link, built as per `.claude/skill-memory/airtable-url-params.md`.

## Steps

1. Use the Airtable MCP tools to find the campaign record:
   - `search_bases` for the "OneMarketing OS" base (base ID `appHeT6F6et4Sq3CR` per `.claude/skill-memory/airtable-url-params.md` - confirm it still resolves, don't assume it's unchanged).
   - `list_tables_for_base` to find the campaigns table and its fields.
   - `search_records` (or `list_records_for_table` with a filter) for the record whose `Campaign Name` matches the input campaign name given by the user.
2. From that record, read the `Initiator` and `Participating Sales Orgs` fields directly.
3. Resolve the EB1 date:
   - If the campaign record has a direct EB1 date field, use it.
   - Otherwise, follow the link from the campaign record to its EB1 record (e.g. a linked "EBs" table) and read that record's `Date` field.
4. Get the campaign record's Airtable record ID (`recXXXXXXXXXXXXXX`).
5. Build `{link}` following the pattern documented in `.claude/skill-memory/airtable-url-params.md`:
   `https://airtable.com/{Base ID}/{Page ID}?{Query param name}={Record ID}`
   Reuse the same Base ID, Page ID ("Local Input Needed (Canvas)" interface), and query param name shown in that file's example - only the record ID changes per campaign.
6. Fill the message template with the values gathered above, leaving `{local marketer}` untouched.
7. Save all the drafted message outputs to `.temp\loc-reach-out\{campaign name}.txt`.
   - Group drafted messages based on the AP, AM, EMA, and Others

## Notes

- If the campaign name doesn't match any record, or a required field is empty, tell the user what's missing instead of guessing or leaving a raw placeholder in the output.
- Never invent or reuse a record ID/link from a different campaign.