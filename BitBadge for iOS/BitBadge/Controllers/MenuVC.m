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

- ( void )viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup after loading the view.
    WalletManager* walletManager = [WalletManager sharedInstance];
    
    _scanModel = [[ScanModel alloc] initWithActiveKeychain:walletManager.activeKeychain.integerValue];
    
    _weakTableView.dataSource = _scanModel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapButton:(id)sender
{
    // This undoes the Zoom Transition's scale because it affects the other transitions.
    // You normally wouldn't need to do anything like this, but we're changing transitions
    // dynamically so everything needs to start in a consistent state.
//    self.slidingViewController.topViewController.view.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    self.slidingViewController.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Scan"];
    
    [self.slidingViewController resetTopViewAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
