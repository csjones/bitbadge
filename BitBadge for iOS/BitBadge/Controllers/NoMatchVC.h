//
//  NoMatchVC.h
//  BitBadge
//
//  Created by Chris on 6/15/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "ConfirmVC.h"

@interface NoMatchVC : ConfirmVC

@property ( weak, nonatomic ) IBOutlet UILabel *hostnameLabel;
@property ( weak, nonatomic ) IBOutlet UILabel *addressLabel;
@property ( weak, nonatomic ) IBOutlet UILabel *walletLabel;

@end
