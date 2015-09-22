//
//  PlayerManagerViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_listModels;
    NSIndexPath *rowIndex;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)addPlayer:(UIBarButtonItem *)sender;

@end
