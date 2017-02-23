//
//  HttpInterface.h
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpRequest.h"
@interface HttpInterface : NSObject
{
    HttpRequest *_httpRequest;
}
+ (HttpInterface *)shareManager;

- (void)get_News_Least:(void(^)(id data))dataBlock;

@end
