//
//  ScanModel.h
//  BitBadge
//
//  Created by Chris on 6/8/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@class WalletManager;

@interface ScanModel : NSObject < UITableViewDataSource >
{
    __weak WalletManager* _weakWalletManager;
    
    NSUInteger _activeInteger;
}

- ( id )initWithActiveKeychain:( NSUInteger )integer;

@end
