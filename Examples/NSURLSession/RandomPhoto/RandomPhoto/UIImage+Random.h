//
//  UIImage+Random.h
//  RandomPhoto
//
//  Created by Steve Sparks on 7/12/15.
//  Copyright © 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Random) 

+ (void)randomImageOfSize:(CGSize)sz completion:(void(^)(UIImage *, NSError *error))completion;

@end
