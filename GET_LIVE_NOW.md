# 🚀 FASTEST PATH TO LIVE SITE

## Option 1: One-Click Vercel Deploy (Easiest - 2 Minutes)

### Step 1: Push to GitHub (Optional but Recommended)

```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
git init
git add .
git commit -m "Initial commit"
gh repo create collectevm --public --source=. --remote=origin --push
```

### Step 2: Deploy via Vercel Dashboard

1. Go to: https://vercel.com/new
2. Click "Import Git Repository"
3. Select your GitHub repo
4. Add environment variables (see below)
5. Click "Deploy"

**Done! Live in 2 minutes!**

---

## Option 2: Vercel CLI Deploy (Fastest - 3 Minutes)

```bash
# Navigate to project
cd /Users/phillipyon/Downloads/CollectEVM-master

# Run the quick deploy script
./quick-deploy.sh

# Deploy
vercel
```

**Your test domain will be:** `https://collectevm-[random].vercel.app`

---

## Option 3: Manual Setup (Most Control - 5 Minutes)

```bash
cd /Users/phillipyon/Downloads/CollectEVM-master

# 1. Setup
cp .env.production .env
npm install

# 2. Database
npx prisma generate
npx prisma db push

# 3. Build
npm run build

# 4. Deploy
npm install -g vercel
vercel login
vercel

# 5. Add env vars in dashboard
# 6. Redeploy
vercel --prod
```

---

## 🔑 Environment Variables for Vercel

**After first deploy**, add these in Vercel Dashboard:

```
DATABASE_URL=postgresql://postgres.ermqlcqyesoitirwutus:i/FPSPU6TV93yC#@aws-0-us-west-1.pooler.supabase.com:5432/postgres

SOLANA_RPC_URL=https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829

HELIUS_API_KEY=c6b6506e-b462-4091-8029-63f7e0c37829

WASSIEVERSE_COLLECTION_ADDRESS=EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH

NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=1a91ca1e820439d2a1391d3b239a8cc1

NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
```

---

## ⚡ SUPER QUICK VERSION (Copy/Paste)

Open your terminal and paste this:

```bash
cd /Users/phillipyon/Downloads/CollectEVM-master && \
./quick-deploy.sh && \
vercel
```

**That's it! Your site will be live!**

---

## 🎯 What You'll Get

**Live Test Domain:**
- `https://collectevm-[random-id].vercel.app`
- Automatic HTTPS
- Global CDN
- Free hosting

**Features Working:**
- ✅ Phantom wallet connection
- ✅ NFT verification via Helius
- ✅ MetaMask connection  
- ✅ Wallet linking
- ✅ Supabase storage

---

## 🐛 Troubleshooting

### "vercel command not found"
```bash
npm install -g vercel
```

### "Node.js not found"
Install from: https://nodejs.org (download LTS version)

### "Permission denied"
```bash
chmod +x quick-deploy.sh
```

### Database connection error
The environment variables will be automatically used from `.env.production`

---

## 📊 After Deployment

**Your Dashboard Links:**
- Live Site: Check Vercel output for URL
- Vercel: https://vercel.com/dashboard
- Supabase: https://supabase.com/dashboard/project/ermqlcqyesoitirwutus
- Helius: https://dashboard.helius.dev

---

## 🎉 Ready to Deploy!

**Recommended path:**
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
./quick-deploy.sh
vercel
```

Your test domain will be live in ~3 minutes!

