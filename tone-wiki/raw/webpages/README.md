# Webpage Clips - Raw Source

Drop web-clipped Laerdal marketing pages here, one flat file per page, named `<LANG>_<n>.md`.

## Structure

```
webpages/
├── FR_1.md, FR_2.md, ...
├── DE_1.md, ...
├── JA_1.md, ...
```

`<LANG>` is uppercase, matching the language codes from the mapping table in `stripo-email-localizer.md` (FR, DE, JA, etc.).

## Rules

- Write-once: a new clip is a new numbered file. Never edit an existing file in place.
- Web copy is a different register than curated email examples (mixed authors, general marketing tone). Treat notes derived from this folder as **lower-confidence / supplementary** in the wiki, not equal-weight with `../emails/`.
- These are immutable raw sources. The wiki (`../../wiki/`) is the distilled, agent-maintained summary derived from these files.
