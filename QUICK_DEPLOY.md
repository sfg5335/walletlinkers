# 🚀 Quick Deploy to Test Domain with Helius API

## ✅ Your Helius API is Ready

Your Helius API key has been configured:
- **API Key:** `c6b6506e-b462-4091-8029-63f7e0c37829`
- **Benefits:** 100,000 free credits/day, fast NFT queries, better reliability

---

## 📋 Quick Start (Choose One Method)

### Method 1: One-Click Vercel Deploy (Easiest) ⭐

1. **Click this button:**

   [![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/your-username/CollectEVM-master)

2. **Add these environment variables in Vercel:**

   ```
   SOLANA_RPC_URL=https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829
   HELIUS_API_KEY=c6b6506e-b462-4091-8029-63f7e0c37829
   WASSIEVERSE_COLLECTION_ADDRESS=EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH
   NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=[Get from https://cloud.walletconnect.com]
   NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
   ```

3. **Add Vercel Postgres:**
   - In Vercel dashboard → Storage → Create Database → Postgres
   - Free tier available
   - DATABASE_URL will be auto-added

4. **Deploy!** Your app will be live at `your-app.vercel.app`

---

### Method 2: Manual Vercel Deploy

**Step 1: Install Vercel CLI**
```bash
npm install -g vercel
```

**Step 2: Deploy from your directory**
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
vercel
```

**Step 3: Add environment variables**
```bash
# Or add them in Vercel dashboard: vercel.com/your-project/settings/environment-variables
```

---

### Method 3: Local Testing First

**Run the automated setup script:**
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
./deploy-helius.sh
```

This will:
- ✅ Check Node.js installation
- ✅ Install dependencies
- ✅ Create .env file with Helius API
- ✅ Setup database
- ✅ Build the app

Then test locally:
```bash
npm run dev
```

Visit http://localhost:3000

---

## 🔑 Get WalletConnect Project ID (Required)

1. Go to https://cloud.walletconnect.com
2. Sign up/login (free)
3. Create new project
4. Copy your **Project ID**
5. Add to environment variables

---

## 🗄️ Database Options

### Option A: Vercel Postgres (Recommended)
- Free tier available
- Auto-integrated with Vercel
- Setup: Dashboard → Storage → Create Database

### Option B: Supabase (Free, Generous)
1. Go to https://supabase.com
2. Create project
3. Get connection string: `postgresql://...`

### Option C: Neon (Serverless)
1. Go to https://neon.tech
2. Create project
3. Copy connection string

---

## 🎯 Environment Variables Summary

Copy these to Vercel or your .env file:

```bash
# Database (choose one):
DATABASE_URL="file:./prisma/dev.db"  # Local only
# OR
DATABASE_URL="postgresql://..."      # Production

# Helius API (Already configured ✅)
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"

# Collection Address
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"

# WalletConnect (You need to get this)
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="YOUR_PROJECT_ID_HERE"

# Public RPC
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
```

---

## 🧪 Testing Checklist

Once deployed, test these features:

- [ ] Visit your test domain
- [ ] Click "Connect Solana Wallet" → Phantom opens
- [ ] Click "Verify NFT Ownership" → Sign message
- [ ] See NFTs displayed (if wallet has Wassieverse NFTs)
- [ ] Click "Connect EVM Wallet" → MetaMask opens
- [ ] Click "Link Wallets" → Sign EVM message
- [ ] See success message

---

## 🐛 Common Issues

### Issue: "WalletConnect Project ID not set"
**Fix:** Get one from https://cloud.walletconnect.com and add to env vars

### Issue: "Failed to connect to database"
**Fix:** 
1. Add DATABASE_URL in Vercel
2. Use Vercel Postgres or Supabase
3. Run `npx prisma db push` with that DATABASE_URL

### Issue: "No NFTs found"
**Fix:** 
- Test wallet might not own Wassieverse NFTs (this is normal)
- Verify WASSIEVERSE_COLLECTION_ADDRESS is correct
- Helius API is already configured ✅

---

## 📊 Your Helius API Status

Monitor usage at: https://dashboard.helius.dev

**Your free tier includes:**
- ✅ 100,000 credits/day
- ✅ RPC requests
- ✅ DAS API (fast NFT queries)
- ✅ 10 requests/second
- ✅ No credit card required

---

## 🎉 Ready to Deploy!

**Recommended path:**

1. **Get WalletConnect ID** (5 minutes)
   → https://cloud.walletconnect.com

2. **Run setup script**
   ```bash
   cd /Users/phillipyon/Downloads/CollectEVM-master
   ./deploy-helius.sh
   ```

3. **Test locally**
   ```bash
   npm run dev
   ```

4. **Deploy to Vercel**
   ```bash
   vercel
   ```

5. **Access your test domain:**
   → `https://your-app.vercel.app`

---

## 📞 Need Help?

- **Vercel Docs:** https://vercel.com/docs
- **Helius Docs:** https://docs.helius.dev
- **WalletConnect:** https://docs.walletconnect.com

Your Helius API is ready to go! 🚀

