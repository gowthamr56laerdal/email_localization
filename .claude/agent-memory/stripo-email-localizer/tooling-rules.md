---
name: tooling-rules
description: Excel operations must use the excel MCP server only, never Python/Bash scripting
metadata:
  type: feedback
---

# Excel MCP Only

Never request or use Python (or any Bash scripting, e.g. openpyxl/pandas) to read, write, or
modify Excel campaign files. Always use the excel MCP server tools
(`mcp__excel__excel_read_sheet`, `mcp__excel__excel_write_to_sheet`, etc.) exclusively.

**Why:** The user explicitly denied a prior approval request to use Python for an Excel
operation and instructed that the excel MCP server has all needed capabilities and should
be used instead.

**How to apply:** For every Excel read/write step in the localization workflow, use the
excel MCP tools directly. Do not propose or fall back to Python/openpyxl/pandas scripts,
even as a verification step.
