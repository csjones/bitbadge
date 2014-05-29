//
//  NSDictionary+MasterNode.m
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "NSDictionary+MasterNode.h"

@implementation NSDictionary ( MasterNode )

- ( NSArray* )chain
{
    return self[ @"chain" ];
}

- ( NSString* )nodeName
{
    return self[ @"name" ];
}

- ( NSNumber* )encrypted
{
    return self[ @"encrypted" ];
}

- ( NSString* )encryptedSeed
{
    return self[ @"seed" ];
}

- ( NSString* )decryptedSeed:( NSString* )key
{
    return self[ @"seed" ];
}

@end
