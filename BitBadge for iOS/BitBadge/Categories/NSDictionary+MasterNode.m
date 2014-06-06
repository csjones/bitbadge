//
//  NSDictionary+MasterNode.m
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "NSDictionary+MasterNode.h"

@implementation NSDictionary ( MasterNode )

- ( NSArray* )wallets
{
    return self[ @"info" ][ @"wallets" ];
}

- ( NSDictionary* )info
{
    return self[ @"info" ];
}

- ( NSString* )nodeName
{
    return self[ @"name" ];
}

- ( NSNumber* )encrypted
{
    return self[ @"info" ][ @"encrypted" ];
}

- ( NSString* )seedWithKey:( NSString* )key
{
    if ( [self.encrypted boolValue] )
        return nil;
    
    return self[ @"info" ][ @"seed" ];
}

@end
