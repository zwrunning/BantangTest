//
//  MainTabBarController.m
//  半糖
//
//  Created by Air. on 15/11/20.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"
#import "SearchViewController.h"
#import "MainTabBar.h"
#import "MainNavgationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加控制器
    [self addControllers];
    // 替换系统tabBar
    MainTabBar *tabBar = [[MainTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

/**
 *  添加控制器
 */
- (void)addControllers{
    // 首页
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildViewController:home title:@"首页" image:@"tab_首页" selectedImage:@"tab_首页_pressed"];
    // 发现
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    [self addChildViewController:discover title:@"发现" image:@"tab_发现" selectedImage:@"tab_发现_pressed"];
    // 搜索
    SearchViewController *search = [[SearchViewController alloc] init];
    [self addChildViewController:search title:@"搜索" image:@"tab_搜索" selectedImage:@"tab_搜索_pressed"];
    // 个人
    MeViewController *me = [[MeViewController alloc] init];
    [self addChildViewController:me title:@"我" image:@"tab_我" selectedImage:@"tab_我_pressed"];
}

/**
 *  初始化自控制器
 */
- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 标题
    childController.tabBarItem.title = title;
    // 普通状态图片
    childController.tabBarItem.image = [UIImage imageNamed:image];
    // 选中状态图片
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
//    231/56/61
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = kRGB(231, 56, 61);
    [childController.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateSelected];

    
    MainNavgationController *nav = [[MainNavgationController alloc] initWithRootViewController:childController];
    
    [self addChildViewController:nav];
}
@end
