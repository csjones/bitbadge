//
//  ScanVC.h
//  BitBadge
//
//  Created by Chris on 5/24/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "ZBarSDK.h"

@class WalletManager;

@interface ScanVC : UIViewController < ZBarReaderViewDelegate >
{
    __weak NSOperationQueue *_weakMainQueue;
    
    BOOL _didScanCode;
}

@property ( weak, nonatomic ) IBOutlet ZBarReaderView *weakReaderView;

@property ( weak, nonatomic) WalletManager* walletManager;

@property ( strong, nonatomic ) NSString* challenge;

- ( IBAction )didTapButton:( id )sender;

@end
