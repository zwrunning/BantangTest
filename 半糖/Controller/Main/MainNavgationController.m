//
//  MainNavgationController.m
//  半糖
//
//  Created by Air. on 15/11/20.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "MainNavgationController.h"

@interface MainNavgationController ()

@end

@implementation MainNavgationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 导航栏属性
    [self setupNav];
}

- (void)setupNav{
    
    // 状态栏颜色
    UIView *statusBar = [UIView new];
    statusBar.backgroundColor = [UIColor blueColor];
    statusBar.frame = CGRectMake(0, 40, kWidth, 20);
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:kRGB(231, 56, 61)];
    
    [navBar addSubview:statusBar];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
