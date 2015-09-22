//
//  ContentViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_listModels;
    int userSelectIndex;
 }

@property (strong, nonatomic) IBOutlet UIButton *btn_user_1;
@property (strong, nonatomic) IBOutlet UIButton *btn_user_2;
@property (strong, nonatomic) IBOutlet UIButton *btn_user_3;
@property (strong, nonatomic) IBOutlet UIButton *btn_user_4;

@property (strong, nonatomic) IBOutlet UIButton *btn1_5;
@property (strong, nonatomic) IBOutlet UIButton *btn2_5;
@property (strong, nonatomic) IBOutlet UIButton *btn3_5;
@property (strong, nonatomic) IBOutlet UIButton *btn4_5;
@property (strong, nonatomic) IBOutlet UIButton *btn1_6;
@property (strong, nonatomic) IBOutlet UIButton *btn2_6;
@property (strong, nonatomic) IBOutlet UIButton *btn3_6;
@property (strong, nonatomic) IBOutlet UIButton *btn4_6;
@property (strong, nonatomic) IBOutlet UIButton *btn1_7;
@property (strong, nonatomic) IBOutlet UIButton *btn2_7;
@property (strong, nonatomic) IBOutlet UIButton *btn3_7;
@property (strong, nonatomic) IBOutlet UIButton *btn4_7;
@property (strong, nonatomic) IBOutlet UIButton *btn1_8;
@property (strong, nonatomic) IBOutlet UIButton *btn2_8;
@property (strong, nonatomic) IBOutlet UIButton *btn3_8;
@property (strong, nonatomic) IBOutlet UIButton *btn4_8;
@property (strong, nonatomic) IBOutlet UIButton *btn1_9;
@property (strong, nonatomic) IBOutlet UIButton *btn2_9;
@property (strong, nonatomic) IBOutlet UIButton *btn3_9;
@property (strong, nonatomic) IBOutlet UIButton *btn4_9;
@property (strong, nonatomic) IBOutlet UIButton *btn1_10;
@property (strong, nonatomic) IBOutlet UIButton *btn2_10;
@property (strong, nonatomic) IBOutlet UIButton *btn3_10;
@property (strong, nonatomic) IBOutlet UIButton *btn4_10;
@property (strong, nonatomic) IBOutlet UIButton *btn1_11;
@property (strong, nonatomic) IBOutlet UIButton *btn2_11;
@property (strong, nonatomic) IBOutlet UIButton *btn3_11;
@property (strong, nonatomic) IBOutlet UIButton *btn4_11;
@property (strong, nonatomic) IBOutlet UIButton *btn1_12;
@property (strong, nonatomic) IBOutlet UIButton *btn2_12;
@property (strong, nonatomic) IBOutlet UIButton *btn3_12;
@property (strong, nonatomic) IBOutlet UIButton *btn4_12;

- (IBAction)doCheck:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *btn_p;
@property (strong, nonatomic) IBOutlet UIButton *btn_d;
@property (strong, nonatomic) IBOutlet UIButton *btn_s;
@property (strong, nonatomic) IBOutlet UIButton *btn_user1;
@property (strong, nonatomic) IBOutlet UIButton *btn_user2;
@property (strong, nonatomic) IBOutlet UIButton *btn_user3;
@property (strong, nonatomic) IBOutlet UIButton *btn_user4;
@property (strong, nonatomic) IBOutlet UIScrollView *scrllview_select;
@property (strong, nonatomic) IBOutlet UIButton *btn_clear;
@property (strong, nonatomic) IBOutlet UIButton *btn_result;
@property (strong, nonatomic) IBOutlet UIControl *playerSelectView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *btn_cancel;
@property (strong, nonatomic) IBOutlet UIView *view_result;

- (IBAction)selectResultType:(UIButton *)sender;
- (IBAction)selectUser_open:(UIButton *)sender;
- (IBAction)doClear:(UIButton *)sender;
- (IBAction)doResult:(UIButton *)sender;
- (IBAction)hidePlayerSelectView:(id)sender;

@end
