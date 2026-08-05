---
name: tooling-rules
description: Excel reads must use the excel MCP server only; CSV output must use the Write tool, never Python/Bash
metadata:
  type: feedback
---

# Excel MCP Only, Write Tool for CSV

Never use Python or Bash scripting (openpyxl, pandas, csv module, curl, etc.) to read the
input Excel file, to check links, or to produce the output CSV.

- **Reading the Excel file:** use the excel MCP server tools only -
  `mcp__excel__excel_describe_sheets` to discover the sheet name, then
  `mcp__excel__excel_read_sheet` to pull cell values. Load their schemas via ToolSearch first.
- **Writing the output CSV:** use the `Write` tool. The excel MCP cannot create new files
  from scratch, and Bash/Python is not permitted - `Write` is the only approved path.

**Why:** The user explicitly denied a prior approval request to use Python for an Excel
operation and instructed that the excel MCP server has all needed capabilities and should
be used instead. The same rule applies to this agent: MCP for Excel, WebFetch for link
checks, Write for file output.

**How to apply:** At every read/check/write step, reach for the MCP or built-in tool
directly. Do not propose or fall back to Python/openpyxl/pandas/curl scripts, even as a
verification or "quick sanity check" step. If an MCP tool appears to be missing, load it
with ToolSearch rather than substituting a script.
