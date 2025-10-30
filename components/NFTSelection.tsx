'use client';

import { useState, useEffect, useCallback } from 'react';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Button } from '@/components/ui/button';
import { Checkbox } from '@/components/ui/checkbox';
import { Badge } from '@/components/ui/badge';
import { Loader2, Link, Unlink } from 'lucide-react';

interface NFT {
  mintAddress: string;
  tokenId: string;
  name: string;
  image?: string;
  isLinked: boolean;
  linkedTo?: string; // EVM address it's linked to
}

interface NFTSelectionProps {
  solanaAddress: string;
  evmAddress?: string | null;
  verifiedNFTs: { mintAddress: string; tokenId: string }[];
  onSelectionChange: (selectedTokenIds: string[]) => void;
  onLinkNFTs: (selectedTokenIds: string[]) => Promise<void>;
  isLinking: boolean;
}

export function NFTSelection({ 
  solanaAddress, 
  evmAddress, 
  verifiedNFTs,
  onSelectionChange, 
  onLinkNFTs, 
  isLinking 
}: NFTSelectionProps) {
  const [nfts, setNfts] = useState<NFT[]>([]);
  const [selectedTokenIds, setSelectedTokenIds] = useState<string[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const fetchLinkingStatus = useCallback(async () => {
    if (!verifiedNFTs.length) return;
    
    setLoading(true);
    setError(null);
    
    try {
      // Get the linking status for each NFT
      const linkingStatusResponse = await fetch('/api/nft-status', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ 
          tokenIds: verifiedNFTs.map(nft => nft.tokenId)
        }),
      });

      let linkingStatuses: Record<string, { isLinked: boolean; linkedTo?: string }> = {};
      
      if (linkingStatusResponse.ok) {
        const statusData = await linkingStatusResponse.json();
        linkingStatuses = statusData.statuses || {};
      }

      // Combine verified NFT data with linking status
      const nftsWithStatus = verifiedNFTs.map((nft) => ({
        mintAddress: nft.mintAddress,
        tokenId: nft.tokenId,
        name: `Wassieverse #${nft.tokenId}`,
        isLinked: linkingStatuses[nft.tokenId]?.isLinked || false,
        linkedTo: linkingStatuses[nft.tokenId]?.linkedTo
      }));

      setNfts(nftsWithStatus);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load NFT status');
    } finally {
      setLoading(false);
    }
  }, [verifiedNFTs]);

  // Fetch linking status when verified NFTs change
  useEffect(() => {
    if (verifiedNFTs.length > 0) {
      fetchLinkingStatus();
    }
  }, [verifiedNFTs, evmAddress, fetchLinkingStatus]);

  const handleNFTSelect = (tokenId: string, checked: boolean) => {
    const newSelection = checked 
      ? [...selectedTokenIds, tokenId]
      : selectedTokenIds.filter(id => id !== tokenId);
    
    setSelectedTokenIds(newSelection);
    onSelectionChange(newSelection);
  };

  const handleSelectAllUnlinked = () => {
    const unlinkedTokenIds = nfts
      .filter(nft => !nft.isLinked)
      .map(nft => nft.tokenId);
    
    setSelectedTokenIds(unlinkedTokenIds);
    onSelectionChange(unlinkedTokenIds);
  };

  const handleClearSelection = () => {
    setSelectedTokenIds([]);
    onSelectionChange([]);
  };

  if (loading) {
    return (
      <Card>
        <CardContent className="p-6">
          <div className="flex items-center justify-center space-x-2">
            <Loader2 className="h-4 w-4 animate-spin" />
            <span>Loading your Wassieverse NFTs...</span>
          </div>
        </CardContent>
      </Card>
    );
  }

  if (error) {
    return (
      <Card>
        <CardContent className="p-6">
          <div className="text-center text-red-600">
            <p>Error loading NFTs: {error}</p>
            <Button 
              onClick={fetchLinkingStatus} 
              variant="outline" 
              className="mt-2"
            >
              Try Again
            </Button>
          </div>
        </CardContent>
      </Card>
    );
  }

  if (nfts.length === 0) {
    return (
      <Card>
        <CardContent className="p-6">
          <div className="text-center text-gray-600">
            <p>No Wassieverse NFTs found in this wallet.</p>
          </div>
        </CardContent>
      </Card>
    );
  }

  const unlinkedNFTs = nfts.filter(nft => !nft.isLinked);
  const linkedNFTs = nfts.filter(nft => nft.isLinked);

  return (
    <div className="space-y-6">
      {/* Summary */}
      <Card>
        <CardHeader>
          <CardTitle className="flex items-center justify-between">
            <span>Your Wassieverse NFTs</span>
            <div className="flex space-x-2">
              <Badge variant="outline" className="bg-green-50 text-green-700 border-green-200">
                {linkedNFTs.length} Linked
              </Badge>
              <Badge variant="outline" className="bg-blue-50 text-blue-700 border-blue-200">
                {unlinkedNFTs.length} Available
              </Badge>
            </div>
          </CardTitle>
        </CardHeader>
        <CardContent>
          <div className="flex space-x-2">
            {unlinkedNFTs.length > 0 && (
              <Button 
                onClick={handleSelectAllUnlinked}
                variant="outline"
                size="sm"
              >
                Select All Unlinked ({unlinkedNFTs.length})
              </Button>
            )}
            {selectedTokenIds.length > 0 && (
              <Button 
                onClick={handleClearSelection}
                variant="outline"
                size="sm"
              >
                Clear Selection
              </Button>
            )}
          </div>
        </CardContent>
      </Card>

      {/* Linked NFTs */}
      {linkedNFTs.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <Link className="h-5 w-5 text-green-600" />
              <span>Already Linked</span>
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {linkedNFTs.map((nft) => (
                <div key={nft.tokenId} className="border rounded-lg p-4 bg-green-50 border-green-200">
                  <div className="flex items-center justify-between">
                    <div>
                      <h3 className="font-semibold">Wassieverse #{nft.tokenId}</h3>
                      <p className="text-sm text-gray-600">
                        Linked to: {nft.linkedTo?.slice(0, 6)}...{nft.linkedTo?.slice(-4)}
                      </p>
                    </div>
                    <Badge variant="outline" className="bg-green-100 text-green-800 border-green-300">
                      <Link className="h-3 w-3 mr-1" />
                      Linked
                    </Badge>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Available NFTs for Linking */}
      {unlinkedNFTs.length > 0 && (
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center space-x-2">
              <Unlink className="h-5 w-5 text-blue-600" />
              <span>Available for Linking</span>
            </CardTitle>
          </CardHeader>
          <CardContent>
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {unlinkedNFTs.map((nft) => (
                <div key={nft.tokenId} className="border rounded-lg p-4 bg-blue-50 border-blue-200">
                  <div className="flex items-center space-x-3">
                    <Checkbox
                      checked={selectedTokenIds.includes(nft.tokenId)}
                      onCheckedChange={(checked) => 
                        handleNFTSelect(nft.tokenId, checked as boolean)
                      }
                    />
                    <div className="flex-1">
                      <h3 className="font-semibold">Wassieverse #{nft.tokenId}</h3>
                      <p className="text-sm text-gray-600">Ready to link</p>
                    </div>
                    <Badge variant="outline" className="bg-blue-100 text-blue-800 border-blue-300">
                      Available
                    </Badge>
                  </div>
                </div>
              ))}
            </div>
          </CardContent>
        </Card>
      )}

      {/* Link Selected NFTs */}
      {selectedTokenIds.length > 0 && evmAddress && (
        <Card>
          <CardContent className="p-6">
            <div className="text-center space-y-4">
              <p className="text-lg">
                Ready to link <strong>{selectedTokenIds.length}</strong> NFT(s) to your EVM wallet?
              </p>
              <Button 
                onClick={() => onLinkNFTs(selectedTokenIds)}
                disabled={isLinking}
                className="w-full"
              >
                {isLinking ? (
                  <>
                    <Loader2 className="h-4 w-4 mr-2 animate-spin" />
                    Linking NFTs...
                  </>
                ) : (
                  <>
                    <Link className="h-4 w-4 mr-2" />
                    Link Selected NFTs
                  </>
                )}
              </Button>
            </div>
          </CardContent>
        </Card>
      )}
    </div>
  );
}
