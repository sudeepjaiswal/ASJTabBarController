//
//  Test.h
//  ASJTabBarControllerExample
//
//  Created by ABS_MAC02 on 13/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

@import UIKit;

@interface Test : UIViewController

@property (assign, nonatomic) IBInspectable BOOL shouldShowIndicator;
@property (assign, nonatomic) IBInspectable BOOL shouldAnimateIndicator;
@property (assign, nonatomic) IBInspectable CGFloat indicatorAnimationDuration;
@property (assign, nonatomic) IBInspectable CGFloat indicatorThickness;
@property (strong, nonatomic) IBInspectable UIColor *indicatorColor;

@end
