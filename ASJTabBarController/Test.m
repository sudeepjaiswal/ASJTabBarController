//
//  Test.m
//  ASJTabBarControllerExample
//
//  Created by ABS_MAC02 on 13/05/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "Test.h"

@interface Test () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) UIView *tabIndicator;
@property (copy, nonatomic) NSArray *viewControllersToShow;
@property (readonly, nonatomic) CGFloat tabWidth;
@property (readonly, weak, nonatomic) NSNotificationCenter *notificationCenter;

- (void)setup;
- (void)setupDefaults;
- (void)setupListeners;
- (void)setupPageViewController;
- (void)addTabIndicatorToTabBar;
- (void)removeTabIndicatorFromTabBar;
- (void)handleOrientationChange;
- (void)animateTabIndicatorToIndex:(NSUInteger)idx;

@end

@implementation Test

@end
