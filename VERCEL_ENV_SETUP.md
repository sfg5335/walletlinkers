# Vercel Environment Variables Setup

## Required Environment Variables

Add these in your Vercel project settings:

### 1. DATABASE_URL
```
postgresql://postgres.qjlrynnxyiuwglthiklt:i/FPSPU6TV93yC#@aws-0-us-west-1.pooler.supabase.com:6543/postgres?pgbouncer=true
```

### 2. WASSIEVERSE_COLLECTION_ADDRESS
```
4SqHLfz19CeqFvpnCxuCVHMqKApFxzRXVXwdRewwqfDT
```

### 3. HELIUS_API_KEY
```
c6b6506e-b462-4091-8029-63f7e0c37829
```

### 4. WALLETLINK_ID
```
1a91ca1e820439d2a1391d3b239a8cc1
```

## How to Add in Vercel

1. Go to https://vercel.com/dashboard
2. Select your project (`walletlinkers`)
3. Go to Settings → Environment Variables
4. Add each variable above
5. Make sure to check "Production", "Preview", and "Development"
6. Click "Save"
7. Redeploy your project

## Database Migration

After adding environment variables, you need to run Prisma migrations:

1. In Vercel, your build will automatically run `prisma generate`
2. To create tables, run locally:
   ```bash
   npx prisma migrate deploy
   ```

Or use Supabase SQL Editor:

```sql
-- Run this in Supabase SQL Editor
-- Tables will be created automatically by Prisma on first deploy

-- Or manually create tables:
CREATE TABLE "Nonce" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "nonce" TEXT NOT NULL UNIQUE,
    "address" TEXT NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL
);

CREATE TABLE "WalletLink" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "solanaAddress" TEXT NOT NULL,
    "evmAddress" TEXT NOT NULL,
    "tokenIds" TEXT NOT NULL,
    "solanaSignature" TEXT NOT NULL,
    "evmSignature" TEXT NOT NULL,
    "verifiedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL
);

CREATE TABLE "LinkedNFT" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "tokenId" TEXT NOT NULL UNIQUE,
    "mintAddress" TEXT NOT NULL UNIQUE,
    "solanaAddress" TEXT NOT NULL,
    "evmAddress" TEXT NOT NULL,
    "walletLinkId" TEXT NOT NULL,
    "linkedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE UNIQUE INDEX "WalletLink_solanaAddress_evmAddress_key" ON "WalletLink"("solanaAddress", "evmAddress");
CREATE INDEX "Nonce_nonce_idx" ON "Nonce"("nonce");
CREATE INDEX "Nonce_address_idx" ON "Nonce"("address");
CREATE INDEX "WalletLink_solanaAddress_idx" ON "WalletLink"("solanaAddress");
CREATE INDEX "WalletLink_evmAddress_idx" ON "WalletLink"("evmAddress");
CREATE INDEX "LinkedNFT_tokenId_idx" ON "LinkedNFT"("tokenId");
CREATE INDEX "LinkedNFT_solanaAddress_idx" ON "LinkedNFT"("solanaAddress");
CREATE INDEX "LinkedNFT_evmAddress_idx" ON "LinkedNFT"("evmAddress");
CREATE INDEX "LinkedNFT_walletLinkId_idx" ON "LinkedNFT"("walletLinkId");
```

## ✅ Deployment Checklist

- [ ] Add all 4 environment variables in Vercel
- [ ] Run Prisma migration (or execute SQL above in Supabase)
- [ ] Redeploy in Vercel
- [ ] Test the application

Your app should now work correctly! 🚀

