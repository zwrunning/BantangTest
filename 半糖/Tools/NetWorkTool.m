//
//  NetWorkTool.m
//  半糖
//
//  Created by Air. on 15/11/26.
//  Copyright © 2015年 Air. All rights reserved.
//

#import "NetWorkTool.h"

NSString *const DiscoveryURL = @"http://open3.bantangapp.com/product/list";
NSString *const IndexURL = @"http://open3.bantangapp.com/recommend/index";
NSString *const TopicListURL = @"http://open3.bantangapp.com/topic/list";
NSString *const SubjectURL = @"http://open3.bantangapp.com/topic/info";

static id _instace;
@interface NetWorkTool()

/** 首页的page */
@property (nonatomic, assign) NSInteger indexPage;
/** 发现的page */
@property (nonatomic, assign) NSInteger discoverPage;
/** 参数 */
@property (nonatomic, strong) NSMutableDictionary *parameters;
@end

@implementation NetWorkTool

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

+ (instancetype)defalutTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instace;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instace;
}

- (NSMutableDictionary *)paramters {
    if (!_parameters) {
        NSDictionary *dict = @{
                               @"app_versions" : @"4.2.2",
                               @"channel_name" : @"appStore",
                               @"client_id" : @"bt_app_ios",
                               @"client_secret" : @"9c1e6634ce1c5098e056628cd66a17a5",
                               @"pagesize" : @"20",
                               @"v" : @"7"
                               };
        _parameters = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    return _parameters;
}

- (NSArray *)requestWithType:(NetworkType)type {
    NSMutableDictionary *parameters = [self.parameters mutableCopy];
    switch (type) {
        case NetworkTypeGetNew:
            parameters[@"page"] = @(0);
            return @[IndexURL, self.paramters];
        case NetworkTypeGetMore:
            ++self.indexPage;
            parameters[@"page"] = @(self.indexPage);
            return @[IndexURL, self.parameters];
        case NetworkTypeDiscoveryGetNew:
            parameters[@"page"] = @(0);
            return @[DiscoveryURL, self.parameters];
        case NetworkTypeDiscoveryGetMore:
            ++self.discoverPage;
            parameters[@"page"] = @(self.discoverPage);
            return @[DiscoveryURL, self.parameters];
        case NetworkTypeTopicList:
            return @[TopicListURL, self.parameters];
        default:
            NSLog(@"%@", @"输入错误参数");
            return nil;
    }
}
+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters networkSuccess:(successBlock)networkSuccess failure:(failureBlock)failure {
    
    // 创建AFN
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 请求方法
    [manager GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (networkSuccess) {
            networkSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)post:(NSString *)url parameters:(NSDictionary *)parameters networkSuccess:(successBlock)networkSuccess failure:(failureBlock)failure {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (networkSuccess) {
            networkSuccess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


- (void)getDataWithNetworkingType:(NetworkType)type success:(void(^)(id respone))successBlock failure:(void(^)(NSError *error))failureBlock {
    NSArray *request = [self requestWithType:type];
    NSString *urlStr = request.firstObject;
    NSMutableDictionary *params = request.lastObject;
    if (type == NetworkTypeGetNew || type == NetworkTypeGetMore) {
        [NetWorkTool post:urlStr parameters:params networkSuccess:^(id responseObject) {
            successBlock(responseObject);
        } failure:^(NSError *error) {
            failureBlock(error);
        }];
    } else {
        params[@"last_time"] = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        NSLog(@"%@", params[@"last_time"]);
        params[@"pagesize"] = @"10";
        [[AFHTTPSessionManager manager]POST:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
            successBlock(responseObject);
        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
            failureBlock(error);
        }];
    }
    
    
}

- (void)getTopicListDataWithIDS:(NSString *)ids success:(void(^)(id respone))successBlock failure:(void(^)(NSError *error))failureBlock {
    NSArray *request = [self requestWithType:NetworkTypeTopicList];
    NSString *urlStr = request.firstObject;
    NSMutableDictionary *params = request.lastObject;
    params[@"ids"] = ids;
    [[AFHTTPSessionManager manager]GET:urlStr parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        [[[NSOperationQueue alloc] init] addOperationWithBlock:^{
            failureBlock(error);
        }];
    }];
}

- (void)getSubjectWithID:(NSInteger)ID andType:(NSInteger)type success:(void(^)(id respone))successBlock failure:(void(^)(NSError *error))failureBlock {
    NSMutableDictionary *temp = [self.parameters mutableCopy];
    temp[@"id"] = @(ID);
    temp[@"statistics_uv"] = @(type);
    [[AFHTTPSessionManager manager]GET:SubjectURL parameters:temp success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        failureBlock(error);
    }];
}
@end
