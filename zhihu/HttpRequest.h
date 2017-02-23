//
//  HttpRequest.h
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "HttpParser.h"
typedef enum{
    NewsLeast
}ServerIndex;

#define URL_News_Least @"http://news-at.zhihu.com/api/4/news/latest"
@interface HttpRequest : NSObject{
    HttpParser *parser;
}

- (void)requestURL:(ServerIndex )actionIndex
        httpMethod:(NSString *)method
            params:(NSDictionary *)params
           success:(void(^)(id data))success
              fail:(void(^)(NSError *error))fail;

@end
