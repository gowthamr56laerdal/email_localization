---
name: inner-text-swap
description: Replace only the inner text of a target HTML code block with the inner text of a source code block, keeping all tags, attributes, inline styles, and structure of the target untouched. Use when the user provides two code blocks (Code block - 1 = text source, Code block - 2 = structure to keep) and asks to swap the text, or update copy without changing the markup.
---

Input:

- `Code block - 1`: `.temp/inner-text-swap/input-1.html`
- `Code block - 2`: `.temp/inner-text-swap/input-2.html`
- Also accept if the user provides the code blocks directly instead of a file.

Task:

1. check the `.temp/inner-text-swap/replaced.html` file exists. If it does, delete it.
2. Modify `Code block - 2` by replacing only its inner text with the inner text from `Code block - 1`.
3. Don't change anything except the inner text.
4. Save the output HTML file as `.temp/inner-text-swap/replaced.html`.