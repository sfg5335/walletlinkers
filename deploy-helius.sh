#!/bin/bash
# Helius API Deployment Script
# Run this script to deploy CollectEVM with Helius API configured

set -e

echo "🚀 CollectEVM Deployment with Helius API"
echo "========================================"
echo ""

# Navigate to project directory
cd "$(dirname "$0")"

# Step 1: Check for Node.js
echo "📦 Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js 18+ from: https://nodejs.org"
    exit 1
fi

NODE_VERSION=$(node --version)
echo "✅ Node.js $NODE_VERSION found"
echo ""

# Step 2: Install dependencies
echo "📥 Installing dependencies..."
npm install
echo ""

# Step 3: Create .env file
echo "🔧 Setting up environment variables..."
cat > .env << 'EOF'
# Database - SQLite for development
DATABASE_URL="file:./prisma/dev.db"

# Solana Configuration - Using Helius RPC
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"

# Helius API Key for DAS NFT queries
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"

# Wassieverse NFT Collection Address
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"

# WalletConnect Project ID - GET YOUR OWN FROM https://cloud.walletconnect.com
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="REPLACE_WITH_YOUR_PROJECT_ID"

# Solana RPC for frontend
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
EOF

echo "✅ Created .env file with Helius API configured"
echo ""

# Step 4: Check for WalletConnect ID
if grep -q "REPLACE_WITH_YOUR_PROJECT_ID" .env; then
    echo "⚠️  ACTION REQUIRED:"
    echo "   You need to get a WalletConnect Project ID"
    echo "   1. Go to: https://cloud.walletconnect.com"
    echo "   2. Create a free account and project"
    echo "   3. Copy your Project ID"
    echo "   4. Edit .env file and replace REPLACE_WITH_YOUR_PROJECT_ID"
    echo ""
    echo "   Then run this script again, or continue to test backend only."
    echo ""
fi

# Step 5: Setup database
echo "🗄️  Setting up database..."
npx prisma generate
npx prisma db push
echo ""

# Step 6: Build the application
echo "🏗️  Building application..."
npm run build
echo ""

# Step 7: Test locally (optional)
echo "✅ Setup complete!"
echo ""
echo "📍 Next steps:"
echo ""
echo "1️⃣  Test locally:"
echo "   npm run dev"
echo "   Then visit http://localhost:3000"
echo ""
echo "2️⃣  Deploy to Vercel:"
echo "   npm install -g vercel  # Install Vercel CLI"
echo "   vercel login           # Login to Vercel"
echo "   vercel                 # Deploy"
echo ""
echo "3️⃣  Add environment variables in Vercel dashboard:"
echo "   - DATABASE_URL (use Vercel Postgres or Supabase)"
echo "   - SOLANA_RPC_URL=https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
echo "   - HELIUS_API_KEY=c6b6506e-b462-4091-8029-63f7e0c37829"
echo "   - WASSIEVERSE_COLLECTION_ADDRESS=EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"
echo "   - NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=your_project_id"
echo "   - NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com"
echo ""
echo "🎉 Your Helius API is configured and ready!"
echo "   API Key: c6b6506e-b462-4091-8029-63f7e0c37829"
echo "   Free tier: 100,000 credits/day"
echo ""

