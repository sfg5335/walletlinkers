# 🗄️ Supabase Database Configuration

## Your Supabase Database

**Project URL:** https://ermqlcqyesoitirwutus.supabase.co  
**Project Ref:** ermqlcqyesoitirwutus  
**Anon Key:** eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVybXFsY3F5ZXNvaXRpcnd1dHVzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE3OTk0ODAsImV4cCI6MjA3NzM3NTQ4MH0.flcL9n5GdMx3E7dnN6bfwIR6-fGyfN0aYFnhr05MBE8

---

## 🔑 Get Your Database Connection String

### Step 1: Get Database Password from Supabase

1. Go to: https://supabase.com/dashboard/project/ermqlcqyesoitirwutus
2. Click **Settings** (gear icon) in left sidebar
3. Click **Database** 
4. Scroll to **Connection string** section
5. Select **URI** tab
6. Copy the connection string

It will look like:
```
postgresql://postgres.ermqlcqyesoitirwutus:[YOUR-PASSWORD]@aws-0-us-west-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```

### Step 2: For Direct Connection (Prisma Migrations)

Also copy the **Direct connection** string (needed for migrations):
```
postgresql://postgres.ermqlcqyesoitirwutus:[YOUR-PASSWORD]@aws-0-us-west-1.pooler.supabase.com:5432/postgres
```

---

## 📋 Complete Environment Variables

Once you have your connection string, here are ALL your environment variables ready to go:

### For Vercel Deployment

Add these in Vercel Dashboard → Settings → Environment Variables:

```bash
# Database (Get from Supabase - see above)
DATABASE_URL=postgresql://postgres.ermqlcqyesoitirwutus:[YOUR-PASSWORD]@aws-0-us-west-1.pooler.supabase.com:6543/postgres?pgbouncer=true

# Or use the direct connection:
DATABASE_URL=postgresql://postgres.ermqlcqyesoitirwutus:[YOUR-PASSWORD]@aws-0-us-west-1.pooler.supabase.com:5432/postgres

# Helius API (Ready ✅)
SOLANA_RPC_URL=https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829
HELIUS_API_KEY=c6b6506e-b462-4091-8029-63f7e0c37829

# Collection Address (Ready ✅)
WASSIEVERSE_COLLECTION_ADDRESS=EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH

# WalletConnect (Get from cloud.walletconnect.com)
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID=your_walletconnect_project_id

# Public RPC (Ready ✅)
NEXT_PUBLIC_SOLANA_RPC_URL=https://api.mainnet-beta.solana.com
```

---

## 🚀 Deploy Now with Complete Configuration

### Option 1: Quick Deploy (Recommended)

```bash
# 1. Navigate to project
cd /Users/phillipyon/Downloads/CollectEVM-master

# 2. Install Vercel CLI (if not already installed)
npm install -g vercel

# 3. Login to Vercel
vercel login

# 4. Deploy
vercel
```

**When prompted:**
- Project name: `collectevm` (or your choice)
- Link to existing: No
- Deploy: Yes

**After first deployment:**
1. Go to Vercel dashboard
2. Add all environment variables above
3. Redeploy: `vercel --prod`

---

### Option 2: Local Testing First

**Create .env file:**
```bash
cd /Users/phillipyon/Downloads/CollectEVM-master
```

Create a file named `.env` with this content:
```bash
# Get this from Supabase dashboard (see Step 1 above)
DATABASE_URL="postgresql://postgres.ermqlcqyesoitirwutus:[YOUR-PASSWORD]@aws-0-us-west-1.pooler.supabase.com:5432/postgres"

# Helius API
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=c6b6506e-b462-4091-8029-63f7e0c37829"
HELIUS_API_KEY="c6b6506e-b462-4091-8029-63f7e0c37829"

# Collection Address
WASSIEVERSE_COLLECTION_ADDRESS="EwxYgrffpuTuNa4C1b4xxrEkRbZAQgMG5fAiY3uJVZoH"

# Get from cloud.walletconnect.com
NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID="your_project_id"

# Public RPC
NEXT_PUBLIC_SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
```

**Setup database:**
```bash
npm install
npx prisma generate
npx prisma db push
```

**Test locally:**
```bash
npm run dev
```

Visit http://localhost:3000

**Deploy when ready:**
```bash
vercel --prod
```

---

## 🗄️ Setup Database Schema

After you have your DATABASE_URL configured:

### For Local Development:
```bash
# With your .env file configured
npx prisma generate
npx prisma db push
```

### For Production (Vercel):
```bash
# Set the DATABASE_URL temporarily
export DATABASE_URL="postgresql://postgres.ermqlcqyesoitirwutus:[YOUR-PASSWORD]@aws-0-us-west-1.pooler.supabase.com:5432/postgres"

# Run migrations
npx prisma generate
npx prisma db push

# Or use Vercel CLI
vercel env pull .env.production
npx prisma db push
```

---

## 🔧 Supabase Dashboard Access

Your Supabase project: https://supabase.com/dashboard/project/ermqlcqyesoitirwutus

**Useful sections:**
- **Table Editor:** View your data
- **SQL Editor:** Run queries
- **Database → Connection Pooling:** Connection strings
- **Settings → Database:** Get connection info

---

## 📊 Your Complete Configuration Status

✅ **Supabase Database:** Configured  
✅ **Helius API:** Configured  
✅ **Collection Address:** Configured  
⚠️ **WalletConnect ID:** Need to get from cloud.walletconnect.com  
⚠️ **Database Password:** Need to get from Supabase dashboard  

---

## 🎯 Next Steps

1. **Get Database Password:**
   - Go to Supabase dashboard
   - Settings → Database
   - Copy connection string with password

2. **Get WalletConnect ID:**
   - Go to https://cloud.walletconnect.com
   - Create project (2 minutes)
   - Copy Project ID

3. **Deploy:**
   ```bash
   cd /Users/phillipyon/Downloads/CollectEVM-master
   vercel
   ```

4. **Add Environment Variables in Vercel**

5. **Run Database Migrations**

6. **Visit Your App:**
   `https://your-app.vercel.app`

---

## 🔐 Security Note

Your Supabase credentials are now in this file. Keep it secure:
- ✅ Don't commit to public GitHub
- ✅ Only share with trusted team members
- ✅ Use Row Level Security (RLS) in Supabase if needed
- ✅ Monitor database access in Supabase dashboard

---

## ✨ You're Almost There!

**You have:**
- ✅ Helius API configured
- ✅ Supabase database ready
- ✅ Project code ready

**You need:**
- ⚠️ Database password from Supabase
- ⚠️ WalletConnect Project ID

**Then deploy with: `vercel`**

---

**Total setup time remaining: ~5 minutes!** 🚀

