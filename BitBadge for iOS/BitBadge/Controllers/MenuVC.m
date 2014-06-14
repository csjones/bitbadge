//
//  MenuVC.m
//  BitBadge
//
//  Created by Chris on 5/24/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "MenuVC.h"
#import "WalletManager.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation MenuVC

- ( id )initWithCoder:( NSCoder* )aDecoder
{
    if( self = [super initWithCoder:aDecoder] )
    {
        
    }
    
    return self;
}

- ( void )viewWillAppear:( BOOL )animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup after loading the view.
    if( !_menuTableModel )
    {
        WalletManager* walletManager = [WalletManager sharedInstance];
        
        _menuTableModel = [[MenuTableModel alloc] initWithActiveKeychain:walletManager.activeKeychain.integerValue];
        
        _weakMenuTableView.dataSource = _menuTableModel;
        
        [_weakMenuTableView reloadData];
    }
}

- ( IBAction )didTapButton:( id )sender
{
    // This undoes the Zoom Transition's scale because it affects the other transitions.
    // You normally wouldn't need to do anything like this, but we're changing transitions
    // dynamically so everything needs to start in a consistent state.
//    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Scan"];
    
    [self.slidingViewController resetTopViewAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   UITableViewDelegate

- ( void )tableView:( UITableView* )tableView didSelectRowAtIndexPath:( NSIndexPath* )indexPath
{
    if ( indexPath.row )
    {
        
    }
    else
    {
        NSMutableArray* newHeaders = [_menuTableModel.sectionHeaders mutableCopy];
        
        newHeaders[ indexPath.section ] = [[NSNumber alloc] initWithBool:![newHeaders[ indexPath.section ] boolValue]];
        
        _menuTableModel.sectionHeaders = [[NSArray alloc] initWithArray:newHeaders];
        
        [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
}

@end
