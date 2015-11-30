//
//  BaseViewController.h
//  半糖
//
//  Created by Air. on 15/11/30.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
/** TableView */
@property (nonatomic, strong) UITableView *tableView;
/** 状态栏颜色 */
@property (nonatomic, weak) UIView *statusView;
/** 记录上一次调用时的Y值 */
@property (nonatomic, assign)CGFloat yy;
@end
