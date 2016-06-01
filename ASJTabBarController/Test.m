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

- (void)setupPageViewController
{
  if (_pageViewController) {
    return;
  }
  
  _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
  
  _pageViewController.dataSource = self;
  _pageViewController.delegate = self;
  _pageViewController.view.frame = self.view.bounds;
  _pageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  
  [self addChildViewController:_pageViewController];
  [self.view addSubview:_pageViewController.view];
  [_pageViewController didMoveToParentViewController:self];
}

@end
