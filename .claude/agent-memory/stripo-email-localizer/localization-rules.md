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

Before finalizing translations for any language, confirm the matching language tab in `Examples/Email Examples - AI Translation.xlsx` was reviewed for tone calibration.
- If a language has no matching tab in the example file, note this explicitly rather than skipping the check silently.
- Do not treat this as optional guidance — it is a required verification step before output is considered complete.

**Why:** 
- The agent instructions require using the example file as a tone reference, but without an explicit checkpoint this can be skipped silently.
- Also ensures translations sound natural and match Laerdal's established marketing voice per language, rather than reading as generic machine translation.

**How to apply:** Treat as a pre-completion checklist item for every language column being translated, alongside the HTML and URL checks already in this file.