//
//  MenuVC.h
//  BitBadge
//
//  Created by Chris on 5/24/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "MenuTableModel.h"

@interface MenuVC : UIViewController < UITableViewDelegate >

@property   ( weak, nonatomic ) IBOutlet    UITableView*    weakMenuTableView;
@property   ( strong, nonatomic )           MenuTableModel* menuTableModel;

- (IBAction)didTapButton:(id)sender;

@end
