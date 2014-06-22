//
//  WalletManager.m
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "BTCKey.h"
#import "BTCBase58.h"
#import "BTCAddress.h"
#import "SSKeychain.h"
#import "BTCKeychain.h"
#import "WalletManager.h"
#import "NSDictionary+MasterNode.h"

@interface WalletManager ( )

- ( NSString* )service;

- ( void )writeToDeviceKeychain;
- ( void )readFromDeviceKeychain;

@end

@implementation WalletManager

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   NSObject

- ( id )init
{
    if ( self = [super init] )
    {
        NSDictionary* keychain = @{ @"name" : @"Master Node",
                                    @"info" : @{ @"encrypted" : @0,
                                                 @"seed" : @"12",
                                                 @"wallets" : @[ @{ @"Sample Wallet One" : @[ @"Sample Address One", @"Sample Address Two" ], },
                                                                 @{ @"Sample Wallet Two" : @[ @"Sample Address One", @"Sample Address Two" ], }, ], }, };
        
        [self addKeychainWithDictionary:keychain];
        
//        NSLog(@"BTCKeychain %@", [[BTCKeychain alloc] initWithSeed:[[keychain seedWithKey:nil] dataUsingEncoding:NSUTF8StringEncoding]]);
        
        [self writeToDeviceKeychain];
        
//        [self readFromDeviceKeychain];
        
        _activeKeychain = @0;
        
//        BTCKeychain* master = [[BTCKeychain alloc] initWithSeed:[[_keychains[0] seedWithKey:nil] dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        BTCKeychain* derived = [master derivedKeychainAtIndex:0];
//        
//        for ( NSInteger i = 0; i < 10; i++)
//        {
//            BTCKey* derivedKey = [derived keyAtIndex:i];
//            
//            NSLog(@"publicKeyAddress %@", derivedKey.publicKeyAddress.base58String);
//            NSLog(@"privateKeyAddress %@", derivedKey.privateKeyAddress.base58String);
//        }
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Singleton

+ ( id )sharedInstance
{
    static WalletManager *sharedInstance = nil;
    
    if( sharedInstance )
        return sharedInstance;
    
    static dispatch_once_t pred;	// Lock
    
    dispatch_once(&pred,
                  ^{	// This code is called at most once per app
                      sharedInstance = [[WalletManager alloc] init];
                  });
    
    return sharedInstance;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Keychain

- ( void )addKeychainWithKey:( NSString* )key
{
    
}

- ( void )addKeychainWithDictionary:( NSDictionary* )dictionary
{
    NSMutableArray* updatedKeychains = _keychains.mutableCopy;
    
    if ( !updatedKeychains )
        updatedKeychains = [[NSMutableArray alloc] initWithCapacity:1];
    
    [updatedKeychains addObject:dictionary];
    
    _keychains = [[NSArray alloc] initWithArray:updatedKeychains];
}

- ( void )addKeychainWithSeed:( NSData* )seed name:( NSString* )name encrypted:( NSNumber* )encrypted chain:( NSArray* )chain
{
    NSDictionary* keychain = [[NSDictionary alloc] initWithObjectsAndKeys:seed, @"seed", name, @"name", encrypted, @"encrypted", chain, @"chain", nil];
    
    [self addKeychainWithDictionary:keychain];
}

- ( void )removeKeychainWithKey:( NSString* )key
{
    
}

- ( void )removeKeychainWithSeed:( NSString* )seed
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Addresses

- ( void )addAddressWithString:( NSString* )string forWallet:( NSInteger )wallet
{
    NSMutableArray* mutableKeychains = [_keychains mutableCopy];
    
    NSMutableDictionary* mutableNode = [mutableKeychains[ _activeKeychain.integerValue ] mutableCopy];
    
    NSMutableDictionary* mutableInfo = [mutableNode[ @"info" ] mutableCopy];
    
    NSMutableArray* mutableWallets = [mutableInfo[ @"wallets" ] mutableCopy];
    
    NSMutableDictionary* mutableWallet = [mutableWallets[ wallet ] mutableCopy];
    
    NSMutableArray* mutableAddreses = [mutableWallet[ mutableWallet.allKeys[ 0 ] ] mutableCopy];
    
    [mutableAddreses addObject:string];
    
    mutableWallet[ mutableWallet.allKeys[ 0 ] ] = [[NSArray alloc] initWithArray:mutableAddreses];
    
    mutableWallets[ wallet ] = [[NSDictionary alloc] initWithDictionary:mutableWallet];
    
    mutableInfo[ @"wallets" ] = [[NSArray alloc] initWithArray:mutableWallets];
    
    mutableNode[ @"info" ] = [[NSDictionary alloc] initWithDictionary:mutableInfo];
    
    mutableKeychains[ _activeKeychain.integerValue ] = [[NSDictionary alloc] initWithDictionary:mutableNode];
    
    _keychains = [[NSArray alloc] initWithArray:mutableKeychains];
    
    [self writeToDeviceKeychain];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Private

- ( NSString* )service
{
    return @"co.GigaBitcoin.BitBadge";
}

- ( void )writeToDeviceKeychain
{
    for ( __weak NSDictionary* weakMasterNode in _keychains)
    {
        SSKeychainQuery* query = [[SSKeychainQuery alloc] init];
        
        query.service = self.service;
        query.account = weakMasterNode.nodeName;
        query.passwordObject = weakMasterNode.info;
        query.accessGroup = ( __bridge NSString* )kSecClassKey;
        
        NSError* error = nil;
        
        if( ![query save:&error] )
            NSLog(@"writeToDeviceKeychain MasterNode: %@ Error: %@", weakMasterNode, error );
    }
}

- ( void )readFromDeviceKeychain
{
    SSKeychainQuery* query = [[SSKeychainQuery alloc] init];
    
    query.service = self.service;
    query.accessGroup = ( __bridge NSString* )kSecClassKey;
    
    NSError* error = nil;
    
    NSArray* masterNodes = [query fetchAll:&error];
    
    if( !masterNodes )
    {
        NSLog(@"readFromDeviceKeychain Error: %@", error );
        return;
    }
    
    NSMutableArray* localKeychains = [[NSMutableArray alloc] init];
    
    for ( __weak NSDictionary* weakDictionary in masterNodes)
    {
        query.account = weakDictionary[ @"acct" ];
        
        [query fetch:&error];
        
        [localKeychains addObject:[[NSDictionary alloc] initWithObjectsAndKeys: query.account, @"name", query.passwordObject, @"info", nil]];
    }
    
    _keychains = [[NSArray alloc] initWithArray:localKeychains];
    
    NSLog(@"_keychains %@", _keychains);
}

@end
