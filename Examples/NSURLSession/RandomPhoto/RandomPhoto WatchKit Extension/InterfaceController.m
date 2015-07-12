//
//  InterfaceController.m
//  RandomPhoto WatchKit Extension
//
//  Created by Steve Sparks on 7/12/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceImage *imageView;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *loadingLabel;
@property (nonatomic) BOOL loading;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self getAnImage];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)reloadRequested {
    [self getAnImage];
}

- (void)getAnImage {
    if(_loading)
        return;
    _loading = YES;

    WKInterfaceDevice *dev = [WKInterfaceDevice currentDevice];
    CGSize sz = dev.screenBounds.size;
    [self.loadingLabel setText:@"Loading..."];
    [self.loadingLabel setHidden:NO];
    [UIImage randomImageOfSize:sz completion:^(UIImage *img, NSError *error){
        if(error) {
            [self.loadingLabel setText:error.localizedDescription];
        } else {
            [self.imageView setImage:img];
            [self.loadingLabel setHidden:YES];
        }
        _loading = NO;
    }];
}
@end



