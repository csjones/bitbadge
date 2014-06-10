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

- ( void )viewWillAppear:( BOOL )animated
{
    [super viewWillAppear:animated];
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
}

@end
