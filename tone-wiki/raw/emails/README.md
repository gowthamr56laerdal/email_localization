# Email Examples - Raw Source

Drop example marketing email copy here, one file per language. Multiple examples for the same language go in the same file, as columns in a table.

## Structure

```
emails/
├── fr.md
├── de.md
├── ja.md
```

Use the language codes from the mapping table in `stripo-email-localizer.md` (fr, de, ja, etc.).

## File format

Each language file holds one table, one column per example email:

```
| | Example 1 | Example 2 |
|---|---|---|
| Subject | ... | ... |
| Body | ... | ... |
```

## Rules

- New examples are added as new columns in the language's table. Never edit an existing column's content in place - append a new column instead.
- Source: `Examples/Email Examples - AI Translation.xlsx` tabs, one language file per tab.
- These are immutable raw sources. The wiki (`../../wiki/`) is the distilled, agent-maintained summary derived from these files.
