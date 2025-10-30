#!/bin/bash
# FINAL DEPLOYMENT SCRIPT - Everything configured!
# Your .env file is already created with all credentials

set -e

echo "🚀 CollectEVM - Final Deployment"
echo "=================================="
echo ""
echo "✅ .env file already created!"
echo "✅ All credentials configured!"
echo ""

cd /Users/phillipyon/Downloads/CollectEVM-master

# Check Node.js
if ! command -v node &> /dev/null; then
    echo "❌ Node.js not found!"
    echo ""
    echo "Please install Node.js first:"
    echo "1. Go to: https://nodejs.org"
    echo "2. Download LTS version (v20 recommended)"
    echo "3. Install and restart terminal"
    echo "4. Run this script again"
    echo ""
    exit 1
fi

echo "✅ Node.js found: $(node --version)"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
npm install
echo ""

# Generate Prisma
echo "🔨 Generating Prisma client..."
npx prisma generate
echo ""

# Deploy schema
echo "🗄️  Deploying database schema..."
npx prisma db push
echo ""

# Build app
echo "🏗️  Building application..."
npm run build
echo ""

# Check for Vercel CLI
if ! command -v vercel &> /dev/null; then
    echo "📥 Installing Vercel CLI..."
    npm install -g vercel
    echo ""
fi

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎉 READY TO DEPLOY!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "Now run:"
echo "  vercel"
echo ""
echo "After first deploy, add environment variables in Vercel dashboard"
echo "Then run:"
echo "  vercel --prod"
echo ""
echo "🌐 Your site will be live at: https://collectevm-[random].vercel.app"
echo ""

