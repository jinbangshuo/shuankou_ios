//
//  StatisticsViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_listModels;
    float allScore;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSNumber *statisticsType;
@property (nonatomic, strong) NSString *titleString;


- (IBAction)goBack:(UIBarButtonItem *)sender;
@end
