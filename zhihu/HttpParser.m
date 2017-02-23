//
//  HttpParser.m
//  zhihu
//
//  Created by csy on 17/2/22.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "HttpParser.h"
#import "Stories.h"
@implementation HttpParser
- (void)getNewsLeast:(NSDictionary *)jsonData serverResponseBlock:(void(^)(id responseMsg))serverResponseBlock{
    NSLog(@"%@",jsonData);
    NSMutableArray *storiesArray = [[NSMutableArray alloc]init];
    NSMutableArray *topStoriseArray = [[NSMutableArray alloc]init];
    NSDictionary *jsondata = jsonData;
    NSArray *storyArray = [jsondata objectForKey:@"stories"];
    NSArray *topStoryArray = [jsonData objectForKey:@"top_stories"];
    for (NSDictionary *dict in storyArray) {
        Stories *stories = [[Stories alloc]init];
        stories.images = [dict objectForKey:@"images"];
        stories.image = [dict objectForKey:@"image"];
        stories.ga_prefix = [dict objectForKey:@"ga_prefix"];
        stories.title = [dict objectForKey:@"title"];
        stories.type = [[dict objectForKey:@"type"]integerValue];
        stories.identidier = [[dict objectForKey:@"id"]integerValue];
        [storiesArray addObject:stories];
    }
    for (NSDictionary *dict in topStoryArray) {
        Stories *stories = [[Stories alloc]init];
        stories.images = [dict objectForKey:@"images"];
        stories.image = [dict objectForKey:@"image"];
        stories.ga_prefix = [dict objectForKey:@"ga_prefix"];
        stories.title = [dict objectForKey:@"title"];
        stories.type = [[dict objectForKey:@"type"]integerValue];
        stories.identidier = [[dict objectForKey:@"id"]integerValue];
        [topStoriseArray addObject:stories];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"Get_News_Least" object:nil userInfo:[NSDictionary dictionaryWithObjects:@[@"成功",storiesArray,topStoriseArray] forKeys:@[@"Message",@"data",@"topdata"]]];
}
@end
