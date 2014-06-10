//
//  BitID.h
//  BitBadge
//
//  Created by Chris on 6/9/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface BitID : AFHTTPRequestOperationManager

- ( id )initWithChallenge:( NSString* )challenge;

@end
