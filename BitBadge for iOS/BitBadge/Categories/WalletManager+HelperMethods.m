//
//  WalletManager+HelperMethods.m
//  BitBadge
//
//  Created by Chris on 6/15/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "WalletManager+HelperMethods.h"

@implementation WalletManager ( HelperMethods )

- ( NSDictionary* )currentKeychain
{
    return self.keychains[ self.activeKeychain.integerValue ];
}

- ( NSUInteger )numberOfMatchesForString:( NSString* )string
{
    NSUInteger count = 0;
    
    __weak NSArray* weakWallets = self.keychains[ self.activeKeychain.integerValue ][ @"info" ][ @"wallets" ];
    
    for ( __weak NSDictionary* weakWallet in weakWallets )
        for ( __weak NSString* weakAddress in weakWallet.allValues[ 0 ])
        {
            NSRange result = [weakAddress rangeOfString:string];
            
            if ( result.location != NSNotFound )
                count++;
        }
    
    return count;
}

@end
