//
//  BitID.m
//  BitBadge
//
//  Created by Chris on 6/9/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "BitID.h"
#import "Base64.h"
#import "WalletManager.h"
#import "NSDictionary+MasterNode.h"

@implementation BitID

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSObject

- ( id )initWithChallenge:( NSString* )challenge
{
    NSString* baseURL = [[NSString alloc] initWithFormat:@"http://%@", [[[NSURL alloc] initWithString:challenge] host] ];
    
    NSLog(@"baseURL %@", baseURL);
    
    if ( self = [super initWithBaseURL: [[NSURL alloc] initWithString:baseURL] ] )
    {
        _challenge = challenge;
        
        _walletManager = [WalletManager sharedInstance];
        
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        self.responseSerializer.acceptableContentTypes = [[NSSet alloc] initWithArray:@[ @"application/json" ]];
    }
    
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

- ( void )signChallenge
{
    NSURL* url = [[NSURL alloc] initWithString:_challenge];
    
    NSLog(@"url.scheme %@", url.scheme);
    
    NSLog(@"url.host %@", url.host);
    
    NSLog(@"url.path %@", url.path);
    
    NSData* signature = [self.walletManager.keychains[ 0 ] sign:_challenge addressAtIndex:0 withWalletIndex:0];
    
    NSDictionary* params = [[NSDictionary alloc] initWithObjectsAndKeys: _challenge, @"uri",
                                                                        [self.walletManager.keychains[ 0 ] publicKeyAtIndex:0 withWalletIndex:0], @"address",
                                                                        [signature base64EncodedString], @"signature", nil];
    
    NSLog(@"params %@", params);
    
    [self POST:[[NSString alloc] initWithFormat:@"%@", url.path]
    parameters:params
       success:^(AFHTTPRequestOperation *operation, id responseObject) {
           NSLog(@"success");
       }
       failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           NSLog(@"failure %@", error);
       }];
}

@end
