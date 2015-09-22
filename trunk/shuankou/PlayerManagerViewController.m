//
//  PlayerManagerViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "PlayerManagerViewController.h"
#import "Config.h"
#import "SQLiteManager.h"
#import "PlayerModel.h"
#import "ApplicationUtils.h"

static NSString *CellId = @"CellId";

@interface PlayerManagerViewController ()

@end

@implementation PlayerManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listModels=[NSMutableArray array];
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc]init]];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:LineColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // 设置为一个接近“平均”行高的值
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    [self doRefresh:nil];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        rowIndex=indexPath;
        
        UIAlertView *prompt = [[UIAlertView alloc] initWithTitle:@"提醒"
                                                         message:@"确定要删除该玩家吗？"
                                                        delegate:self
                                               cancelButtonTitle:@"取消"
                                               otherButtonTitles:@"确定", nil];
        [prompt show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        PlayerModel *model=[_listModels objectAtIndex:rowIndex.row];
        NSString *sqlstr=[NSString stringWithFormat:@"Delete from playerList where id=%d",model.playId];
        if ([[SQLiteManager sharedInstance] executeUpdate:sqlstr]) {
            [_listModels removeObjectAtIndex:rowIndex.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:rowIndex] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
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
    PlayerModel *model=[_listModels objectAtIndex:indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayerModel *model=[_listModels objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"showPlayerEdit" sender:model];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue.destinationViewController setValue:sender forKey:@"playerModel"];
    [segue.destinationViewController setValue:self forKey:@"delegate"];
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)addPlayer:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"showPlayerEdit" sender:nil];
}

- (void)doRefresh:(id)sender {
    [_listModels removeAllObjects];
    NSString *SqlStr=@"Select id,name from playerList order by id";
    NSArray *playerList =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
    for (int i=0; i<playerList.count; i++) {
        NSDictionary *dic=[playerList objectAtIndex:i];
        PlayerModel *model=[[PlayerModel alloc] initWithDictionary:dic];
        [_listModels addObject:model];
    }
    [self.tableView reloadData];
}
@end
