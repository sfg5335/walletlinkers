#!/bin/bash
# Complete Deployment with Supabase & Helius
# This script sets up everything you need

set -e

echo "🚀 CollectEVM - Complete Setup with Supabase & Helius"
echo "======================================================"
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

# Prompt for database credentials
echo "🗄️  Supabase Database Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Your Supabase project: ermqlcqyesoitirwutus"
echo "Dashboard: https://supabase.com/dashboard/project/ermqlcqyesoitirwutus"
echo ""
echo "To get your DATABASE_URL:"
echo "1. Go to Settings → Database"
echo "2. Find 'Connection string' section"
echo "3. Select 'URI' tab"
echo "4. Copy the connection string"
echo ""
read -p "Enter your DATABASE_URL (or press Enter to skip): " DB_URL
echo ""

# Prompt for WalletConnect
echo "🔗 WalletConnect Setup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Get your WalletConnect Project ID:"
echo "1. Go to: https://cloud.walletconnect.com"
echo "2. Create a free account and project"
echo "3. Copy your Project ID"
echo ""
read -p "Enter your WalletConnect Project ID (or press Enter to skip): " WC_ID
echo ""

# Create .env file
echo "🔧 Creating .env file..."
cat > .env << EOF
# Database
${DB_URL:+DATABASE_URL="$DB_URL"}
${DB_URL:-# DATABASE_URL="postgresql://postgres.ermqlcqyesoitirwutus:[PASSWORD]@aws-0-us-west-1.pooler.supabase.com:5432/postgres"}

# Helius API (Configured ✅)
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"

# Wassieverse Collection Address (Configured ✅)
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"

# WalletConnect Project ID
${WC_ID:+NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="$WC_ID"}
${WC_ID:-# NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="your_project_id"}

# Public Solana RPC (Configured ✅)
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
EOF

echo "✅ .env file created"
echo ""

# Setup database if URL provided
if [ -n "$DB_URL" ]; then
    echo "🗄️  Setting up database..."
    npx prisma generate
    npx prisma db push
    echo "✅ Database schema deployed"
    echo ""
else
    echo "⚠️  Skipping database setup (no DATABASE_URL provided)"
    echo "   You'll need to run 'npx prisma db push' after adding DATABASE_URL"
    echo ""
fi

# Build the app
echo "🏗️  Building application..."
npm run build
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Setup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📊 Configuration Status:"
echo "   ✅ Helius API: Configured"
echo "   ✅ Supabase: ermqlcqyesoitirwutus"
if [ -n "$DB_URL" ]; then
    echo "   ✅ Database: Connected & migrated"
else
    echo "   ⚠️  Database: Need to add DATABASE_URL"
fi
if [ -n "$WC_ID" ]; then
    echo "   ✅ WalletConnect: Configured"
else
    echo "   ⚠️  WalletConnect: Need to add Project ID"
fi
echo ""
echo "📍 Next Steps:"
echo ""
echo "1️⃣  Test locally (optional):"
echo "   npm run dev"
echo "   Visit http://localhost:3000"
echo ""
echo "2️⃣  Deploy to Vercel:"
echo "   npm install -g vercel  # If not installed"
echo "   vercel login"
echo "   vercel"
echo ""
echo "3️⃣  Add environment variables in Vercel:"
echo "   See SUPABASE_SETUP.md for complete list"
echo ""
echo "🎉 Your CollectEVM app is ready to deploy!"
echo ""

