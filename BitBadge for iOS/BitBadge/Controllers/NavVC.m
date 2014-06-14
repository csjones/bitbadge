//
//  NavVC.m
//  BitBadge
//
//  Created by Chris on 6/14/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "NavVC.h"

@implementation NavVC

- ( id )initWithCoder:( NSCoder* )aDecoder
{
    if ( self = [super initWithCoder:aDecoder] )
    {
        
    }
    
    return self;
}

- ( void )viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Do any additional setup after loading the view.
    self.view.layer.shadowRadius = 10.f;
    self.view.layer.shadowOpacity = .75f;
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
}

@end
