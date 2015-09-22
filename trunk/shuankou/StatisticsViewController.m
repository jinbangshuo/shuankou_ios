//
//  StatisticsViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "StatisticsViewController.h"
#import "Config.h"
#import "SQLiteManager.h"
#import "ScoreModel.h"
#import "ApplicationUtils.h"
#import "ScoreTableViewCell.h"

static NSString *CellId = @"ScoreCell";
static NSString *CellIdDefault = @"CellId";

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _listModels=[NSMutableArray array];
    
    self.title=self.titleString;
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundView:[[UIView alloc] init]];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorColor:LineColor];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 44.0; // 设置为一个接近“平均”行高的值
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    NSString *SqlStr;
    NSArray *rst;
    switch ([self.statisticsType intValue]) {
        case 0:
            SqlStr=@"Select sum(fcount) as allCount,staffId from recordList where strftime('%j',fdate)=strftime('%j','now') Group by staffId order by allCount desc limit 1";
            rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
            if (rst.count>0) {
                allScore=[[[rst objectAtIndex:0] objectForKey:@"allCount"] floatValue];
            }else{
                allScore=0;
                break;
            }
            SqlStr=@"Select b.name,sum(a.fcount) as aCount from recordList a left join playerList b on a.staffId=b.id where strftime('%j',a.fdate)=strftime('%j','now') group by b.name order by aCount desc";
            rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
            for (int i=0; i<rst.count; i++) {
                ScoreModel *model=[[ScoreModel alloc] init];
                model.aScore=[[[rst objectAtIndex:i] objectForKey:@"aCount"] floatValue];
                model.title=[[rst objectAtIndex:i] objectForKey:@"name"];
                model.maxWidth=self.view.bounds.size.width-90;
                model.allAcore=allScore;
                [_listModels addObject:model];
            }
            break;
        case 1:
            SqlStr=@"Select b.name,a.fcount,a.fdate from recordList a left join playerList b on a.staffId=b.id where strftime('%j',a.fdate)=strftime('%j','now') Order by a.fdate desc";
            rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
            for (int i=0; i<rst.count; i++) {
                NSString *mark=[NSString stringWithFormat:@"%@：%@ [%@]",[[rst objectAtIndex:i] objectForKey:@"name"],[ApplicationUtils formatNumber:[[[rst objectAtIndex:i] objectForKey:@"fcount"] floatValue]],[[rst objectAtIndex:i] objectForKey:@"fdate"]];
                ScoreModel *model=[[ScoreModel alloc] init];
                model.aScore=0;
                model.title=mark;
                [_listModels addObject:model];
            }
            break;
        case 2:
            SqlStr=@"Select sum(fcount) as allCount,staffId from recordList Group by staffId order by allCount desc limit 1";
            rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
            if (rst.count>0) {
                allScore=[[[rst objectAtIndex:0] objectForKey:@"allCount"] floatValue];
            }else{
                allScore=0;
                break;
            }
            SqlStr=@"Select b.name,sum(a.fcount) as aCount from recordList a left join playerList b on a.staffId=b.id group by b.name  order by aCount desc";
            rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
            for (int i=0; i<rst.count; i++) {
                ScoreModel *model=[[ScoreModel alloc] init];
                model.aScore=[[[rst objectAtIndex:i] objectForKey:@"aCount"] floatValue];
                model.title=[[rst objectAtIndex:i] objectForKey:@"name"];
                model.maxWidth=self.view.bounds.size.width-90;
                model.allAcore=allScore;
                [_listModels addObject:model];
            }
            break;
        case 3:
            SqlStr=@"Select b.name,a.fcount,a.fdate from recordList a left join playerList b on a.staffId=b.id Order by a.fdate desc";
            rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
            for (int i=0; i<rst.count; i++) {
                NSString *mark=[NSString stringWithFormat:@"%@：%@ [%@]",[[rst objectAtIndex:i] objectForKey:@"name"],[ApplicationUtils formatNumber:[[[rst objectAtIndex:i] objectForKey:@"fcount"] floatValue]],[[rst objectAtIndex:i] objectForKey:@"fdate"]];
                ScoreModel *model=[[ScoreModel alloc] init];
                model.aScore=0;
                model.title=mark;
                [_listModels addObject:model];
            }
            break;
            
        default:
            break;
    }
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreModel *model=[_listModels objectAtIndex:indexPath.row];
    if ([self.statisticsType intValue]==0 || [self.statisticsType intValue]==2) {
        ScoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        if (!cell) {
            cell = [[ScoreTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellId];
        }
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdDefault];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdDefault];
        }
        cell.textLabel.text=model.title;
        if (indexPath.row<4) {
            cell.backgroundColor=UIColorFromRGB(0xfaa845);
        } else {
            cell.backgroundColor=[UIColor clearColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
