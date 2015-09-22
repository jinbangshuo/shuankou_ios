//
//  LeftMenuViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "RESideMenu.h"
#import "Config.h"
#import "SQLiteManager.h"
#import "ApplicationUtils.h"

static NSString *CellId = @"CellId";

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listModels=[NSMutableArray array];
    [self.view setBackgroundColor:BarTintColor];
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:LineColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // 设置为一个接近“平均”行高的值
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    [_listModels addObject:@"基础分设置"];
    [_listModels addObject:@"玩家管理"];
    [_listModels addObject:@"清空数据"];
    [_listModels addObject:@"关于"];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
    }
    cell.textLabel.text = [_listModels objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertView *prompt;
    switch (indexPath.row) {
        case 0://基础分设置
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showSetting" object:self userInfo:nil];
            break;
        case 1://玩家管理
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showPlayerManager" object:self userInfo:nil];
            break;
        case 2://清空数据
            prompt = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                 message:@"确定要清空所有数据吗？"
                                                delegate:self
                                       cancelButtonTitle:@"取消"
                                       otherButtonTitles:@"确定", nil];
            [prompt show];
            break;
        case 3://关于
            [[NSNotificationCenter defaultCenter] postNotificationName:@"showAboutMe" object:self userInfo:nil];
            break;
        default:
            break;
    }
    [self.sideMenuViewController hideMenuViewController];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSMutableArray *pSqlStr=[NSMutableArray array];
        [pSqlStr addObject:@"Delete from playerList where id>4"];
        [pSqlStr addObject:@"Delete from recordList"];
        [pSqlStr addObject:@"update systemSet set set_p=1,set_d=2,set_s=3,set_max=0,set_6=1,set_7=2,set_8=4,set_9=8,set_10=16,set_11=32,set_12=64"];
        if ([[SQLiteManager sharedInstance] executeUpdateByTran:pSqlStr]) {
            [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"playId1"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"playname1"];
            [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"playId2"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"playname2"];
            [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"playId3"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"playname3"];
            [[NSUserDefaults standardUserDefaults] setObject:0 forKey:@"playId4"];
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"playname4"];
            [ApplicationUtils MsgBox:@"数据清空成功！"];
        }else{
            [ApplicationUtils MsgBox:@"数据清空失败，请重试！"];
        }
    }
}
@end
