//
//  RightMenuViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "RightMenuViewController.h"
#import "RESideMenu.h"
#import "Config.h"

static NSString *CellId = @"CellId";

@interface RightMenuViewController ()

@end

@implementation RightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listModels=[NSMutableArray array];
    [self.view setBackgroundColor:BarTintColor];
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc]init]];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:LineColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // 设置为一个接近“平均”行高的值
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    [_listModels addObject:@"当日输赢分数统计"];
    [_listModels addObject:@"当日记录明细查询"];
    [_listModels addObject:@"全部输赢分数统计"];
    [_listModels addObject:@"全部记录明细查询"];
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
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:[NSNumber numberWithInteger:indexPath.row] forKey:@"rowIndex"];
    [dic setValue:[_listModels objectAtIndex:indexPath.row] forKey:@"title"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showStatistics" object:self userInfo:dic];
    
    
    [self.sideMenuViewController hideMenuViewController];
}
@end
