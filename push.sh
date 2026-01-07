#!/bin/bash

echo "🚀 Push to GitHub"
echo "================="
echo ""

# Check if we're in a git repository
if [ ! -d .git ]; then
    echo "❌ Not a git repository. Run this from the sports-sims directory."
    exit 1
fi

# Check if remote already exists
if git remote | grep -q origin; then
    echo "✓ Remote 'origin' already configured"
    git remote -v
    echo ""
    read -p "Do you want to push to this remote? (y/n): " confirm
    if [ "$confirm" != "y" ]; then
        echo "Aborted."
        exit 0
    fi
else
    echo "No remote configured yet."
    echo ""
    read -p "Enter your GitHub repository URL: " repo_url
    
    if [ -z "$repo_url" ]; then
        echo "❌ Repository URL is required"
        exit 1
    fi
    
    git remote add origin "$repo_url"
    echo "✓ Remote added: $repo_url"
fi

echo ""
echo "📤 Pushing to GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo ""
    echo "🎯 Next steps:"
    echo "1. Go to vercel.com/new"
    echo "2. Import your repository"
    echo "3. Deploy both apps!"
    echo ""
    echo "See QUICK_DEPLOY.md for details"
else
    echo ""
    echo "❌ Push failed"
    echo ""
    echo "Common issues:"
    echo "  - Check your GitHub credentials"
    echo "  - Use personal access token as password"
    echo "  - Verify repository URL is correct"
    echo ""
    echo "Need help? See GIT_READY.md"
fi
