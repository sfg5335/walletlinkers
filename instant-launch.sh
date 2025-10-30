#!/bin/bash
# INSTANT LAUNCH - All credentials configured!
# Just run this script and deploy

set -e

echo "🚀 CollectEVM - Instant Launch Setup"
echo "======================================"
echo ""
echo "✅ All credentials configured!"
echo "✅ Database: ermqlcqyesoitirwutus"
echo "✅ Helius API: c6b6506e-b462-4091-8029-63f7e0c37829"
echo "✅ WalletConnect: 1a91ca1e820439d2a1391d3b239a8cc1"
echo ""

# Navigate to project
cd "$(dirname "$0")"

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed!"
    echo "Please install Node.js 18+ from: https://nodejs.org"
    exit 1
fi

echo "📦 Node.js version: $(node --version)"
echo ""

# Copy complete .env
echo "🔧 Creating .env file with all credentials..."
cp env-complete-ready.txt .env
echo "✅ .env file created"
echo ""

# Install dependencies
echo "📥 Installing dependencies..."
npm install
echo ""

# Generate Prisma client
echo "🔨 Generating Prisma client..."
npx prisma generate
echo ""

# Push database schema
echo "🗄️  Deploying database schema to Supabase..."
npx prisma db push
echo "✅ Database schema deployed"
echo ""

# Build application
echo "🏗️  Building application..."
npm run build
echo "✅ Application built"
echo ""

# Summary
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 READY TO LAUNCH!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "✅ All credentials configured"
echo "✅ Dependencies installed"
echo "✅ Database schema deployed"
echo "✅ Application built"
echo ""
echo "📍 Next Steps:"
echo ""
echo "1️⃣  Test locally (optional):"
echo "   npm run dev"
echo "   Visit http://localhost:3000"
echo ""
echo "2️⃣  Deploy to Vercel:"
echo "   vercel"
echo ""
echo "3️⃣  Add environment variables in Vercel dashboard:"
echo "   (See LAUNCH_NOW.txt for the complete list)"
echo ""
echo "4️⃣  Redeploy to production:"
echo "   vercel --prod"
echo ""
echo "🌐 Your app will be live at: https://your-project.vercel.app"
echo ""
echo "🎉 You're ready to launch! Run 'npm run dev' to test or 'vercel' to deploy!"
echo ""

