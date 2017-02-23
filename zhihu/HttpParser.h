//
//  HttpParser.h
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpParser : NSObject

- (void)getNewsLeast:(NSData *)jsonData serverResponseBlock:(void(^)(id responseMsg))serverResponseBlock;

@end
