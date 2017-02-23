//
//  MainViewController.h
//  zhihu
//
//  Created by csy on 17/2/21.
//  Copyright © 2017年 xyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end
