#!/bin/bash
# Quick Deploy to Test Domain
# This script will get your app live in 5 minutes

echo "🚀 CollectEVM - Quick Deploy to Test Domain"
echo "============================================="
echo ""

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found"
    echo "Please run this from: /Users/phillipyon/Downloads/CollectEVM-master"
    exit 1
fi

echo "✅ In correct directory"
echo ""

# Step 1: Setup .env
echo "📝 Step 1/6: Creating .env file..."
if [ -f ".env.production" ]; then
    cp .env.production .env
    echo "✅ .env file created from .env.production"
else
    cat > .env << 'EOF'
DATABASE_URL="postgresql://postgres.ermqlcqyesoitirwutus:i/FPSPU6TV93yC#@aws-0-us-west-1.pooler.supabase.com:5432/postgres"
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="1a91ca1e820439d2a1391d3b239a8cc1"
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
EOF
    echo "✅ .env file created"
fi
echo ""

# Step 2: Install dependencies
echo "📦 Step 2/6: Installing dependencies..."
npm install
echo ""

# Step 3: Generate Prisma
echo "🔨 Step 3/6: Generating Prisma client..."
npx prisma generate
echo ""

# Step 4: Setup database
echo "🗄️  Step 4/6: Setting up database..."
npx prisma db push
echo ""

# Step 5: Build app
echo "🏗️  Step 5/6: Building application..."
npm run build
echo ""

# Step 6: Check for Vercel CLI
echo "🚀 Step 6/6: Checking deployment options..."
if command -v vercel &> /dev/null; then
    echo "✅ Vercel CLI found!"
    echo ""
    echo "🎉 Ready to deploy! Run:"
    echo "   vercel"
    echo ""
else
    echo "⚠️  Vercel CLI not found. Installing..."
    npm install -g vercel
    echo ""
    echo "🎉 Ready to deploy! Run:"
    echo "   vercel login"
    echo "   vercel"
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ SETUP COMPLETE!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📍 Next steps:"
echo ""
echo "1. Deploy to Vercel:"
echo "   vercel"
echo ""
echo "2. When prompted, choose:"
echo "   - Setup and deploy: Y"
echo "   - Project name: collectevm (or your choice)"
echo "   - Deploy: Y"
echo ""
echo "3. After first deploy, add environment variables in Vercel dashboard"
echo ""
echo "4. Redeploy:"
echo "   vercel --prod"
echo ""
echo "🌐 Your app will be live at: https://collectevm-[random].vercel.app"
echo ""

