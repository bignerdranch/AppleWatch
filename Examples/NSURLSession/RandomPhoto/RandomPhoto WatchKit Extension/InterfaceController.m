//
//  InterfaceController.m
//  RandomPhoto WatchKit Extension
//
//  Created by Steve Sparks on 7/12/15.
//  Copyright (c) 2015 Big Nerd Ranch
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

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



