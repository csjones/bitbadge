//
//  NSDictionary+MasterNode.h
//  BitBadge
//
//  Created by Chris on 5/28/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

@interface NSDictionary ( MasterNode )

- ( NSArray* )chain;

- ( NSString* )nodeName;

- ( NSNumber* )encrypted;

- ( NSString* )encryptedSeed;

- ( NSString* )decryptedSeed:( NSString* )key;

@end
