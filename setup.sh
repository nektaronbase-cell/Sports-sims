#!/bin/bash

echo "🏈🥊 Sports Simulations Setup"
echo "=============================="
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ first."
    exit 1
fi

echo "✓ Node.js found: $(node --version)"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install

if [ $? -ne 0 ]; then
    echo "❌ Failed to install dependencies"
    exit 1
fi

echo "✓ Dependencies installed"
echo ""

# Create .env.local files
echo "🔧 Setting up environment files..."

# NFL sim .env
cat > apps/nfl-sim/.env.local << EOF
DATABASE_URL=postgresql://postgres:password@helium/heliumdb?sslmode=disable
NEXT_PUBLIC_APP_NAME=NFL Simulation
EOF

# MMA sim .env
cat > apps/mma-sim/.env.local << EOF
DATABASE_URL=postgresql://postgres:password@helium/heliumdb?sslmode=disable
NEXT_PUBLIC_APP_NAME=Onchain Fighting Association
EOF

echo "✓ Environment files created"
echo ""

# Run migrations
echo "🗄️  Running database migrations..."
npm run db:migrate

if [ $? -ne 0 ]; then
    echo "⚠️  Database migrations failed. Make sure PostgreSQL is running."
    echo "   Connection: postgresql://postgres:password@helium/heliumdb"
else
    echo "✓ Database migrations completed"
fi

echo ""
echo "✅ Setup complete!"
echo ""
echo "🚀 To start development:"
echo "   npm run dev:all   # Start both games"
echo "   npm run dev:nfl   # Start NFL sim (port 3000)"
echo "   npm run dev:mma   # Start MMA sim (port 3001)"
echo ""
echo "📚 Read README.md for more information"
