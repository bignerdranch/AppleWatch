//
//  UIImage+Random.m
//  RandomPhoto
//
//  Created by Steve Sparks on 7/12/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

#import "UIImage+Random.h"

@implementation UIImage (Random)

+ (void)randomImageOfSize:(CGSize)sz completion:(void(^)(UIImage *, NSError *))completion {
    static NSURLSession *imageSession = nil;
    if(!imageSession) {
        imageSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    }

    NSString *urlStr = [NSString stringWithFormat:@"http://lorempixel.com/%.f/%.f", sz.width, sz.height];
    NSLog(@"Going %@", urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];

    NSURLSessionDataTask *task = [imageSession dataTaskWithURL:url completionHandler:^(NSData *d, NSURLResponse *r, NSError *error){
        NSLog(@"Handler called");
        UIImage *img = [UIImage imageWithData:d];
        if(img) {
            completion(img, nil);
        } else if(error) {
            completion(nil, error);
        } else {
            completion([UIImage imageNamed:@"lorempixel"], [NSError errorWithDomain:@"UIImageError" code:-1 userInfo:@{ NSLocalizedDescriptionKey : (d != nil?@"No Image":@"No Data") }]);
            NSLog(@"Got bupkis.");
        }
    }];
    [task resume];
}

@end
