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

### 2. Install Git

Download and install Git for Windows:

<p>
  <a href="https://git-scm.com/install/windows">
    <img src="https://img.shields.io/badge/Download-Git_for_Windows-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Download Git for Windows">
  </a>
</p>

Verify the installation in CMD:

```
git --version
```

> **Why installing Git is required:** If the prompts or functionality of this email localization system change in the future, you can easily sync your local copy with the latest updates from the GitHub repository. This avoids the need to manually update the project whenever changes are made.

---

## 3. Add Node.js and Git to the PATH Environment Variable (if required)

> You can skip this step if the previous commands work without any errors.

If `node` or `git` is not recognized in Command Prompt, PowerShell, or VS Code, add their installation folders to your **PATH** environment variable.

| Application | Find Installation Path | Example Output | Add This Folder to PATH |
|-------------|------------------------|----------------|-------------------------|
| <p align="center"><img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js"></p> | Run `where node` in Command Prompt | `C:\Program Files\nodejs\node.exe` | `C:\Program Files\nodejs\` |
| <p align="center"><img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git"></p> | Run `where git` in Command Prompt | `C:\Program Files\Git\cmd\git.exe` | `C:\Program Files\Git\cmd\` |

---

### How to add a folder to PATH

1. Press **Win** and search for **Environment Variables**.
2. Open **Edit the system environment variables**.
3. Click **Environment Variables...**
4. Under **System variables**, select **Path**.
5. Click **Edit**.
6. Click **New**.
7. Paste the Node.js and Git folder path if already not.
8. Click **OK** to save all dialogs.
9. Close and reopen your terminal or VS Code.

Verify the installation again:

```
node -v
npm -v
git --version
```

---

### 4. Clone the Repository

Open a terminal and run where you want the `Email Localization` project to be:

```
git clone https://github.com/gowthamr56laerdal/email_localization.git
```

---

### 5. Configure PowerShell Execution Policy (Only if Required)

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

## Opening the Project

Open Visual Studio Code and choose the `Email Localization` folder to work on.

Then open **Claude Code** inside the project folder.

---

## Verify Installation

Run the following commands to ensure everything is installed correctly:

```
node -v
npm -v
git --version
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
