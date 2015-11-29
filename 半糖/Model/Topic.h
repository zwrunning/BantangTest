//
//  Topic.h
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject

/** id */
@property (nonatomic, assign)NSInteger ID;

/** 标题 */
@property (nonatomic, copy)NSString *title;

/** 图片url */
@property (nonatomic, copy)NSString *pic;

/** 点赞数 */
@property (nonatomic, assign)NSInteger likes;

/** 更新时间 */
@property (nonatomic, assign)NSInteger update_time;

/** 类型 */
@property (nonatomic, copy)NSString *type;

/** 额外topic的顺序 */
@property (nonatomic, assign)NSInteger index;

/** 额外的图片地址 */
@property (nonatomic, weak)NSString *photo;

/** 额外的活动网址 */
@property (nonatomic, copy)NSString *extend;
@end
