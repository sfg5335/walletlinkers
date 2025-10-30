# Quick Start - Production Deployment Fixes

## 🚨 Critical Fixes (Do Before Launch)

### 1. Switch to Dedicated RPC Provider

**Current (Development):**
```bash
SOLANA_RPC_URL="https://api.mainnet-beta.solana.com"
```

**Production (Required):**
```bash
# Option A: Helius (Recommended)
SOLANA_RPC_URL="https://rpc.helius.xyz/?api-key=YOUR_API_KEY"
HELIUS_API_KEY="your_helius_api_key"

# Option B: QuickNode
SOLANA_RPC_URL="https://your-endpoint.solana-mainnet.quiknode.pro/YOUR_TOKEN/"

# Option C: Alchemy
SOLANA_RPC_URL="https://solana-mainnet.g.alchemy.com/v2/YOUR_API_KEY"
```

**Get Free API Keys:**
- Helius: https://helius.dev (Free tier: 100k credits/day)
- QuickNode: https://quicknode.com (Free tier: 10M requests/month)
- Alchemy: https://alchemy.com (Free tier: 3M compute units/month)

**Why Critical:** Public RPC will fail under load (rate limits ~15 req/sec)

---

### 2. Use Production Database Migrations

**Current (Development):**
```bash
npx prisma db push
```

**Production (Required):**
```bash
# Generate migration
npx prisma migrate dev --name init

# Deploy to production
npx prisma migrate deploy
```

**Why Critical:** `db push` can cause data loss in production

---

### 3. Set Correct Collection Address

**Update .env:**
```bash
# Find the actual Wassieverse collection address
# Use scripts/find-collection.js or check Solscan
WASSIEVERSE_COLLECTION_ADDRESS="<ACTUAL_COLLECTION_ADDRESS>"
```

**How to Find:**
1. Go to a known Wassieverse NFT on Solscan
2. Look for "Collection" field in metadata
3. Copy the verified collection address

**Why Critical:** Wrong address = no NFTs found

---

## 🟡 Important Improvements (Should Add)

### 4. Add Rate Limiting

**Install:**
```bash
npm install @upstash/ratelimit @upstash/redis
```

**Create middleware.ts:**
```typescript
import { Ratelimit } from "@upstash/ratelimit";
import { Redis } from "@upstash/redis";
import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const ratelimit = new Ratelimit({
  redis: Redis.fromEnv(),
  limiter: Ratelimit.slidingWindow(10, "10 m"),
  analytics: true,
});

export async function middleware(request: NextRequest) {
  // Only rate limit API routes
  if (request.nextUrl.pathname.startsWith("/api/")) {
    const ip = request.ip ?? "127.0.0.1";
    const { success, pending, limit, reset, remaining } = await ratelimit.limit(ip);

    if (!success) {
      return NextResponse.json(
        { error: "Too many requests" },
        { status: 429 }
      );
    }
  }

  return NextResponse.next();
}

export const config = {
  matcher: "/api/:path*",
};
```

**Setup Upstash Redis:**
1. Go to https://upstash.com
2. Create free Redis database
3. Add to .env:
```bash
UPSTASH_REDIS_REST_URL="your_url"
UPSTASH_REDIS_REST_TOKEN="your_token"
```

---

### 5. Add Nonce Cleanup

**Create app/api/cron/cleanup-nonces/route.ts:**
```typescript
import { NextRequest, NextResponse } from "next/server";
import { prisma } from "@/lib/prisma";

export async function GET(req: NextRequest) {
  // Verify this is from your cron service
  const authHeader = req.headers.get("authorization");
  if (authHeader !== `Bearer ${process.env.CRON_SECRET}`) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }

  try {
    const result = await prisma.nonce.deleteMany({
      where: {
        expiresAt: {
          lt: new Date(),
        },
      },
    });

    return NextResponse.json({
      success: true,
      deleted: result.count,
    });
  } catch (error) {
    console.error("Cleanup error:", error);
    return NextResponse.json(
      { error: "Cleanup failed" },
      { status: 500 }
    );
  }
}
```

**Setup Vercel Cron:**
```json
// vercel.json
{
  "crons": [{
    "path": "/api/cron/cleanup-nonces",
    "schedule": "0 */6 * * *"
  }]
}
```

**Add to .env:**
```bash
CRON_SECRET="your_random_secret_here"
```

---

### 6. Add Error Monitoring

**Install Sentry:**
```bash
npm install @sentry/nextjs
```

**Setup:**
```bash
npx @sentry/wizard@latest -i nextjs
```

**Why Important:** Track production errors and performance issues

---

## 🟢 Optional Enhancements

