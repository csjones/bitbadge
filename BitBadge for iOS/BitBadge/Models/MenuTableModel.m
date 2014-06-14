//
//  MenuTableModel.m
//  BitBadge
//
//  Created by Chris on 6/14/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "WalletManager.h"
#import "MenuTableModel.h"
#import "NSDictionary+MasterNode.h"

@implementation MenuTableModel

- ( id )initWithActiveKeychain:( NSUInteger )integer
{
    if ( self = [super init] )
    {
        _weakWalletManager = [WalletManager sharedInstance];
        
        NSMutableArray* newHeaders = [[NSMutableArray alloc] init];
        
        for( NSUInteger i = 0; i < [_weakWalletManager.keychains[ _activeInteger ] wallets].count; i++ )
            [newHeaders addObject:@0];
        
        _sectionHeaders = [[NSArray alloc] initWithArray:newHeaders];
        
        _activeInteger = integer;
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   UITableViewDataSource

- ( NSInteger )numberOfSectionsInTableView:( UITableView* )tableView
{
    return [_weakWalletManager.keychains[ _activeInteger ] wallets].count;
}

- ( NSInteger )tableView:( UITableView* )tableView numberOfRowsInSection:( NSInteger )section
{
    if( ![_sectionHeaders[ section ] boolValue] )
        return 1;
    
    return [_weakWalletManager.keychains[ _activeInteger ] addressesForWalletAtIndex:section].count + 1;
}

- ( UITableViewCell* )tableView:( UITableView* )tableView cellForRowAtIndexPath:( NSIndexPath* )indexPath
{
    static UITableViewCell* cell = nil;
    
    if ( indexPath.row )
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        cell.textLabel.text = [_weakWalletManager.keychains[ _activeInteger ] addressNameWithIndex:indexPath.row - 1 forWalletAtIndex:indexPath.section];
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"Header"];
        
        cell.textLabel.text = [_weakWalletManager.keychains[ _activeInteger ] walletNameAtIndex:indexPath.section];
    }
    
    return cell;
}

@end
