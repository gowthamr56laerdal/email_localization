# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

`reference-library/` holds real, previously-sent Laerdal marketing emails and published articles in their translated (non-English) form, organized by language. Together they serve as tone and style reference material when translating or localizing new email content into these languages. This is now the primary tone reference for the @stripo-email-localizer agent, replacing the per-language tabs in `../Examples/Email Examples - AI Translation.xlsx` (that file remains the source used to regenerate the email reference files when new examples are added).

## Structure

Each language has its own folder, containing two Markdown files: `<code>-emails.md` and `<code>-articles.md`:

```
reference-library/
├── da/da-emails.md, da-articles.md   # Danish
├── de/de-emails.md, de-articles.md   # German
├── eo/eo-emails.md, eo-articles.md   # Spanish (Latin America) — see note below
├── es/es-emails.md, es-articles.md   # Spanish (Spain)
├── fi/fi-emails.md, fi-articles.md   # Finnish
├── fr/fr-emails.md, fr-articles.md   # French
├── it/it-emails.md, it-articles.md   # Italian
├── ja/ja-emails.md, ja-articles.md   # Japanese
├── ko/ko-emails.md, ko-articles.md   # Korean
├── nl/nl-emails.md, nl-articles.md   # Dutch
├── no/no-emails.md, no-articles.md   # Norwegian
├── pl/pl-emails.md, pl-articles.md   # Polish
├── pt/pt-emails.md, pt-articles.md   # Portuguese (Brazil)
├── sv/sv-emails.md, sv-articles.md   # Swedish
├── zh/zh-emails.md, zh-articles.md   # Chinese (Simplified)
└── language-mapping.md   # locale & domain mapping table.
```

Each `*-emails.md` file is a single Markdown table with one column per example email (currently 4) and one row per email field: `Subject`, `Preview Text`, `Title`, `Body`, `CTA`. Line breaks within a field are encoded as `<br>`/`<br><br>`, matching the HTML-export convention used in the Excel campaign files under `../Campaigns/`.

Each `*-articles.md` file is reference tone/style material sourced from published articles for that language — use it alongside the corresponding `*-emails.md` file when calibrating register and phrasing.

**Naming note:** the `eo` folder code is not ISO "Esperanto" — its content is Spanish (Latin America / Brazil-market examples), distinct from the Spain-market Spanish in `es`. Treat `eo` as a project-specific label, not a language code, when reading or adding content.

## Working with this content

- When asked to translate or check tone for a given language, read both the matching `<code>-emails.md` and `<code>-articles.md` files first and mirror their register, sentence length, and formatting conventions (e.g. use of `<br>` breaks, bolded product names).
- Preserve the existing table format (columns = examples, rows = fields) when adding new reference emails, and preserve the existing format of the corresponding `*-articles.md` file when adding new reference articles, so each file stays consistent with the others of its type.
- This is reference/example data, not campaign content to be edited or shipped — do not modify existing rows unless explicitly asked to correct or add reference examples.
