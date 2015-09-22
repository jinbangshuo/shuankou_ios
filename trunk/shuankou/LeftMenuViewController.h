//
//  LeftMenuViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_listModels;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
