# 🚀 Deployment Guide - Push to GitHub

This guide will help you push your AMSI test project to GitHub.

## 📋 Prerequisites

1. **GitHub Account** - Make sure you have a GitHub account
2. **Git Installation** - Install Git from [https://git-scm.com/](https://git-scm.com/)
3. **GitHub CLI (Optional)** - Install from [https://cli.github.com/](https://cli.github.com/)

## 🎯 Method 1: Using GitHub Desktop (Recommended for Beginners)

### Step 1: Install GitHub Desktop
- Download from [https://desktop.github.com/](https://desktop.github.com/)
- Sign in with your GitHub account

### Step 2: Create Repository
1. Click **"Create a New Repository"**
2. **Repository name**: `AMSI-Test-Project` (or your preferred name)
3. **Description**: `PowerShell-based AMSI testing and analysis tools`
4. **Local path**: Choose your project folder (`D:\cursor\AMSI_bypass`)
5. Check **"Initialize this repository with a README"**
6. Click **"Create Repository"**

### Step 3: Add Files
1. GitHub Desktop will show all your project files
2. Add a commit message: `"Initial commit: AMSI testing tools"`
3. Click **"Commit to main"**
4. Click **"Publish repository"**

## 🎯 Method 2: Using Git Command Line

### Step 1: Install Git
```bash
# Download from https://git-scm.com/
# Or use winget (Windows 10/11)
winget install --id Git.Git -e --source winget
```

### Step 2: Configure Git
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Step 3: Initialize Repository
```bash
cd D:\cursor\AMSI_bypass
git init
git add .
git commit -m "Initial commit: AMSI testing tools"
```

### Step 4: Create GitHub Repository
1. Go to [https://github.com/new](https://github.com/new)
2. **Repository name**: `AMSI-Test-Project`
3. **Description**: `PowerShell-based AMSI testing and analysis tools`
4. Choose **Public** or **Private**
5. **Don't** initialize with README (we already have one)
6. Click **"Create repository"**

### Step 5: Push to GitHub
```bash
git remote add origin https://github.com/YOUR_USERNAME/AMSI-Test-Project.git
git branch -M main
git push -u origin main
```

## 🎯 Method 3: Using GitHub CLI

### Step 1: Install GitHub CLI
```bash
# Download from https://cli.github.com/
# Or use winget
winget install --id GitHub.cli -e --source winget
```

### Step 2: Authenticate
```bash
gh auth login
# Follow the prompts to authenticate
```

### Step 3: Create and Push Repository
```bash
cd D:\cursor\AMSI_bypass
gh repo create AMSI-Test-Project --public --description "PowerShell-based AMSI testing and analysis tools" --source=. --remote=origin --push
```

## 📁 Project Structure

Your repository will contain:
```
AMSI-Test-Project/
├── AMSI_Info.ps1          # Main PowerShell script
├── AMSI_Test_Simple.ps1   # Advanced testing script
├── Run_AMSI_Info.bat      # Easy execution batch file
├── Run_Test.bat           # Alternative batch file
├── README.md              # Project documentation
├── DEPLOYMENT.md          # This deployment guide
├── config.json            # Configuration file
└── .gitignore            # Git ignore rules
```

## 🔧 After Deployment

### Update README
- Update the repository URL in your README.md
- Add badges for build status, version, etc.
- Update any local file paths to GitHub URLs

### Enable GitHub Pages (Optional)
1. Go to repository **Settings**
2. Scroll to **Pages** section
3. Choose **Source**: Deploy from a branch
4. Select **Branch**: main, **Folder**: / (root)
5. Click **Save**

### Add Topics
Add these topics to your repository for better discoverability:
- `powershell`
- `amsi`
- `security`
- `windows`
- `antimalware`
- `testing`

## 🆘 Troubleshooting

### Common Issues:
1. **Authentication Failed**: Make sure you're logged in to GitHub
2. **Repository Already Exists**: Choose a different name or delete the existing one
3. **Large File Error**: Check your .gitignore file
4. **Permission Denied**: Make sure you have write access to the repository

### Need Help?
- [GitHub Help](https://help.github.com/)
- [Git Documentation](https://git-scm.com/doc)
- [GitHub CLI Documentation](https://cli.github.com/manual/)

## 🎉 Success!

Once deployed, your repository will be available at:
`https://github.com/YOUR_USERNAME/AMSI-Test-Project`

Share it with the security community and contribute to the AMSI research field!
