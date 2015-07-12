
//
//  ViewController.m
//  RandomPhoto
//
//  Created by Steve Sparks on 7/12/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Random.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *anotherButton;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self getAnImage];
}

- (IBAction)anotherButtonTapped:(id)sender {
    [self getAnImage];
}


- (void)getAnImage {
    [self.activityIndicator startAnimating];
    CGSize sz = self.view.frame.size;
    [UIImage randomImageOfSize:sz completion:^(UIImage *img, NSError *error){
        self.imageView.image = img;
        [self.activityIndicator stopAnimating];
    }];
}
@end
