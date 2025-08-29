#!/bin/bash

# AMSI Test Project - GitHub Push Script
# This script helps you push your project to GitHub

echo "🚀 AMSI Test Project - GitHub Push Helper"
echo "=========================================="
echo ""

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Error: Not in a git repository"
    echo "Please run this script from your project directory"
    exit 1
fi

# Check git status
echo "📊 Current Git Status:"
git status
echo ""

# Show commit history
echo "📝 Commit History:"
git log --oneline
echo ""

echo "✅ Your local repository is ready!"
echo ""
echo "📋 Next Steps to Push to GitHub:"
echo "1. Go to https://github.com/new"
echo "2. Repository name: AMSI-Test-Project (or your choice)"
echo "3. Description: PowerShell-based AMSI testing and analysis tools"
echo "4. Choose Public or Private"
echo "5. DO NOT initialize with README (we already have one)"
echo "6. Click 'Create repository'"
echo ""
echo "🔗 After creating the repository, run these commands:"
echo "git remote add origin https://github.com/YOUR_USERNAME/AMSI-Test-Project.git"
echo "git push -u origin main"
echo ""
echo "💡 Replace YOUR_USERNAME with your actual GitHub username"
echo ""

# Check if remote is already configured
if git remote -v | grep -q "origin"; then
    echo "🌐 Remote 'origin' is already configured:"
    git remote -v
    echo ""
    echo "To push to GitHub, run:"
    echo "git push -u origin main"
else
    echo "🌐 No remote configured yet."
    echo "Follow the steps above to create the GitHub repository first."
fi

echo ""
echo "🎉 Good luck with your AMSI testing project!"
