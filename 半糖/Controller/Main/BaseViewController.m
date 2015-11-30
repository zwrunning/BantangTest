//
//  BaseViewController.m
//  半糖
//
//  Created by Air. on 15/11/30.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

/**
 *  初始化TablView
 */
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView addSubview:tableView];
    
    UIView *pineView = [[UIView alloc] init];
    [bgView addSubview:pineView];
    pineView.backgroundColor = kRGB(232, 86, 93);
    self.statusView = pineView;
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [pineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).with.offset(0);
        make.leadingMargin.equalTo(bgView);
        make.rightMargin.equalTo(bgView);
        make.height.mas_equalTo(@20);
    }];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(pineView.mas_bottom).with.offset(-20);
        make.left.equalTo(bgView.mas_left).with.offset(0);
        make.right.equalTo(bgView.mas_right).with.offset(0);
        make.bottom.equalTo(bgView.mas_bottom).with.offset(0);
    }];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIView *navBar = self.navigationController.navigationBar;
    CGRect frame = navBar.frame;
    CGFloat offestY = scrollView.contentOffset.y;
    BOOL isDowning = self.yy < offestY;
    BOOL isTop = offestY < -40;
    self.yy = offestY;
    BOOL isNavBarHidden = frame.origin.y < -43;
    BOOL isBottom = scrollView.contentSize.height - offestY < scrollView.size.height;
    if (isDowning && !isTop && !isNavBarHidden) {// 向下滑
        frame.origin.y = -44;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusView.mas_bottom).with.offset(0);
        }];
    }
    if ((!isDowning || isTop) && isNavBarHidden && !isBottom) {// 向上滑和最顶时显示
        frame.origin.y = 20;
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.statusView.mas_bottom).with.offset(-20);
        }];
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.navigationController.navigationBar.frame = frame;
    }];
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseID" forIndexPath:indexPath];
//    return cell;
//}
@end
