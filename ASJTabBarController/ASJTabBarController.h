//
//  ASJTabBarController.h
//  ASJTabBarControllerExample
//
//  Created by sudeep on 06/02/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASJTabBarController : UITabBarController

@property (assign, nonatomic) IBInspectable BOOL shouldShowIndicator;
@property (assign, nonatomic) IBInspectable BOOL shouldAnimateIndicator;
@property (assign, nonatomic) IBInspectable CGFloat indicatorAnimationDuration;
@property (assign, nonatomic) IBInspectable CGFloat indicatorThickness;
@property (strong, nonatomic) IBInspectable UIColor *indicatorColor;

@end
