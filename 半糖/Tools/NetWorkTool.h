//
//  NetWorkTool.h
//  半糖
//
//  Created by Air. on 15/11/26.
//  Copyright © 2015年 Air. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NetworkType) {
    NetworkTypeGetNew,
    NetworkTypeGetMore,
    NetworkTypeDiscoveryGetNew,
    NetworkTypeDiscoveryGetMore,
    NetworkTypeTopicList
};

typedef void (^successBlock)(id responseObject);
typedef void (^failureBlock)(NSError *error);

@interface NetWorkTool : NSObject<NSCopying,NSMutableCopying>


/**
 *  单例
 *
 *  @return 单例
 */
+ (instancetype)defalutTool;

/**
 *  发送GET请求
 *
 *  @param url            请求地址
 *  @param parameters     请求参数
 *  @param networkSuccess 请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters networkSuccess:(successBlock)networkSuccess failure:(failureBlock)failure;

/**
 *  发送POST请求
 *
 *  @param url            请求地址
 *  @param parameters     请求参数
 *  @param networkSuccess 请求成功的回调
 *  @param failure        请求失败的回调
 */
+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters networkSuccess:(successBlock)networkSuccess failure:(failureBlock)failure;


- (void)getDataWithNetworkingType:(NetworkType)type success:(successBlock)successBlock failure:(failureBlock)failureBlock;

- (void)getTopicListDataWithIDS:(NSString *)ids success:(successBlock)successBlock failure:(failureBlock)failureBlock;
@end
