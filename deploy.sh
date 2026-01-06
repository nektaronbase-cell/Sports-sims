#!/bin/bash

echo "🚀 Sports Simulations - Quick Deploy Setup"
echo "=========================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if git is initialized
if [ ! -d .git ]; then
    echo -e "${YELLOW}📦 Initializing Git repository...${NC}"
    git init
    echo "✓ Git initialized"
    echo ""
fi

# Check for remote
if ! git remote | grep -q origin; then
    echo -e "${YELLOW}🔗 Setting up GitHub remote${NC}"
    echo ""
    read -p "Enter your GitHub repository URL (e.g., https://github.com/username/sports-sims.git): " REPO_URL
    
    if [ -z "$REPO_URL" ]; then
        echo -e "${RED}❌ Repository URL is required${NC}"
        exit 1
    fi
    
    git remote add origin "$REPO_URL"
    echo "✓ Remote added: $REPO_URL"
    echo ""
else
    echo "✓ Git remote already configured"
    echo ""
fi

# Stage all files
echo -e "${YELLOW}📝 Staging files...${NC}"
git add .

# Check if there are changes to commit
if git diff-index --quiet HEAD --; then
    echo "✓ No changes to commit"
else
    echo -e "${YELLOW}💾 Committing changes...${NC}"
    read -p "Enter commit message (default: 'Deploy: Initial sports simulations'): " COMMIT_MSG
    COMMIT_MSG=${COMMIT_MSG:-"Deploy: Initial sports simulations"}
    
    git commit -m "$COMMIT_MSG"
    echo "✓ Changes committed"
fi

echo ""
echo -e "${YELLOW}🚀 Pushing to GitHub...${NC}"

# Check if main branch exists remotely
if git ls-remote --heads origin main | grep -q main; then
    git push origin main
else
    git branch -M main
    git push -u origin main
fi

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ Successfully pushed to GitHub!${NC}"
    echo ""
    echo "📋 Next Steps:"
    echo "============="
    echo ""
    echo "1. Go to vercel.com/new"
    echo "2. Import your GitHub repository"
    echo ""
    echo "For NFL Simulation:"
    echo "  - Root Directory: apps/nfl-sim"
    echo "  - Build Command: cd ../.. && npm install && npm run build:nfl"
    echo ""
    echo "For MMA Simulation:"
    echo "  - Root Directory: apps/mma-sim"
    echo "  - Build Command: cd ../.. && npm install && npm run build:mma"
    echo ""
    echo "3. Add Environment Variable:"
    echo "   DATABASE_URL = your_production_database_url"
    echo ""
    echo "4. Click Deploy!"
    echo ""
    echo "📖 See DEPLOYMENT.md for detailed instructions"
    echo ""
else
    echo ""
    echo -e "${RED}❌ Failed to push to GitHub${NC}"
    echo ""
    echo "Common issues:"
    echo "  1. Check your GitHub credentials"
    echo "  2. Verify repository URL is correct"
    echo "  3. Ensure you have push access to the repository"
    echo ""
    echo "Run: git push origin main --verbose"
    echo "For more detailed error information"
fi
