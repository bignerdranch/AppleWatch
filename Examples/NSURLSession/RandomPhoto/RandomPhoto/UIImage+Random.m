//
//  UIImage+Random.m
//  RandomPhoto
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
