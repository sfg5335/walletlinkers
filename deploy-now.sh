#!/bin/bash
# Final Deployment Script - All credentials configured!
# Just add your Supabase database password and deploy

set -e

echo "🚀 CollectEVM - Final Deployment Setup"
echo "========================================"
echo ""
echo "✅ Helius API: Configured"
echo "✅ WalletConnect ID: Configured"
echo "✅ Supabase Project: ermqlcqyesoitirwutus"
echo "✅ Collection Address: Configured"
echo ""

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js 18+ from: https://nodejs.org"
    exit 1
fi

echo "✅ Node.js found: $(node --version)"
echo ""

# Navigate to project
cd "$(dirname "$0")"

# Install dependencies
echo "📥 Installing dependencies..."
npm install
echo ""

# Prompt for Supabase password
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔑 Supabase Database Password"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "To get your password:"
echo "1. Go to: https://supabase.com/dashboard/project/ermqlcqyesoitirwutus"
echo "2. Click: Settings → Database"
echo "3. Find: Connection string → URI"
echo "4. Copy the password from the connection string"
echo ""
read -p "Enter your Supabase database password: " DB_PASSWORD
echo ""

# Create .env file with all credentials
echo "🔧 Creating .env file with all your credentials..."
cat > .env << EOF
# Database - Supabase
DATABASE_URL="postgresql://postgres.ermqlcqyesoitirwutus:${DB_PASSWORD}@aws-0-us-west-1.pooler.supabase.com:5432/postgres"

# Helius API
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"

# Wassieverse Collection Address
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"

# WalletConnect Project ID
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="1a91ca1e820439d2a1391d3b239a8cc1"

# Public Solana RPC
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
EOF

echo "✅ .env file created with complete configuration"
echo ""

# Setup database
echo "🗄️  Setting up database schema..."
npx prisma generate
npx prisma db push
echo "✅ Database schema deployed to Supabase"
echo ""

# Build the app
echo "🏗️  Building application..."
npm run build
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 Setup Complete - Ready to Deploy!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ Configuration Status:"
echo "   ✅ Helius API: c6b6506e-b462-4091-8029-63f7e0c37829"
echo "   ✅ Supabase: ermqlcqyesoitirwutus (Connected)"
echo "   ✅ Database: Schema migrated"
echo "   ✅ WalletConnect: 1a91ca1e820439d2a1391d3b239a8cc1"
echo "   ✅ Collection: EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"
echo ""
echo "📍 Next Steps:"
echo ""
echo "1️⃣  Test locally (optional):"
echo "   npm run dev"
echo "   Visit http://localhost:3000"
echo ""
echo "2️⃣  Deploy to Vercel:"
echo "   vercel login"
echo "   vercel"
echo ""
echo "3️⃣  Add these environment variables in Vercel:"
echo ""
echo "   DATABASE_URL=postgresql://postgres.ermqlcqyesoitirwutus:${DB_PASSWORD}@aws-0-us-west-1.pooler.supabase.com:5432/postgres"
echo "   SOLANA_RPC_URL=https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
echo "   HELIUS_API_KEY=c6b6506e-b462-4091-8029-63f7e0c37829"
echo "   WASSIEVERSE_COLLECTION_ADDRESS=EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"
echo "   NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=1a91ca1e820439d2a1391d3b239a8cc1"
echo "   NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com"
echo ""
echo "4️⃣  Redeploy:"
echo "   vercel --prod"
echo ""
echo "🌐 Your app will be live at: https://your-project.vercel.app"
echo ""
echo "🎉 Everything is configured! You're ready to deploy!"
echo ""

