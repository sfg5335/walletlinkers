# ✅ CollectEVM - Helius API Configured & Ready to Deploy

## 🎉 What's Been Done

Your CollectEVM application is now configured with your Helius API:

✅ **Helius API Key:** `c6b6506e-b462-4091-8029-63f7e0c37829`  
✅ **RPC Endpoint:** `https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829`  
✅ **Free Tier:** 100,000 credits/day  
✅ **Fast NFT Queries:** Via Helius DAS API  
✅ **Automatic Fallback:** To standard RPC if needed  

---

## 🚀 Deploy NOW (3 Simple Steps)

### Option A: Deploy via Vercel CLI (Recommended)

**Step 1: Install Vercel CLI**
```bash
npm install -g vercel
```

**Step 2: Login and Deploy**
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
vercel login
vercel
```

**Step 3: Add Environment Variables in Vercel Dashboard**

Go to: https://vercel.com/your-username/collectevm-master/settings/environment-variables

Add these:
```
SOLANA_RPC_URL = https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829
HELIUS_API_KEY = c6b6506e-b462-4091-8029-63f7e0c37829
WASSIEVERSE_COLLECTION_ADDRESS = EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID = [Get from cloud.walletconnect.com]
NEXT_PUBLIC_SOLANA_RPC_URL = https://api.mainnet-beta.solana.com
DATABASE_URL = [Add Vercel Postgres or use connection string]
```

Then redeploy:
```bash
vercel --prod
```

**Your app will be live at:** `https://your-project.vercel.app` ✨

---

### Option B: Deploy via Vercel Dashboard

1. **Push code to GitHub:**
   ```bash
   cd /Users/phillipyon/Downloads/CollectEVM-master
   git init
   git add .
   git commit -m "Initial commit with Helius API"
   git remote add origin https://github.com/YOUR_USERNAME/collectevm.git
   git push -u origin main
   ```

2. **Import to Vercel:**
   - Go to https://vercel.com/new
   - Import your GitHub repository
   - Add environment variables (see above)
   - Click Deploy

---

## 🔑 Get Your WalletConnect Project ID (1 Minute)

**This is required for EVM wallet connections:**

1. Go to: https://cloud.walletconnect.com
2. Sign up (free, no credit card)
3. Click "Create New Project"
4. Name it: "CollectEVM"
5. Copy your **Project ID**
6. Add it to environment variables as `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID`

---

## 🗄️ Setup Production Database (Choose One)

### Option 1: Vercel Postgres (Easiest)
1. In Vercel Dashboard: Storage → Create Database → Postgres
2. Select Free Plan
3. `DATABASE_URL` is automatically added
4. Run migrations:
   ```bash
   vercel env pull .env.local
   npx prisma migrate deploy
   ```

### Option 2: Supabase (Free, Recommended)
1. Go to: https://supabase.com
2. Create new project (free tier)
3. Go to Settings → Database
4. Copy "Connection string" (URI mode)
5. Add to Vercel as `DATABASE_URL`
6. Format: `postgresql://postgres:[password]@[host]:5432/postgres`

### Option 3: Neon (Serverless)
1. Go to: https://neon.tech
2. Create project
3. Copy connection string
4. Add to Vercel as `DATABASE_URL`

---

## 🧪 Test Locally First (Optional but Recommended)

```bash
# Navigate to project
cd /Users/phillipyon/Downloads/CollectEVM-master

# Run the automated setup (creates .env with Helius API)
./deploy-helius.sh

# After script completes, edit .env and add your WalletConnect ID
# Then start dev server:
npm run dev
```

Visit: http://localhost:3000

Test the complete flow:
1. Connect Phantom wallet
2. Verify NFT ownership
3. Connect MetaMask
4. Link wallets

---

## 📋 Complete Environment Variables Reference

```bash
# Production Database (Required)
DATABASE_URL="postgresql://user:pass@host:5432/db"

# Helius API (Already configured ✅)
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"

# Collection Address (Update if different)
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"

# WalletConnect (Get from cloud.walletconnect.com)
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="your_project_id_here"

# Public RPC
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
```

---

## ✅ Deployment Checklist

- [ ] **Helius API configured** ✅ (Already done!)
- [ ] **Get WalletConnect Project ID** → cloud.walletconnect.com
- [ ] **Choose database** → Vercel/Supabase/Neon
- [ ] **Test locally** → `./deploy-helius.sh` then `npm run dev`
- [ ] **Deploy to Vercel** → `vercel`
- [ ] **Add environment variables** → Vercel dashboard
- [ ] **Run database migrations** → `npx prisma migrate deploy`
- [ ] **Test on production** → Visit your .vercel.app URL

---

## 🎯 Your Test Domain Will Be

After deployment, Vercel automatically gives you:
- **Primary URL:** `https://collectevm-[random].vercel.app`
- **Branch Previews:** Auto-deploy on git push
- **Production URL:** Can add custom domain later

---

## 🔍 Verify Helius API is Working

After deployment, check your NFT verification:

1. Connect a Solana wallet that owns NFTs
2. Click "Verify NFT Ownership"
3. Check browser console for logs like:
   ```
   🔍 Fetching NFTs for wallet: [address]
   🔑 Using Helius API key: c6b6506e...
   📊 Found X total NFTs via Helius
   ```

Monitor usage: https://dashboard.helius.dev

---

## 🐛 Troubleshooting

### "Node.js not found"
```bash
# Install Node.js from nodejs.org (v18 or higher)
# Or using Homebrew:
brew install node
```

### "npm command not found"
```bash
# npm comes with Node.js
# Reinstall Node.js or check PATH
```

### "Cannot connect to database"
- Ensure DATABASE_URL is set in Vercel
- Check database is accessible from Vercel (not localhost)
- Run migrations: `npx prisma migrate deploy`

### "WalletConnect not working"
- Get Project ID from https://cloud.walletconnect.com
- Add as `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID`
- Redeploy: `vercel --prod`

---

## 📊 What You Get with Helius

Your Helius API provides:

✅ **Fast NFT Queries:** 10x faster than public RPC  
✅ **DAS API:** Digital Asset Standard for efficient NFT data  
✅ **Reliable:** No rate limit errors like public RPC  
✅ **Free Tier:** 100,000 credits/day (very generous)  
✅ **Automatic Fallback:** App falls back to standard RPC if needed  

---

## 🎉 You're Ready!

**Everything is configured. Just deploy!**

**Fastest path to live app:**
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
vercel
```

**Then:**
1. Add environment variables in Vercel dashboard
2. Visit your new URL
3. Test wallet connections

**Your Helius-powered NFT verification app will be live in minutes!** 🚀

---

## 📞 Resources

- **Vercel Docs:** https://vercel.com/docs
- **Helius Dashboard:** https://dashboard.helius.dev
- **WalletConnect:** https://cloud.walletconnect.com
- **Supabase:** https://supabase.com
- **Deployment Guide:** See `DEPLOYMENT_GUIDE_HELIUS.md`
- **Quick Deploy:** See `QUICK_DEPLOY.md`

---

**Status:** ✅ **READY TO DEPLOY**  
**Helius API:** ✅ **CONFIGURED**  
**Next Step:** 🚀 **Run `vercel` command**

