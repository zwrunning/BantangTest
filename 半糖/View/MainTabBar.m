//
//  MainTabBar.m
//  半糖
//
//  Created by Air. on 15/11/20.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "MainTabBar.h"

@interface MainTabBar()
@property (nonatomic, strong) UIButton *plusButton;
@end
@implementation MainTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tab_bar_bg"];
        // 添加加号按钮
        _plusButton = [[UIButton alloc] init];
        [_plusButton setImage:[UIImage imageNamed:@"tab_publish_add"] forState:UIControlStateNormal];
        [_plusButton setImage:[UIImage imageNamed:@"tab_publish_add_pressed"] forState:UIControlStateHighlighted];
        [_plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_plusButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 加号按钮位置
    [_plusButton sizeToFit];
    _plusButton.centerX = self.width * 0.5;
    _plusButton.centerY = self.height * 0.5;
    
    // 设置其他tabBarButton尺寸
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    NSInteger count = 5;
    for (NSInteger i = 0; i < count; i++) {
        UIView *child = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            child.width = tabBarButtonW;
            child.x = tabBarButtonIndex * tabBarButtonW;
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}
#pragma mark - plusClick
- (void)plusClick{
    
}
@end
