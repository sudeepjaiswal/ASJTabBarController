//
//  ASJTabBarController.m
//  ASJTabBarControllerExample
//
//  Created by sudeep on 06/02/16.
//  Copyright © 2016 sudeep. All rights reserved.
//

#import "ASJTabBarController.h"

static NSString *const kViewControllersKey = @"viewControllers";
static NSString *const kSelectedViewControllerKey = @"selectedViewController";

@interface ASJTabBarController ()

@property (strong, nonatomic) UIView *tabIndicator;
@property (readonly, nonatomic) CGFloat tabWidth;
@property (readonly, weak, nonatomic) NSNotificationCenter *notificationCenter;

- (void)setup;
- (void)setupDefaults;
- (void)setupListeners;
- (void)addTabIndicatorToTabBar;
- (void)removeTabIndicatorFromTabBar;
- (void)handleOrientationChange;
- (void)animateTabIndicatorToIndex:(NSUInteger)idx;

@end

@implementation ASJTabBarController

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self setup];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    [self setup];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

#pragma mark - Setup

- (void)setup
{
  [self setupDefaults];
  [self setupListeners];
}

#pragma mark - Defaults

- (void)setupDefaults
{
  _shouldShowIndicator = YES;
  _shouldAnimateIndicator = YES;
  _indicatorAnimationDuration = 0.25f;
  _indicatorThickness = 4.0f;
  
  UIColor *white = [UIColor whiteColor];
  _indicatorColor = white;
  self.view.backgroundColor = white;
  
  // add indicator if view controllers present
  if (_shouldShowIndicator && self.viewControllers.count) {
    [self addTabIndicatorToTabBar];
  }
}

#pragma mark - Listening to events

- (void)setupListeners
{
  // KVO: view controllers
  [self addObserver:self forKeyPath:kViewControllersKey options:NSKeyValueObservingOptionNew context:nil];
  
  // KVO: selected view controller
  [self addObserver:self forKeyPath:kSelectedViewControllerKey options:NSKeyValueObservingOptionNew context:nil];
  
  // NSNotification: orientation
  [self.notificationCenter addObserver:self selector:@selector(appDidChangeStatusBarFrame:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if ([keyPath isEqualToString:kViewControllersKey])
  {
    [self addTabIndicatorToTabBar];
  }
  
  else if ([keyPath isEqualToString:kSelectedViewControllerKey])
  {
    id viewController = change[NSKeyValueChangeNewKey];
    NSInteger idx = [self.viewControllers indexOfObject:viewController];
    [self animateTabIndicatorToIndex:idx];
  }
}

- (void)appDidChangeStatusBarFrame:(NSNotification *)note
{
  [self handleOrientationChange];
}

- (void)dealloc
{
  [self removeObserver:self forKeyPath:kViewControllersKey];
  [self removeObserver:self forKeyPath:kSelectedViewControllerKey];
  [self.notificationCenter removeObserver:self];
}

- (NSNotificationCenter *)notificationCenter
{
  return [NSNotificationCenter defaultCenter];
}

#pragma mark - Set view controllers

- (void)setViewControllers:(NSArray *)viewControllers
{
  [self addTabIndicatorToTabBar];
}

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated
{
  [self addTabIndicatorToTabBar];
}

#pragma mark - Set selected index

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
  [super setSelectedIndex:selectedIndex];
  [self animateTabIndicatorToIndex:selectedIndex];
}

- (void)animateTabIndicatorToIndex:(NSUInteger)idx
{
  CGAffineTransform transform = CGAffineTransformMakeTranslation(self.tabWidth * idx, 0);
  
  if (!_shouldAnimateIndicator) {
    _tabIndicator.transform = transform;
    return;
  }
  
  [UIView animateWithDuration:_indicatorAnimationDuration animations:^{
    _tabIndicator.transform = transform;
  }];
}

#pragma mark - Property setters

- (void)setShouldShowIndicator:(BOOL)shouldShowIndicator
{
  _shouldShowIndicator = shouldShowIndicator;
  if (shouldShowIndicator) {
    [self addTabIndicatorToTabBar];
  }
  else {
    [self removeTabIndicatorFromTabBar];
  }
}

- (void)setIndicatorThickness:(CGFloat)indicatorThickness
{
  _indicatorThickness = indicatorThickness;
  CGRect rect = self.tabIndicator.frame;
  CGSize size = rect.size;
  size.height = indicatorThickness;
  rect.size = size;
  self.tabIndicator.frame = rect;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
  _indicatorColor = indicatorColor;
  self.tabIndicator.backgroundColor = indicatorColor;
}

#pragma mark - Manage tab indicator

- (void)addTabIndicatorToTabBar
{
  [self.tabBar addSubview:self.tabIndicator];
}

- (UIView *)tabIndicator
{
  if (_tabIndicator) {
    return _tabIndicator;
  }
  
  CGRect rect = CGRectMake(0, 0, self.tabWidth, _indicatorThickness);
  _tabIndicator = [[UIView alloc] initWithFrame:rect];
  _tabIndicator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  return _tabIndicator;
}

- (CGFloat)tabWidth
{
  return self.tabBar.bounds.size.width / self.viewControllers.count;
}

- (void)removeTabIndicatorFromTabBar
{
  [self.tabIndicator removeFromSuperview];
}

- (void)handleOrientationChange
{
  CGFloat x = self.tabWidth * [self.viewControllers indexOfObject:self.selectedViewController];
  CGRect rect = CGRectMake(x, 0, self.tabWidth, _indicatorThickness);
  self.tabIndicator.frame = rect;
}

@end
