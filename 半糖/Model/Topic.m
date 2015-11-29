//
//  Topic.m
//  半糖
//
//  Created by Air. on 15/11/29.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "Topic.h"

@implementation Topic

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (void)setPhoto:(NSString *)photo {
    self.pic = photo;
}

- (NSString *)photo {
    return self.pic;
}
@end
