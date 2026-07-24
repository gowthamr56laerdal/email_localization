# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

`reference-library/` holds real, previously-sent Laerdal marketing emails in their translated (non-English) form, organized by language. They serve as tone and style reference material when translating or localizing new email content into these languages. This is now the primary tone reference for the @stripo-email-localizer agent, replacing the per-language tabs in `../Examples/Email Examples - AI Translation.xlsx` (that file remains the source used to regenerate these files when new examples are added).

## Structure

Each language has its own folder, containing a single Markdown file named `<code>-emails.md`:

```
reference-library/
├── da/da-emails.md   # Danish
├── de/de-emails.md   # German
├── eo/eo-emails.md   # Spanish (Latin America) — see note below
├── es/es-emails.md   # Spanish (Spain)
├── fi/fi-emails.md   # Finnish
├── fr/fr-emails.md   # French
├── it/it-emails.md   # Italian
├── ja/ja-emails.md   # Japanese
├── ko/ko-emails.md   # Korean
├── nl/nl-emails.md   # Dutch
├── no/no-emails.md   # Norwegian
├── pl/pl-emails.md   # Polish
├── pt/pt-emails.md   # Portuguese (Brazil)
├── sv/sv-emails.md   # Swedish
└── zh/zh-emails.md   # Chinese (Simplified)
```

Each `*-emails.md` file is a single Markdown table with one column per example email (currently 4) and one row per email field: `Subject`, `Preview Text`, `Title`, `Body`, `CTA`. Line breaks within a field are encoded as `<br>`/`<br><br>`, matching the HTML-export convention used in the Excel campaign files under `../Campaigns/`.

**Naming note:** the `eo` folder code is not ISO "Esperanto" — its content is Spanish (Latin America / Brazil-market examples), distinct from the Spain-market Spanish in `es`. Treat `eo` as a project-specific label, not a language code, when reading or adding content.

## Working with this content

- When asked to translate or check tone for a given language, read the matching `<code>-emails.md` file first and mirror its register, sentence length, and formatting conventions (e.g. use of `<br>` breaks, bolded product names).
- Preserve the existing table format (columns = examples, rows = fields) when adding new reference emails, so the file stays consistent with the others.
- This is reference/example data, not campaign content to be edited or shipped — do not modify existing rows unless explicitly asked to correct or add reference examples.
