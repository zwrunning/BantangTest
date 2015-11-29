//
//  TopicViewCell.h
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Topic;

@interface TopicViewCell : UITableViewCell

@property (nonatomic, strong) Topic *topic;

+ (TopicViewCell *)cellWithTableView:(UITableView *)tableView;
@end
