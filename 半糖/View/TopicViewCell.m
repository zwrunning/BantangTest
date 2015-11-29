//
//  TopicViewCell.m
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "TopicViewCell.h"
#import "Topic.h"

@interface TopicViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *logoImg;

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;

@property (weak, nonatomic) IBOutlet UIImageView *topicImg;

@end
@implementation TopicViewCell

- (void)awakeFromNib {
//    self.logoImg.layer.cornerRadius = 5;
//    self.logoImg.layer.masksToBounds = YES;
}

- (void)setTopicImg:(UIImageView *)topicImg {
    _topicImg = topicImg;
    
    _topicImg.layer.cornerRadius = 4;
    _topicImg.layer.masksToBounds = YES;
}

+ (TopicViewCell *)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"topic";
    TopicViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"TopicViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setTopic:(Topic *)topic {
    _topic = topic;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", topic.likes];
    [self.topicImg sd_setImageWithURL:[NSURL URLWithString:topic.pic]];
    if (topic.index > 0) {
        self.logoImg.hidden = YES;
        self.bgView.hidden = YES;
    } else {
        self.logoImg.hidden = NO;
        self.bgView.hidden = NO;
    }
}

@end
