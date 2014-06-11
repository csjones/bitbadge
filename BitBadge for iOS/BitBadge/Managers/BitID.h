//
//  BitID.h
//  BitBadge
//
//  Created by Chris on 6/9/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@class WalletManager;

#import "AFHTTPRequestOperationManager.h"

@interface BitID : AFHTTPRequestOperationManager

@property   ( nonatomic, weak) WalletManager* walletManager;

@property   ( nonatomic, readonly ) NSString* challenge;

- ( id )initWithChallenge:( NSString* )challenge;

- ( void )signChallenge;

@end
