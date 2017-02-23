//
//  MainBL.m
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "MainBL.h"
#import "HttpInterface.h"
@implementation MainBL
- (void)getNewsLeast{
    HttpInterface *interface = [HttpInterface shareManager];
    [interface get_News_Least:^(id data) {
        if ([data isEqualToString:@"成功"]) {
            NSLog(@"成功");
        }
    }];
}
@end
