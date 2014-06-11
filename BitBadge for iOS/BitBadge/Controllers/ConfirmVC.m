//
//  ConfirmVC.m
//  BitBadge
//
//  Created by Chris on 6/9/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "ConfirmVC.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation ConfirmVC

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   UIViewController

- ( void )viewDidAppear:( BOOL )animated
{
    [super viewDidAppear:animated];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   IBActions


- ( IBAction )didPressButton:( id )sender
{
    __weak UIButton* weakButton = sender;
    
    switch ( weakButton.tag )
    {
        default:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 1:
            [_bitIdModel signChallenge];
            break;
    }
}

@end
