//
//  HomeViewController.m
//  半糖
//
//  Created by Air. on 15/11/28.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "HomeViewController.h"
#import "NetWorkTool.h"
#import "Banner.h"
#import "ZWBannerView.h"
#import "Topic.h"
#import "TopicViewCell.h"
#import "Entry.h"
#import "EntryViewCell.h"
#import "TopicListViewController.h"
#import "TopicWebViewController.h"
#include "NSString+Extension.h"


static NSString *const EntryID = @"entry";
static NSString *const ID = @"cell";


@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ZWBannerViewDelegate>

/** 轮播图 */
@property (nonatomic, strong) ZWBannerView *airBanner;
/** 数据数组 */
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, strong) NSArray *entrys;
/** EntryView */
@property (nonatomic, strong) UICollectionView *entryView;
@end

@implementation HomeViewController

- (NSMutableArray *)topics {
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    
    [self loadData];
    [self setupHeader];
}

/**
 *  加载数据
 */
- (void)loadData {
    NSDictionary *parameters = @{
                                 @"app_versions" : @"4.2.2",
                                 @"channel_name" : @"appStore",
                                 @"client_id" : @"bt_app_ios",
                                 @"client_secret" : @"9c1e6634ce1c5098e056628cd66a17a5",
                                 @"pagesize" : @"20",
                                 @"v" : @"7",
                                 @"page" : @(0)
                                 };
    
    [NetWorkTool get:@"http://open3.bantangapp.com/recommend/index" parameters:parameters networkSuccess:^(id responseObject) {
        self.banners = [Banner mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"banner"]];
        self.entrys = [Entry mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"entry_list"]];
        if (self.topics.count >= 20) {
            NSArray *newData = [Topic mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topic"]];
            for (NSInteger i = 0; i < newData.count; i++) {
                self.topics[i] = newData[i];
            }
        } else {
            self.topics = [Topic mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"topic"]];
        }
        // 插入额外的活动图片
        NSArray *extDatas = [Topic mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"firstpage_element"]];
        for (Topic *extData in extDatas) {
            Topic *topic = self.topics[(extData.index - 1)];
            if (topic.index == 0) {
                [self.topics insertObject:extData atIndex:(extData.index - 1)];
            }
        }
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"--------%@",error);
    }];
}


/**
 *  头部视图
 */
- (void)setupHeader {
    
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(0, 0, kWidth, kWidth * 0.5 + 120);
    self.airBanner = [ZWBannerView cycleScrollViewWithFrame:CGRectMake(0, 0, kWidth, kWidth * 0.5) imageURLStringsGroup:nil];
    self.airBanner.delegate = self;
    [bgView addSubview:self.airBanner];
   
    // entryView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.entryView= [[UICollectionView alloc] initWithFrame:CGRectMake(0, kWidth * 0.5, kWidth, 120) collectionViewLayout:flowLayout];
    self.entryView.backgroundColor = [UIColor whiteColor];
    [self.entryView registerClass:[EntryViewCell class] forCellWithReuseIdentifier:EntryID];
    flowLayout.itemSize = CGSizeMake(100, 100);
    self.entryView.dataSource = self;
    self.entryView.delegate = self;
    self.entryView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.entryView.showsHorizontalScrollIndicator = NO;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [bgView addSubview:self.entryView];
    
    self.tableView.tableHeaderView = bgView;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.entrys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EntryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EntryID forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[self.entrys[indexPath.item] pic1]]];
    return cell;
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

#pragma mark - tableView dataSource delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.topics.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    TopicViewCell *cell = [TopicViewCell cellWithTableView:tableView];
    cell.topic = self.topics[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)setBanners:(NSArray *)banners {
    _banners = banners;
    NSMutableArray *allPicURLStrings = [NSMutableArray array];
    for (Banner *banner in self.banners) {
        [allPicURLStrings addObject:banner.photo];
    }
    self.airBanner.imageURLStringsGroup = allPicURLStrings;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)setEntrys:(NSArray *)entrys {
    _entrys = entrys;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.entryView reloadData];
    });
}

#pragma mark - bannerdelegate
- (void)cycleScrollView:(ZWBannerView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    Banner *banner = self.banners[index];
    if ([banner.type isEqualToString:@"topic_list"]) {
        NSString *ids = [banner.extend extendNumber];
        TopicListViewController *topicListVC = [TopicListViewController TopicList:ids andTitle:banner.title];
        [self.navigationController pushViewController:topicListVC animated:YES];
        return;
    }
    if ([banner.type isEqualToString:@"webview"]) {
        TopicWebViewController *wv = [[TopicWebViewController alloc] init];
        [self.navigationController pushViewController:wv animated:YES];
        return;
    }
}

@end
