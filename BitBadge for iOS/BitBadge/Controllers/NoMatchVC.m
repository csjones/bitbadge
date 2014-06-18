//
//  NoMatchVC.m
//  BitBadge
//
//  Created by Chris on 6/15/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "MenuVC.h"
#import "NoMatchVC.h"
#import "WalletManager.h"
#import "NSDictionary+MasterNode.h"
#import "WalletManager+HelperMethods.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation NoMatchVC

- ( void )viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup after loading the view.
    _hostnameLabel.text = [[[NSURL alloc] initWithString:self.bitIdModel.challenge] host];
    
    __weak NSDictionary* keychain = self.walletManager.currentKeychain;
    
    NSUInteger address = [keychain addressesForWalletAtIndex:0].count;
    
    _addressLabel.text = [keychain publicKeyAtIndex:address withWalletIndex:0];
    
    _walletLabel.text = [keychain walletNameAtIndex:0];
    
    [self.walletManager addAddressWithString:_hostnameLabel.text forWallet:0];
    
    __weak MenuVC* weakMenu = ( MenuVC* )self.slidingViewController.underLeftViewController;
    
    [weakMenu.weakMenuTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
