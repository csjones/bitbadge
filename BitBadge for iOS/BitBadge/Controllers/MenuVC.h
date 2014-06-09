//
//  MenuVC.h
//  BitBadge
//
//  Created by Chris on 5/24/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "ScanModel.h"

@interface MenuVC : UIViewController < UITableViewDelegate >

@property   ( weak, nonatomic ) IBOutlet    UITableView*    weakTableView;
@property   ( strong, nonatomic )           ScanModel*      scanModel;

- (IBAction)didTapButton:(id)sender;

@end
