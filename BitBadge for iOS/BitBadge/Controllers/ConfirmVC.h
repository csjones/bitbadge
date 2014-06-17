//
//  ConfirmVC.h
//  BitBadge
//
//  Created by Chris on 6/9/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "BitID.h"

@class WalletManager;

@interface ConfirmVC : UIViewController

@property   ( nonatomic, strong )   BitID* bitIdModel;

@property   ( nonatomic, weak )     WalletManager* walletManager;

@end
