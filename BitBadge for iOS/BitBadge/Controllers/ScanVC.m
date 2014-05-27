//
//  ScanVC.m
//  BitBadge
//
//  Created by Chris on 5/24/14.
//  Copyright (c) 2014 GigaBitcoin, LLC. All rights reserved.
//

#import "ScanVC.h"
#import "ZBarImage.h"
#import "ZBarImageScanner.h"
#import "UIViewController+ECSlidingViewController.h"

@implementation ScanVC

- ( id )initWithCoder:( NSCoder* )aDecoder
{
    if ( self = [super initWithCoder:aDecoder] )
    {
        if ( !_weakReaderView )
        {
            _weakMainQueue = [NSOperationQueue mainQueue];
            
            [_weakMainQueue addOperationWithBlock:^{
                ZBarImageScanner *scanner = [[ZBarImageScanner alloc] init];
                
                [scanner setSymbology:0
                               config:ZBAR_CFG_ENABLE
                                   to:0];
                
                [scanner setSymbology:ZBAR_QRCODE
                               config:ZBAR_CFG_ENABLE
                                   to:1];
                
                [scanner setSymbology:ZBAR_QRCODE
                               config:ZBAR_CFG_MIN_LEN
                                   to:0];
                
                [scanner setSymbology:ZBAR_QRCODE
                               config:ZBAR_CFG_MAX_LEN
                                   to:0];
                
                [scanner setSymbology:ZBAR_QRCODE
                               config:ZBAR_CFG_POSITION
                                   to:0];
                
                scanner.enableCache = YES;
                
                ZBarReaderView *readerView = [[ZBarReaderView alloc] initWithImageScanner:scanner];
                
                readerView.backgroundColor = [UIColor redColor];
                readerView.trackingColor = [UIColor clearColor];
                readerView.torchMode = AVCaptureTorchModeOff;
                readerView.layer.cornerRadius = 9.f;
                readerView.frame = self.view.frame;
                readerView.readerDelegate = self;
                readerView.allowsPinchZoom = NO;
                readerView.tracksSymbols = NO;
                readerView.alpha = .0f;
                
                [readerView start];
                
                _weakReaderView = readerView;
                
                [self.view insertSubview:readerView atIndex:0];
                
                [UIView animateWithDuration:.4
                                      delay:.5
                                    options:0
                                 animations:^(void){
                                     _weakReaderView.alpha = 1.f;
                                 }
                                 completion:^(BOOL finished){ }];
            }];
        }
    }

    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   ZBarReaderViewDelegate

- ( IBAction )didTapButton:( id )sender
{
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark    -   ZBarReaderViewDelegate

- ( void )readerView:( ZBarReaderView* )readerView didReadSymbols:( ZBarSymbolSet* )symbols fromImage:( UIImage* )image
{
//    if( !_didScanCode )
//    {
//        _didScanCode = TRUE;
//        
//        NSString    *address = @"";
//        
//        for(ZBarSymbol *symbol in symbols)
//            address = symbol.data;
//        
//        ScanOptionsVC *scanOptionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"Options"];
//        
//        scanOptionsVC.scannedAddress = address;
//        
//        if (![self.slidingViewController.underRightViewController isKindOfClass:[ScanOptionsVC class]])
//            self.slidingViewController.underRightViewController = scanOptionsVC;
//        
//        [self.slidingViewController anchorTopViewTo:ECLeft];
//    }
}

@end
