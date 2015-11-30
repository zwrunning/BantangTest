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

+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = kRGB(228, 57, 65);
    navBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //清空interactivePopGestureRecognizer的delegate可以恢复因替换导航条的back按钮失去系统默认手势
    self.interactivePopGestureRecognizer.delegate = nil;
}

- (void)setupLeftBtnWithVC:(UIViewController *)vc {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"public_back_btn"] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    vc.navigationItem.leftBarButtonItem = leftBarBtn;
}

- (void)back {
    if (self.childViewControllers.count > 1) {
        [self popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        self.tabBarController.tabBar.hidden = YES;
        [self setupLeftBtnWithVC:viewController];
    } else {
        self.tabBarController.tabBar.hidden = NO;
    }
    [super pushViewController:viewController animated:YES];
}
@end
