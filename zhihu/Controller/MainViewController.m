//
//  MainViewController.m
//  zhihu
//
//  Created by csy on 17/2/21.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import "MainViewController.h"
#import "SDCycleScrollView.h"
#import "Stories.h"
#import "MainBL.h"
@interface MainViewController ()<SDCycleScrollViewDelegate>{
    NSMutableArray *storiesArray;
    NSMutableArray *topStoriesArray;
    NSMutableArray *imageArray;
    NSMutableArray *titleArray;
    MainBL *mainbl;
   
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    mainbl = [[MainBL alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    topStoriesArray = [[NSMutableArray alloc]init];
    [mainbl getNewsLeast];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(getData:) name:@"Get_News_Least" object:nil];
}

-(void)getData:(NSNotification *)aNotification{
    if([aNotification.name isEqualToString:@"Get_News_Least"]){
        if ([[aNotification.userInfo objectForKey:@"Message"]isEqualToString:@"成功"]) {
            storiesArray = [aNotification.userInfo objectForKey:@"data"];
            topStoriesArray = [aNotification.userInfo objectForKey:@"topdata"];
            [self saveImage];
            [self showImage];
        }
    }
}
- (void)saveImage{
  
    for (int i = 0;i < topStoriesArray.count; i++) {
        Stories *stories = [[Stories alloc]init];
        stories = [topStoriesArray objectAtIndex:i];
        
        NSLog(@"%@",stories.image);
        if (stories.image) {
              [imageArray addObject:stories.image];
              [titleArray addObject:stories.title];
        }
    }
    NSLog(@"%@",imageArray);
}
- (void)showImage{
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 240) delegate:self placeholderImage:nil];
     cycleScrollView.imageURLStringsGroup = imageArray;
     cycleScrollView.titlesGroup = titleArray;
    [self.view addSubview:cycleScrollView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
