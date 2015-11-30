//
//  TopicListViewController.m
//  半糖
//
//  Created by Air. on 15/11/30.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "TopicListViewController.h"
#import "TopicViewCell.h"
#import "NetWorkTool.h"
#import "Topic.h"

//static NSString *const ID = @"topic";


@interface TopicListViewController ()

@property (nonatomic, copy) NSString *ids;
@property (nonatomic, strong) NSArray *topics;
@end

@implementation TopicListViewController

+ (instancetype)TopicList:(NSString *)topics andTitle:(NSString *)title {
    TopicListViewController *topicVC = [[TopicListViewController alloc] init];
    topicVC.navigationItem.title = title;
    topicVC.ids = topics;
    return topicVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[TopicViewCell class] forCellReuseIdentifier:ID];
    [self loadData];
}

- (void)loadData {
    NSDictionary *parameters = @{
                                 @"app_versions" : @"4.2.2",
                                 @"channel_name" : @"appStore",
                                 @"client_id" : @"bt_app_ios",
                                 @"client_secret" : @"9c1e6634ce1c5098e056628cd66a17a5",
                                 @"pagesize" : @"20",
                                 @"v" : @"7",
//                                 @"page" : @(0)
                                 @"ids" : self.ids
                                 };
    
    [NetWorkTool get:@"http://open3.bantangapp.com/topic/list" parameters:parameters networkSuccess:^(id responseObject) {
        self.topics = [Topic mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topic"]];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"--------%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopicViewCell *cell = [TopicViewCell cellWithTableView:tableView];
    cell.topic = self.topics[indexPath.row];
    return cell;
}
@end
