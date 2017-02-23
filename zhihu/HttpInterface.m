//
//  HttpInterface.m
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "HttpInterface.h"
static HttpInterface *shareManager = nil;

@implementation HttpInterface

+(HttpInterface *)shareManager{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        shareManager = [[super alloc]init];
    });
    return shareManager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSLog(@"初始化服务请求");
        _httpRequest = [[HttpRequest alloc]init];
    }
    return self;
}
- (void)get_News_Least:(void(^)(id data))dataBlock{
    _httpRequest = [[HttpRequest alloc]init];
    [_httpRequest requestURL:NewsLeast httpMethod:@"GET" params:nil success:^(id data) {
        NSLog(@"底层返回数据%@",data);
        dataBlock(data);
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
        dataBlock(error);
    }];
}
@end
