//
//  NSDictionary+MasterNode.h
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@interface NSDictionary ( MasterNode )

- ( NSArray* )wallets;

- ( NSDictionary* )info;

- ( NSString* )nodeName;

- ( NSNumber* )encrypted;

- ( NSString* )seedWithKey:( NSString* )key;

@end
