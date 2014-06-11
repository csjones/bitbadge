//
//  NSDictionary+MasterNode.h
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@interface NSDictionary ( MasterNode )

- ( NSArray* )wallets;

- ( NSDictionary* )info;

- ( NSString* )nodeName;

- ( NSNumber* )encrypted;

- ( NSString* )seedWithKey:( NSString* )key;

- ( NSDictionary* )walletAtIndex:( NSInteger )index;

- ( NSString* )walletNameAtIndex:( NSInteger )index;

- ( NSArray* )addressesForWalletAtIndex:( NSInteger )index;

- ( NSString* )publicKeyAtIndex:( NSInteger )address withWalletIndex:( NSInteger )wallet;

- ( NSString* )addressNameWithIndex:( NSInteger )address forWalletAtIndex:( NSInteger )wallet;

- ( NSData* )sign:( NSString* )message addressAtIndex:( NSInteger )address withWalletIndex:( NSInteger )wallet;

@end
