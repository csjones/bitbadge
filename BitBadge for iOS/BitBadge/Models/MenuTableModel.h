//
//  MenuTableModel.h
//  BitBadge
//
//  Created by Chris on 6/14/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@class WalletManager;

@interface MenuTableModel : NSObject < UITableViewDataSource >
{
    __weak WalletManager* _weakWalletManager;
    
    NSUInteger _activeInteger;
}

@property   ( nonatomic, strong )   NSArray*    sectionHeaders;

- ( id )initWithActiveKeychain:( NSUInteger )integer;

@end
