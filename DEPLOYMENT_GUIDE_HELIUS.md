# Deployment Guide - Test Domain with Helius API

## ✅ Helius API Configuration Complete

Your Helius API key has been configured:
- **API Key:** `c6b6506e-b462-4091-8029-63f7e0c37829`
- **RPC Endpoint:** `https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829`

This gives you:
- ✅ 100,000 free credits per day
- ✅ Faster NFT queries via DAS API
- ✅ Better reliability than public RPC
- ✅ Automatic fallback to standard RPC if needed

---

## 🚀 Deploy to Vercel (Test Domain)

### Step 1: Install Vercel CLI
```bash
npm install -g vercel
```

### Step 2: Login to Vercel
```bash
vercel login
```

### Step 3: Deploy
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
vercel
```

Follow the prompts:
- **Set up and deploy?** `Y`
- **Which scope?** Select your account
- **Link to existing project?** `N`
- **Project name?** `collectevm-test` (or your choice)
- **Directory?** `.` (current directory)
- **Override settings?** `N`

### Step 4: Set Environment Variables

After first deployment, add environment variables:

```bash
# Required for production
vercel env add DATABASE_URL production
# Enter: Your PostgreSQL connection string (see below)

vercel env add SOLANA_RPC_URL production
# Enter: https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829

vercel env add HELIUS_API_KEY production
# Enter: c6b6506e-b462-4091-8029-63f7e0c37829

vercel env add WASSIEVERSE_COLLECTION_ADDRESS production
# Enter: EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH

vercel env add NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID production
# Enter: Your WalletConnect Project ID (get from https://cloud.walletconnect.com)

vercel env add NEXT_PUBLIC_SOLANA_RPC_URL production
# Enter: https://api.mainnet-beta.solana.com
```

### Step 5: Setup Production Database

**Option A: Vercel Postgres (Easiest)**
```bash
# In Vercel Dashboard:
# 1. Go to your project
# 2. Click "Storage" tab
# 3. Click "Create Database"
# 4. Select "Postgres"
# 5. Choose free plan
# 6. Vercel will auto-add DATABASE_URL
```

**Option B: Supabase (Free, Generous Limits)**
1. Go to https://supabase.com
2. Create new project
3. Get connection string from project settings
4. Format: `postgresql://postgres:[PASSWORD]@[HOST]:5432/postgres`

**Option C: Neon (Serverless Postgres)**
1. Go to https://neon.tech
2. Create new project
3. Copy connection string

### Step 6: Run Database Migrations
```bash
# Set DATABASE_URL temporarily
export DATABASE_URL="your_production_database_url"

# Run migrations
npx prisma migrate deploy

# Or if first time:
npx prisma db push
```

### Step 7: Deploy Again
```bash
vercel --prod
```

---

## 🎯 Quick Deploy Script

Create this file to automate deployment:

**deploy.sh:**
```bash
#!/bin/bash

echo "🚀 Deploying CollectEVM to Vercel..."

# Check if vercel is installed
if ! command -v vercel &> /dev/null
then
    echo "Installing Vercel CLI..."
    npm install -g vercel
fi

# Deploy
vercel --prod

echo "✅ Deployment complete!"
echo "🌐 Your app is now live at the URL shown above"
```

Make it executable:
```bash
chmod +x deploy.sh
./deploy.sh
```

---

## 🔧 Local Development Setup (First)

Before deploying, test locally:

### Step 1: Create .env file
```bash
cp .env.local.example .env
```

Then edit `.env` and set `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID`:
1. Go to https://cloud.walletconnect.com
2. Create a free account
3. Create a new project
4. Copy the Project ID
5. Paste into .env

### Step 2: Setup Database
```bash
npx prisma generate
npx prisma db push
```

### Step 3: Install Dependencies
```bash
npm install
```

### Step 4: Run Development Server
```bash
npm run dev
```

Visit http://localhost:3000

---

## 📋 Pre-Deployment Checklist

- [ ] **WalletConnect Project ID** - Get from https://cloud.walletconnect.com
- [ ] **Wassieverse Collection Address** - Verify this is correct
- [ ] **Production Database** - Set up Postgres (Vercel/Supabase/Neon)
- [ ] **Test Locally** - Run `npm run dev` and test all features
- [ ] **Environment Variables** - All set in Vercel dashboard
- [ ] **Database Migrations** - Run `prisma migrate deploy`

---

## 🌐 Your Test Domain

After deployment, Vercel will give you:
- **Production URL:** `https://collectevm-test.vercel.app` (or similar)
- **Git Branch Previews:** Auto-deploy on git push
- **Custom Domain:** Can add your own domain in Vercel settings

---

## 🧪 Testing on Your Domain

Once deployed, test this flow:

1. **Connect Phantom Wallet**
   - Should prompt for connection
   - Should show connected address

2. **Verify NFT Ownership**
   - Click "Verify NFT Ownership"
   - Sign the message in Phantom
   - Should see Wassieverse NFTs (if wallet owns any)

3. **Connect MetaMask**
   - Click "Connect EVM Wallet"
   - Should prompt MetaMask

4. **Link Wallets**
   - Click "Link Wallets"
   - Sign the message in MetaMask
   - Should show success message

---

## 🐛 Troubleshooting

### Error: "NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID not set"
**Fix:** Set the variable in Vercel dashboard, then redeploy

### Error: "Failed to connect to database"
**Fix:** 
1. Check DATABASE_URL is correct
2. Ensure database is accessible from Vercel
3. Run `npx prisma db push` with production DATABASE_URL

### Error: "Failed to fetch NFTs"
**Fix:** Your Helius API is already configured, so this should work. If not:
1. Check HELIUS_API_KEY is set correctly
2. Verify wallet actually has Wassieverse NFTs
3. Check WASSIEVERSE_COLLECTION_ADDRESS is correct

### Error: "No Wassieverse NFTs found"
**Fix:** This means either:
1. The wallet doesn't own any Wassieverse NFTs (expected)
2. WASSIEVERSE_COLLECTION_ADDRESS is wrong (update it)

---

## 📊 Helius API Usage Monitoring

Check your Helius usage:
1. Go to https://dashboard.helius.dev
2. Login with your account
3. View API usage stats
4. Free tier: 100,000 credits/day

Your current plan:
- ✅ **RPC Requests:** Included
- ✅ **DAS API Calls:** Included
- ✅ **NFT Queries:** Fast & efficient
- ✅ **Rate Limits:** 10 req/sec (generous)

---

## 🎯 Next Steps

1. **Test Locally First:**
   ```bash
   cp .env.local.example .env
   # Edit .env with WalletConnect ID
   npm install
   npx prisma db push
   npm run dev
   ```

2. **Deploy to Vercel:**
   ```bash
   vercel
   ```

3. **Configure Production:**
   - Add all environment variables
   - Set up Postgres database
   - Run database migrations
   - Deploy again with `vercel --prod`

4. **Test on Production:**
   - Visit your Vercel URL
   - Test wallet connections
   - Test NFT verification
   - Test wallet linking

---

## 🔐 Security Note

Your Helius API key is now in this document. Keep this file secure:
- ✅ Don't commit to public GitHub
- ✅ Only share with trusted team members
- ✅ Rotate key if compromised (Helius dashboard)
- ✅ Monitor usage for unusual activity

---

**Deployment Ready!** 🚀  
**Helius API:** ✅ Configured  
**Next:** Deploy to Vercel for your test domain

