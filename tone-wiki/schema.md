---
name: tone-wiki-schema
description: Governs how raw email/webpage sources are distilled into per-language tone pages, and how the translation agent queries them
metadata:
  type: reference
---

# Tone Wiki Schema

## Purpose

This is a persistent, compounding knowledge base of **translation tone and phrasing examples** across all markets Laerdal marketers translate into. It exists so future translation work is informed by accumulated, real examples rather than re-derived from scratch each time. You (the LLM) own the `wiki/` layer entirely — read from `raw/`, write and maintain everything in `wiki/`.


## Directory Structure

```
tone-wiki/
├── schema.md
├── raw/                     # immutable inputs
│   ├── emails/              # One file per language for emails
│   │   ├── README.md
│   │   ├── <lang-code>.md
│   │   ├── <lang-code>.md
│   │   ├── ...
│   └── webpages/            # numbered files per language for webpages
│       ├── README.md
│       ├── <lang-code>_1.md
│       ├── <lang-code>_2.md
│       ├── ...
└── wiki/
    ├── index.md                     # catalog of every page below
    ├── log.md                       # append-only ingestion changelog
    ├── sources/                     # one summary page per raw file
    │   ├── <lang-code>-email.md              # ← raw/emails/<lang-code>.md
    │   ├── <lang-code>-email.md              # ← raw/emails/<lang-code>.md
    │   ├── ...
    │   ├── <lang-code>-webpage-1.md          # ← raw/webpages/<lang-code>_1.md
    │   ├── <lang-code>-webpage-2.md          # ← raw/webpages/<lang-code>_2.md
    │   ├── ...
    ├── <lang-code>/
    │   ├── style-guide.md
    │   ├── tone.md
    │   ├── grammar-patterns.md
    │   ├── common-phrases.md
    │   ├── terminology.md
    │   ├── avoid.md
    │   └── source-consulted.md
    ├── <lang-code>/
    │   ├── style-guide.md
    │   ├── tone.md
    │   ├── grammar-patterns.md
    │   ├── common-phrases.md
    │   ├── terminology.md
    │   ├── avoid.md
    │   └── source-consulted.md
    ├── ...
```

## Raw Sources (`raw/`)

- `raw/emails/<lang-code>.md` - example marketing email copy, one file per language. Multiple examples for the same language live as columns in a table within that file (e.g. `fr.md`, `de.md`), rather than separate numbered files.
- `raw/webpages/<LANG>_<n>.md` - web-clipped Laerdal article pages, flat with an uppercase language prefix (e.g. `FR_1.md`, `FR_2.md`, `DE_1.md`).
- `<LANG>` matches the language codes in the mapping table in `stripo-email-localizer.md`, uppercase for webpages.
- Raw files are immutable once added: never edited, only appended as new numbered files - **except** for the mandatory image-stripping pass below, which edits the raw file in place.
- Email examples are the primary, high-confidence tone source. Webpage clips are secondary/supplementary - note this explicitly when a wiki entry is derived mainly from a webpage clip.

## Wiki Pages (`wiki/`)

### `wiki/sources/<name>.md`
One summary page per ingested raw file: what it is, which language/type, key takeaways extracted, and a pointer back to the raw file. This is the audit trail between raw input and the distilled pages below.

### `wiki/<lang-code>/`
One folder per language (same codes as the mapping table in `stripo-email-localizer.md`). Every language folder uses these fixed files:

1. **`style-guide.md`** - formal/informal address, honorifics (e.g. German Sie-form), spacing before colons, quote-mark style, capitalization
2. **`tone.md`** - overall voice/register descriptors for the language (e.g. warm vs. clinical, how directly it addresses the reader)
3. **`grammar-patterns.md`** - imperative vs. question CTAs, sentence length norms, clause structure
4. **`common-phrases.md`** - idiomatic marketing phrases seen more than once, with source refs (e.g. `wiki/sources/fr-email-2.md`)
5. **`terminology.md`** - approved terminology and brand terms for this language, distilled from sources
6. **`avoid.md`** - literal-translation traps observed in past attempts
7. **`source-consulted.md`** - list of `wiki/sources/` pages this folder was built/updated from, and whether each is primary (email) or supplementary (webpage)

Every file carries the same frontmatter conventions as other wiki pages (`name`, `description`, `metadata.type: reference`), with `name` scoped as `<lang-code>-<file-stem>` (e.g. `de-style-guide`) to stay unique across the wiki.

## Operations

### Ingest
When a new source is dropped into `raw/`:
1. **Mandatory, first, in-place edit of the raw file itself:** strip all images from the source file - remove markdown image syntax (`![...](...)`), linked-image wrappers (`[![...](...)](...)`, including ones spanning multiple lines), and inline `<svg>...</svg>` icon blocks, then collapse resulting blank lines. This step is not optional and is not skipped in batch mode; it must be done to every new raw file before it is read for takeaways, even if the rest of ingestion is deferred. We don't keep images in this wiki — only text content matters for tone/translation reference. When removing a linked-image wrapper, remove the whole wrapper (link + image), not just the inner `![...]`; a plain text link (e.g. `[View original](...)`) that happens to sit next to one is left untouched.
2. Read the (now image-stripped) source.
3. Summarize key takeaways with the user before writing anything.
4. Write/update a `wiki/sources/<name>.md` summary page.
5. Update the relevant `wiki/<lang-code>/` files - `style-guide.md`, `tone.md`, `grammar-patterns.md`, `common-phrases.md`, `terminology.md`, `avoid.md` - with new examples, corrections, or terminology. Wiki edits are additive/refining, not wholesale rewrites - unless a new source directly contradicts an existing note, in which case the page is corrected and the reason is logged.
6. Update `wiki/index.md`.
7. Append an entry to `wiki/log.md`, citing which raw file triggered the update.

Default to ingesting every new/untouched source found under `raw/` in one run (batch mode): read each one, summarize key takeaways, then write/update pages per source, and finish with one index update and one log entry per source. Only fall back to one-at-a-time, user-reviewed ingestion (pausing after each summary for confirmation before writing) when the user explicitly asks to review sources individually.

Before batch ingesting, identify which raw files are new/untouched by checking whether a matching `wiki/sources/<name>.md` page already exists - skip sources already ingested.

### Fallback Rule

If no `wiki/<lang-code>/` folder exists yet for a language, read `raw/` directly for that language and generate the folder (all seven files) as a byproduct of the current task.

### Query
When asked for translation guidance on a language or topic:
1. Read `wiki/index.md` first to find relevant pages.
2. Read the relevant `wiki/<lang-code>/` files.
3. Answer with citations to the specific wiki page(s) consulted.
4. If the answer produces a new durable insight (e.g. a comparison across languages, a newly identified pattern), offer to file it back into the wiki as a new or updated page rather than letting it disappear into chat history.

### Query Workflow (used by `stripo-email-localizer`)

- Before translating into a language, read every file in `wiki/<lang-code>/` for tone/style calibration.
- Do not rely on literal machine translation without this step (per the agent's tone requirements).

## Index and Log

- `wiki/index.md` - catalog of every page in `sources/`, each `<lang-code>/` folder, with a one-line description each.
- `wiki/log.md` - append-only. One line per wiki update: date, language, triggering raw file, section changed, reason.