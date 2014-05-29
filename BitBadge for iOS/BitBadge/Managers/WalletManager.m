//
//  WalletManager.m
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "BTCKey.h"
#import "BTCBase58.h"
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
        NSDictionary* keychain = @{ @"seed" : @"12", @"encrypted" : @0, @"name" : @"Master Node", @"chain" : @[] };
        
        NSLog(@"BTCKeychain %@", [[BTCKeychain alloc] initWithSeed:[keychain.encryptedSeed dataUsingEncoding:NSUTF8StringEncoding]]);
        
        [self writeToDeviceKeychain];
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
#pragma mark    -   Public

- ( void )addKeychainWithKey:( NSString* )key
{
    
}

- ( void )addKeychainWithSeed:( NSData* )seed name:( NSString* )name encrypted:( NSNumber* )encrypted chain:( NSArray* )chain
{
    NSMutableArray* updatedKeychains = _keychains.mutableCopy;
    
    [updatedKeychains addObject:[[BTCKeychain alloc] initWithSeed:seed]];
    
    _keychains = [[NSArray alloc] initWithArray:updatedKeychains];
}

- ( void )removeKeychainWithKey:( NSString* )key
{
    
}

- ( void )removeKeychainWithSeed:( NSString* )seed
{
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   Private

- ( NSString* )service
{
    return @"BitBadge";
}

- ( void )writeToDeviceKeychain
{
    for ( __weak NSDictionary* weakMasterNode in _keychains)
    {
        SSKeychainQuery* query = [[SSKeychainQuery alloc] init];
        
        query.service = self.service;
        query.account = weakMasterNode.nodeName;
        query.password = weakMasterNode.encryptedSeed;
        query.accessGroup = ( __bridge NSString* )kSecClassKey;
        
        NSError* error = nil;
        
        if( ![query save:&error] )
            NSLog(@"writeToDeviceKeychain MasterNode: %@ Error: %@", weakMasterNode, error );
    }
}

- ( void )readFromDeviceKeychain
{
    SSKeychainQuery* query = [[SSKeychainQuery alloc] init];
    
    query.service = [self service];
//    query.account = name;
    query.accessGroup = ( __bridge NSString* )kSecClassKey;
    
    NSError* error = nil;
    
    NSArray* walletKey = [query fetchAll:&error];
    
    NSLog(@"WalletKeys: %@", walletKey);
    
    if( !walletKey )
        NSLog(@"readFromDeviceKeychain Error: %@", error );
}

@end
