//
//  GiFHUD.h
//  GiFHUD
//
//  Created by 王森 http://www.51zan.cc on 25/11/15.
//  Copyright (c) 2015-11-25 王森. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GiFHUD : UIView

+ (void)show;
+ (void)showWithOverlay;

+ (void)dismiss;

+ (void)setGifWithImages:(NSArray *)images;
+ (void)setGifWithImageName:(NSString *)imageName;
+ (void)setGifWithURL:(NSURL *)gifUrl;

+ (void)setGifWithMBProgress:(NSString *)string toView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;


@end
