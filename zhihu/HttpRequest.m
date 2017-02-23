//
//  HttpRequest.m
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "HttpRequest.h"
#import "HttpParser.h"

@implementation HttpRequest

- (void)requestURL:(ServerIndex )actionIndex
        httpMethod:(NSString *)method
            params:(NSDictionary *)params
           success:(void(^)(id data))success
              fail:(void(^)(NSError *error))fail{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *requestUrl = [[NSString alloc]init];
    requestUrl = [self findActionUrl:actionIndex];
    
    
    if ([[method uppercaseString] isEqualToString:@"GET"]) {
        [manager GET:requestUrl parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self responseServer:responseObject ActionIndex:actionIndex serviceDetailDataBlock:^(id serviceDetailData){
                success(serviceDetailData);
            }];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
        }];
    }
}
- (NSString *)findActionUrl:(ServerIndex )actionIndex{
    NSString *actionUrl;
    switch (actionIndex) {
        case NewsLeast:
            return URL_News_Least;
            break;
            
        default:
            break;
    }
    return actionUrl;
}
-(void)responseServer:(NSData *)jsonData ActionIndex:(ServerIndex)actionIndex serviceDetailDataBlock:(void(^)(id serviceDetailData))dataBlock{
    if(parser == nil){
        parser = [[HttpParser alloc]init];
    }
    if(actionIndex == NewsLeast){
        [parser getNewsLeast:jsonData serverResponseBlock:^(id responseMsg) {
            dataBlock(responseMsg);
        }];
    }
}
@end
