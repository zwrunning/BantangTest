//
//  Banner.h
//  半糖
//
//  Created by Air. on 15/11/28.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Banner : NSObject

/** id */
@property (nonatomic, assign) NSInteger ID;

/** title */
@property (nonatomic, copy) NSString *title;

/** typeString */
@property (nonatomic, copy) NSString *type;

/** 图片链接 */
@property (nonatomic, copy) NSString *photo;

/** 活动链接 */
@property (nonatomic, copy) NSString *extend;

@end
