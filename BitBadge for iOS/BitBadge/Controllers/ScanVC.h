//
//  ScanVC.h
//  BitBadge
//
//  Created by Chris on 5/24/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "ZBarSDK.h"

@interface ScanVC : UIViewController < ZBarReaderViewDelegate >
{
    __weak NSOperationQueue *_weakMainQueue;
}

@property ( weak, nonatomic ) IBOutlet ZBarReaderView *weakReaderView;

- ( IBAction )didTapButton:( id )sender;

@end
