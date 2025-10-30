-- CreateTable
CREATE TABLE "Nonce" (
    "id" TEXT NOT NULL,
    "nonce" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "used" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Nonce_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "WalletLink" (
    "id" TEXT NOT NULL,
    "solanaAddress" TEXT NOT NULL,
    "evmAddress" TEXT NOT NULL,
    "tokenIds" TEXT NOT NULL,
    "solanaSignature" TEXT NOT NULL,
    "evmSignature" TEXT NOT NULL,
    "verifiedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "WalletLink_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LinkedNFT" (
    "id" TEXT NOT NULL,
    "tokenId" TEXT NOT NULL,
    "mintAddress" TEXT NOT NULL,
    "solanaAddress" TEXT NOT NULL,
    "evmAddress" TEXT NOT NULL,
    "walletLinkId" TEXT NOT NULL,
    "linkedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "LinkedNFT_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Nonce_nonce_key" ON "Nonce"("nonce");

-- CreateIndex
CREATE INDEX "Nonce_nonce_idx" ON "Nonce"("nonce");

-- CreateIndex
CREATE INDEX "Nonce_address_idx" ON "Nonce"("address");

-- CreateIndex
CREATE UNIQUE INDEX "WalletLink_solanaAddress_evmAddress_key" ON "WalletLink"("solanaAddress", "evmAddress");

-- CreateIndex
CREATE INDEX "WalletLink_solanaAddress_idx" ON "WalletLink"("solanaAddress");

-- CreateIndex
CREATE INDEX "WalletLink_evmAddress_idx" ON "WalletLink"("evmAddress");

-- CreateIndex
CREATE UNIQUE INDEX "LinkedNFT_tokenId_key" ON "LinkedNFT"("tokenId");

-- CreateIndex
CREATE UNIQUE INDEX "LinkedNFT_mintAddress_key" ON "LinkedNFT"("mintAddress");

-- CreateIndex
CREATE INDEX "LinkedNFT_tokenId_idx" ON "LinkedNFT"("tokenId");

-- CreateIndex
CREATE INDEX "LinkedNFT_solanaAddress_idx" ON "LinkedNFT"("solanaAddress");

-- CreateIndex
CREATE INDEX "LinkedNFT_evmAddress_idx" ON "LinkedNFT"("evmAddress");

-- CreateIndex
CREATE INDEX "LinkedNFT_walletLinkId_idx" ON "LinkedNFT"("walletLinkId");

