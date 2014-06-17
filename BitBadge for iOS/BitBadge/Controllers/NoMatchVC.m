//
//  NoMatchVC.m
//  BitBadge
//
//  Created by Chris on 6/15/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "NoMatchVC.h"
#import "WalletManager.h"
#import "NSDictionary+MasterNode.h"

@implementation NoMatchVC

- ( void )viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup after loading the view.
    _hostnameLabel.text = [[[NSURL alloc] initWithString:self.bitIdModel.challenge] host];
    
    [self.walletManager addAddressWithString:_hostnameLabel.text forWallet:0];
    
    __weak NSDictionary* keychain = self.walletManager.keychains[ self.walletManager.activeKeychain.integerValue ];
    
    NSUInteger address = [keychain addressesForWalletAtIndex:0].count - 1;
    
    _addressLabel.text = [keychain publicKeyAtIndex:address withWalletIndex:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
