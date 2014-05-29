//
//  WalletManager.h
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@interface WalletManager : NSObject

@property ( nonatomic, readonly ) NSArray*  keychains;

+ ( id )sharedInstance;

- ( void )addKeychainWithKey:( NSString* )key;
- ( void )addKeychainWithSeed:( NSData* )seed
                         name:( NSString* )name
                    encrypted:( NSNumber* )encrypted
                        chain:( NSArray* )chain;

- ( void )removeKeychainWithKey:( NSString* )key;
- ( void )removeKeychainWithSeed:( NSString* )seed;

@end
