# Claude Code Project Setup Guide

<p align="center">
  <img src="https://github.com/shanraisshan/claude-code-best-practice/blob/main/!/claude-jumping.svg" alt="Claude Jumping">
</p>
  
Once you've completed Claude Code and VS Code installation guide from **Sara Armandi**, please follow the steps below to set up the `Email Localization` project on your machine.

## Prerequisites

### 1. Install Node.js

Download and install the latest LTS version of Node.js:

<p>
  <a href="https://nodejs.org/en/download">
    <img src="https://img.shields.io/badge/Download-Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white" alt="Download Node.js">
  </a>
</p>

After installation, verify it by running these in CMD:

```
node -v
npm -v
```

> Why installing Node.js is required: **Excel MCP** server is used in this project to interact with the .xlsx files. Since the Excel MCP server is built with Node.js, it must be installed to run locally.

---


## 2. Add Node.js to the PATH Environment Variable (if required)

> You can skip this step if the previous commands work without any errors.

If `node` is not recognized in Command Prompt, PowerShell, or VS Code, add their installation folders to your **PATH** environment variable.

| Application | Find Installation Path | Example Output | Add This Folder to PATH |
|-------------|------------------------|----------------|-------------------------|
| <p align="center"><img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js"></p> | Run `where node` in Command Prompt | `C:\Program Files\nodejs\node.exe` | `C:\Program Files\nodejs\` |

---

### How to add a folder to PATH

1. Press **Windows** and search for **Environment Variables**.
2. Open **Edit the system environment variables**.
3. Click **Environment Variables...**
4. Under **System variables**, select **Path**.
5. Click **Edit**.
6. Click **New**.
7. Paste the Node.js folder path if already not.
8. Click **OK** to save all dialogs.
9. Close and reopen your terminal or VS Code.

Verify the installation again:

```
node -v
npm -v
```

---

### 3. Configure PowerShell Execution Policy (Only if Required)

> This step is required only if you encounter PowerShell execution policy errors.

If PowerShell blocks scripts from running, execute:

```
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
```

If prompted, enter:

```
Y
```

---

## Opening The Project

1. Extract the **Zip** file that you're provided with.
2. Open Visual Studio Code and choose the `Email Localization` folder to work on.
3. Then open **Claude Code** inside the project folder.

---

## Verify Installation

Run the following commands to ensure everything is installed correctly:

```
node -v
npm -v
```

If all commands return version numbers, your environment is ready.

---

## Next Steps

After completing the setup, continue with the Claude Code project-specific configuration (plugins, MCP servers, agents, skills, and other project settings) as documented separately.

## Suggestions

Only suggestion from my end is, consider creating a folder called `Campaigns` and keep all your `.xlsx` from Stripo here. So, the project would be more organized. Eventually your project will end up look like this, 
<p align="center">
<img width="226" height="268" alt="image" src="https://github.com/user-attachments/assets/91eb722b-e583-45c1-b8e6-83b20ce0381e" />
</p>