### 7. Add Environment Variable Validation

**Install zod:**
```bash
npm install zod
```

**Create lib/env.ts:**
```typescript
import { z } from "zod";

const envSchema = z.object({
  DATABASE_URL: z.string().url(),
  SOLANA_RPC_URL: z.string().url(),
  WASSIEVERSE_COLLECTION_ADDRESS: z.string().min(32),
  NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID: z.string().min(32),
  HELIUS_API_KEY: z.string().optional(),
});

export const env = envSchema.parse(process.env);
```

**Use in code:**
```typescript
import { env } from "@/lib/env";

// Instead of: process.env.DATABASE_URL
// Use: env.DATABASE_URL
```

---

### 8. Add Retry Logic for RPC

**Create lib/rpc-retry.ts:**
```typescript
export async function withRetry<T>(
  fn: () => Promise<T>,
  maxRetries = 3,
  delay = 1000
): Promise<T> {
  let lastError: Error | unknown;

  for (let i = 0; i < maxRetries; i++) {
    try {
      return await fn();
    } catch (error) {
      lastError = error;
      if (i < maxRetries - 1) {
        await new Promise(resolve => setTimeout(resolve, delay * (i + 1)));
      }
    }
  }

  throw lastError;
}
```

**Use in NFT queries:**
```typescript
const nfts = await withRetry(() => getWassieverseNFTs(solAddress));
```

---

## 📋 Deployment Checklist

### Before Deploy
- [ ] Set production `DATABASE_URL`
- [ ] Set `SOLANA_RPC_URL` to dedicated provider
- [ ] Set correct `WASSIEVERSE_COLLECTION_ADDRESS`
- [ ] Set `NEXT_PUBLIC_WALLETCONNECT_PROJECT_ID`
- [ ] Run `npx prisma migrate deploy`
- [ ] Test on testnet first
- [ ] Add rate limiting
- [ ] Add error monitoring
- [ ] Set up nonce cleanup cron

### After Deploy
- [ ] Verify HTTPS is working
- [ ] Test wallet connections
- [ ] Test NFT verification
- [ ] Test wallet linking
- [ ] Monitor error logs
- [ ] Check RPC usage
- [ ] Test with real users

---

## 🧪 Testing on Testnet First

**1. Switch to Devnet:**
```bash
# .env.test
SOLANA_RPC_URL="https://api.devnet.solana.com"
WASSIEVERSE_COLLECTION_ADDRESS="<devnet_test_collection>"
```

**2. Use Sepolia for EVM:**
```typescript
// lib/wagmi.ts - Already configured for sepolia
```

**3. Get Test Tokens:**
- Solana devnet: https://faucet.solana.com
- Sepolia ETH: https://sepoliafaucet.com

---

## 🔍 Monitoring & Debugging

### Check RPC Usage
```typescript
// Add to lib/solana.ts
console.log(`RPC call to: ${process.env.SOLANA_RPC_URL}`);
console.log(`Timestamp: ${new Date().toISOString()}`);
```

### Monitor Database
```bash
# Open Prisma Studio
npx prisma studio

# Check tables:
# - Nonce (should clean up expired ones)
# - WalletLink (wallet pairs)
# - LinkedNFT (individual NFT links)
```

### Check Logs
```bash
# Vercel
vercel logs

# Or in Vercel dashboard
# https://vercel.com/your-project/logs
```

---

## 🆘 Common Errors & Fixes

### Error: "Failed to fetch NFTs"
**Fix:** Use dedicated RPC provider (see #1 above)

### Error: "Nonce expired"
**Fix:** User should retry (this is expected if > 5 minutes)

### Error: "NFT already linked"
**Fix:** This is expected behavior - NFTs can only link once

### Error: "Invalid signature"
**Fix:** Check message format matches between frontend and backend

### Error: "Failed to connect to database"
**Fix:** Check `DATABASE_URL` is correct and database is accessible

---

## 📊 Expected Performance

### With Dedicated RPC (Production)
- Nonce generation: ~50-100ms ✅
- NFT verification: ~500-1000ms ✅
- Wallet linking: ~200-300ms ✅
- **Total flow: 2-3 seconds** ✅

### With Public RPC (Development Only)
- NFT verification: **3-10 seconds** ⚠️

---

## 🎯 Priority Order

1. **Critical (Must Do):** #1, #2, #3
2. **Important (Should Do):** #4, #5, #6
3. **Optional (Nice to Have):** #7, #8

**Minimum viable production: Fix #1, #2, #3 and test thoroughly.**

---

**Quick Reference Guide**  
**Last Updated:** October 29, 2025  
**For CollectEVM v0.1.0**

