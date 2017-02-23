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
#import "MainTableViewCell.h"
#import "MainBL.h"
@interface MainViewController ()<SDCycleScrollViewDelegate>{
    NSMutableArray *storiesArray;
    NSMutableArray *topStoriesArray;
    NSMutableArray *imageArray;
    NSMutableArray *titleArray;
    MainBL *mainbl;
    MainTableViewCell *cell;
   
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    mainbl = [[MainBL alloc]init];
    imageArray = [[NSMutableArray alloc]init];
    titleArray = [[NSMutableArray alloc]init];
    topStoriesArray = [[NSMutableArray alloc]init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//    self.navigationController.navigationBar.translucent = true;
//   
    UIColor* color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ref, color.CGColor);
    CGContextFillRect(ref, rect);
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar
     setBackgroundImage:image
     forBarMetrics:UIBarMetricsDefault];
   // self.navigationController.navigationItem.
//    [self.navigationController.navigationBar
//     setBackgroundImage:image
//     forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = true;
   //  [self.navigationController setNavigationBarHidden:YES];
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
       //     [self.mainTableView reloadData];
        }
    }
}
- (void)saveImage{
  
    for (int i = 0;i < topStoriesArray.count; i++) {
        Stories *stories = [[Stories alloc]init];
        stories = [topStoriesArray objectAtIndex:i];
        
        NSLog(@"%@",stories.image);
        NSLog(@"%@",stories.title);
        if (stories.image) {
              [imageArray addObject:stories.image];
              [titleArray addObject:stories.title];
            [self.mainTableView reloadData];
        }
    }
    NSLog(@"%@",imageArray);
}
- (void)showImage{
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200) delegate:self placeholderImage:nil];
     cycleScrollView.imageURLStringsGroup = imageArray;
    NSLog(@"%@",titleArray);
     cycleScrollView.titlesGroup = titleArray;
    self.mainTableView.tableHeaderView = cycleScrollView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark -tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 //   return storiesArray.count;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return storiesArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (cell == nil) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    }
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:nil options:nil];
    cell = [nib objectAtIndex:0];
    Stories *stor = [storiesArray objectAtIndex:indexPath.row];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[stor.images objectAtIndex:0]]];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.mainImageVuew.image = image;
    cell.contentLabel.text = stor.title;
    return cell;
}
#pragma mark -scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //[self.]
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //限制scrollview的bounce size
    if (scrollView.contentOffset.y <= 0) {
        CGPoint offset = scrollView.contentOffset;
        offset.y = 0;
        scrollView.contentOffset = offset;
    }
    if (scrollView.contentOffset.y >
        scrollView.contentSize.height - self.view.bounds.size.height) {
      //  [self loadBeforeData];
    }
    
    [self adjustNavigationAlpha];
}
- (void)adjustNavigationAlpha
{
//    if (self.mainTableView.contentOffset.y > self.secondSectionOffsetY) {
//        self.mainTableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
//        //这里不能直接隐藏navigationbar，会导致tableview的insettop失控
//        self.navigationItem.title = @"";
//        //缩短背景视图避免其挡住section header
//        self.navigationController.navigationBar.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)
//      //  [self.navigationController.navigationBar setBackgroundLayerHeight:20];
//    } else {
//       self.mainTableView.contentInset =
//        UIEdgeInsetsMake([self.class sliderInsetY], 0, 0, 0);
//        self.navigationItem.title = @"今日热闻";
//       
//        
//      //  [self.navigationController.navigationBar setBackgroundLayerHeight:64];
//    }
//    
 //   [self.navigationController.navigationBar
 //    setNavigationBackgroundColor:self.themeColorWithAdjustmentAlpha];
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
