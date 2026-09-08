---
name: localization-rules
description: HTML handling, URL substitution patterns, and structural rules for Stripo Excel localization tasks
metadata:
  type: feedback
---

# File Structure Pattern

Stripo Excel translation files follow this layout:
- Row 1: Campaign title (A1 only, B1-onward empty)
- Row 2: Headers - A2="id", B2="original(en)", then language codes (e.g., "fr", "ja", "nl", "no", "pl")
- Rows 3+: Copy rows (id in col A, English in col B, translations in remaining cols)
- Link rows: id values like "link_1", "link_2,link_3", etc. - apply URL domain substitution only
- Image rows: id values like "img_1", "img_2", etc. - skip entirely (do not copy or modify)

**Why:** This structure is consistent across all Stripo-exported campaign Excel files.

**How to apply:** Always check column A id value to determine row type before deciding to translate, map URL, or skip.

# URL Domain Substitution Rules

For link rows, replace the laerdal.com base domain with the language-specific domain:
- The path after the domain is PRESERVED exactly as-is
- Only the domain portion changes (e.g., laerdal.com/us -> laerdal.com/fr)
- Do NOT modify image CDN links (stripocdn.email URLs)

Example: https://laerdal.com/us/products/path/ -> https://laerdal.com/fr/products/path/

**Why:** Each market has its own Laerdal website with localized content at the correct domain.

# HTML Tag Handling

Stripo uses custom numbered tags like `<p_1>`, `<strong_8>`, `<br_3/>`, `<ul_21>`, `<li_13>` etc.
- These numbered tags must be preserved exactly including their numeric suffixes
- Translate only the visible text nodes between tags
- Do not add, remove, or renumber any tags
- Self-closing tags like `<br_18/>` must remain self-closing

**Why:** Stripo maps these numbered tags back to the original email template structure. Any change breaks the import.

# Tone Reference Check

Before finalizing translations for any language, you MUST first read both `reference-library/<lang-code>/<lang-code>-emails.md` AND `reference-library/<lang-code>/<lang-code>-articles.md`, and confirm both the matching `reference-library/<lang-code>/<lang-code>-emails.md` and `<lang-code>-articles.md` files were reviewed for tone calibration.
- If a language is missing one or both of these files in `reference-library/`, note this explicitly rather than skipping the check silently.
- Treat this as a REQUIRED VERIFICATION OR BLOCKING PRECONDITION STEP before output is considered complete.

**Why:** 
- The agent instructions require using both the emails and articles example files as tone references, but without an explicit checkpoint this can be skipped silently.
- Also ensures translations sound natural and match Laerdal's established marketing voice per language, rather than reading as generic machine translation.

**How to apply:** Treat as a pre-completion checklist item for every language column being translated, alongside the HTML and URL checks already in this file.

# Raw vs Escaped `<br>` — Real Newline vs Literal Tag Text

When reading a cell via `excel_read_sheet`, the tool's HTML table rendering escapes literal text tags (e.g. Stripo's `<p_5>`, `<strong_1>`, `<br_3/>` show up as `&lt;p_5&gt;` etc., because they are real characters in the cell). But an actual Excel cell line-break (soft return / Alt+Enter) is rendered by the tool as a raw, **unescaped** `<br>` for display purposes — it is NOT literal text in the cell.

- If a cell shows a raw/unescaped `<br>` while everything else around it is escaped, that is very likely a real newline character, not literal tag text.
- Do NOT copy that rendered `<br>` into translations as literal text (i.e. do not type the characters `<br>`). Doing so introduces a tag that doesn't literally exist in the source and will show up escaped (`&lt;br&gt;`) on read-back — mismatching the source's raw/unescaped rendering. This is a real bug caught by review (2026, CPR Training Program Newsletters file): translated cells had literal `<br>` text while the English source had a true newline at that position.
- **How to apply:** When translating any cell where the English source shows a raw/unescaped `<br>`, write an actual newline character (`\n`) in that position in the translated cell instead of the literal string `<br>`, preserving any trailing/leading whitespace exactly as in the source. Verify by reading the cell back — a correctly matching translation will also show a raw/unescaped `<br>` in the tool's table output, not `&lt;br&gt;`.