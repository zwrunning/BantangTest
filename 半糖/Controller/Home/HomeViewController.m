//
//  HomeViewController.m
//  半糖
//
//  Created by Air. on 15/11/20.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "HomeViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
}

///  初始化导航栏
- (void)setupNav {
    // 标题
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nar_logo"]];
    titleView.size = titleView.image.size;
    self.navigationItem.titleView = titleView;
    
    // 左边按钮
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:[UIImage imageNamed:@"subscribe_icon"] forState:UIControlStateNormal];
//    leftButton.frame = CGRectMake(0, 0, 40, 40);
    [leftButton sizeToFit];
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 右边按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"sign_bar_icon"] forState:UIControlStateNormal];
    rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -30);
    [rightButton sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.textLabel.text = @"半糖";
    }
    return cell;
}

//#pragma mark - ScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (scrollView.contentOffset.y > -64) {
//        self.navigationController.hidesBarsOnSwipe = YES;
//    }else{
//        self.navigationController.hidesBarsOnSwipe = NO;
//    }
//    NSLog(@"%f",scrollView.contentOffset.y);
//}
@end
