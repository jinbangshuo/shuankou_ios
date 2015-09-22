//
//  ContentViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "ContentViewController.h"
#import <Masonry/Masonry.h>
#import "SQLiteManager.h"
#import "PlayerModel.h"
#import "ApplicationUtils.h"
#import "ResultModel.h"
#import <BFKit/BFKit.h>
#import "Config.h"

static NSString *CellId = @"CellId";

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showPlayerManager:) name:@"showPlayerManager" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSetting:) name:@"showSetting" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAboutMe:) name:@"showAboutMe" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showStatistics:) name:@"showStatistics" object:nil];
    
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
    
    [self.btn_clear setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x4ab5e1)] forState:UIControlStateNormal];
    [self.btn_clear setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3a9cc4)] forState:UIControlStateHighlighted];
    self.btn_clear.layer.cornerRadius=5.0f;
    self.btn_clear.layer.borderColor=LineColor.CGColor;
    self.btn_clear.clipsToBounds=YES;
    
    [self.btn_result setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x4ab5e1)] forState:UIControlStateNormal];
    [self.btn_result setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3a9cc4)] forState:UIControlStateHighlighted];
    self.btn_result.layer.cornerRadius=5.0f;
    self.btn_result.layer.borderColor=LineColor.CGColor;
    self.btn_result.clipsToBounds=YES;
    
    [self.btn_cancel setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x4ab5e1)] forState:UIControlStateNormal];
    [self.btn_cancel setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB(0x3a9cc4)] forState:UIControlStateHighlighted];
    self.btn_cancel.layer.cornerRadius=5.0f;
    self.btn_cancel.layer.borderColor=LineColor.CGColor;
    self.btn_cancel.clipsToBounds=YES;
    
    NSNumber *playId=[[NSUserDefaults standardUserDefaults] objectForKey:@"playId1"];
    NSString *playName=[[NSUserDefaults standardUserDefaults] stringForKey:@"playname1"];
    if (!playId) {
        self.btn_user1.tag=1;
        [self.btn_user1 setTitle:@"玩家(1)" forState:UIControlStateNormal];
    }else{
        self.btn_user1.tag=[playId intValue];
        [self.btn_user1 setTitle:playName forState:UIControlStateNormal];
    }
    playId=[[NSUserDefaults standardUserDefaults] objectForKey:@"playId2"];
    playName=[[NSUserDefaults standardUserDefaults] stringForKey:@"playname2"];
    if (!playId) {
        self.btn_user2.tag=2;
        [self.btn_user2 setTitle:@"玩家(2)" forState:UIControlStateNormal];
    }else{
        self.btn_user2.tag=[playId intValue];
        [self.btn_user2 setTitle:playName forState:UIControlStateNormal];
    }
    playId=[[NSUserDefaults standardUserDefaults] objectForKey:@"playId3"];
    playName=[[NSUserDefaults standardUserDefaults] stringForKey:@"playname3"];
    if (!playId) {
        self.btn_user3.tag=3;
        [self.btn_user3 setTitle:@"玩家(3)" forState:UIControlStateNormal];
    }else{
        self.btn_user3.tag=[playId intValue];
        [self.btn_user3 setTitle:playName forState:UIControlStateNormal];
    }
    playId=[[NSUserDefaults standardUserDefaults] objectForKey:@"playId4"];
    playName=[[NSUserDefaults standardUserDefaults] stringForKey:@"playname4"];
    if (!playId) {
        self.btn_user4.tag=4;
        [self.btn_user4 setTitle:@"玩家(4)" forState:UIControlStateNormal];
    }else{
        self.btn_user4.tag=[playId intValue];
        [self.btn_user4 setTitle:playName forState:UIControlStateNormal];
    }
    
    [self doClear:self.btn_clear];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showPlayerManager" object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showSetting" object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showAboutMe" object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"showStatistics" object:self];
}

- (IBAction)selectResultType:(UIButton *)sender {
    if ([sender isEqual:self.btn_p]) {
        self.btn_p.selected=YES;
        self.btn_d.selected=NO;
        self.btn_s.selected=NO;
    }else if ([sender isEqual:self.btn_d]) {
        self.btn_p.selected=NO;
        self.btn_d.selected=YES;
        self.btn_s.selected=NO;
    }else if ([sender isEqual:self.btn_s]) {
        self.btn_p.selected=NO;
        self.btn_d.selected=NO;
        self.btn_s.selected=YES;
    }
}

- (IBAction)selectUser_open:(UIButton *)sender {
    [_listModels removeAllObjects];
    NSString *SqlStr=@"Select id,name from playerList Where closed=0 order by id";
    NSArray *userList =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
    for (int i=0; i<userList.count; i++) {
        NSDictionary *dic=[userList objectAtIndex:i];
        PlayerModel *model=[[PlayerModel alloc] initWithDictionary:dic];
        [_listModels addObject:model];
    }
    [self.tableView reloadData];
    if ([sender isEqual:self.btn_user1]) {
        userSelectIndex=1;
    }else if ([sender isEqual:self.btn_user2]) {
        userSelectIndex=2;
    }else if ([sender isEqual:self.btn_user3]) {
        userSelectIndex=3;
    }else if ([sender isEqual:self.btn_user4]) {
        userSelectIndex=4;
    }
    self.playerSelectView.hidden=NO;
    self.view_result.hidden=YES;
}

- (IBAction)doClear:(UIButton *)sender {
    [self selectResultType:self.btn_p];
    
    self.btn_user_1.selected = YES;
    self.btn_user_2.selected = YES;
    self.btn_user_3.selected = NO;
    self.btn_user_4.selected = NO;
    
    self.btn1_5.selected = NO;
    self.btn1_6.selected = NO;
    self.btn1_7.selected = NO;
    self.btn1_8.selected = NO;
    self.btn1_9.selected = NO;
    self.btn1_10.selected = NO;
    self.btn1_11.selected = NO;
    self.btn1_12.selected = NO;
    
    self.btn2_5.selected = NO;
    self.btn2_6.selected = NO;
    self.btn2_7.selected = NO;
    self.btn2_8.selected = NO;
    self.btn2_9.selected = NO;
    self.btn2_10.selected = NO;
    self.btn2_11.selected = NO;
    self.btn2_12.selected = NO;
    
    self.btn3_5.selected = NO;
    self.btn3_6.selected = NO;
    self.btn3_7.selected = NO;
    self.btn3_8.selected = NO;
    self.btn3_9.selected = NO;
    self.btn3_10.selected = NO;
    self.btn3_11.selected = NO;
    self.btn3_12.selected = NO;
    
    self.btn4_5.selected = NO;
    self.btn4_6.selected = NO;
    self.btn4_7.selected = NO;
    self.btn4_8.selected = NO;
    self.btn4_9.selected = NO;
    self.btn4_10.selected = NO;
    self.btn4_11.selected = NO;
    self.btn4_12.selected = NO;
}

- (IBAction)doResult:(UIButton *)sender {
    if (self.btn_user1.tag==0) {
        [ApplicationUtils MsgBox:@"请选择玩家(1)"];
        return;
    }
    if (self.btn_user2.tag==0) {
        [ApplicationUtils MsgBox:@"请选择玩家(2)"];
        return;
    }
    if (self.btn_user3.tag==0) {
        [ApplicationUtils MsgBox:@"请选择玩家(3)"];
        return;
    }
    if (self.btn_user4.tag==0) {
        [ApplicationUtils MsgBox:@"请选择玩家(3)"];
        return;
    }
    if (self.btn_user1.tag==self.btn_user2.tag) {
        [ApplicationUtils MsgBox:@"玩家(1) 与  玩家(2) 不能为同一个人！"];
        return;
    }
    if (self.btn_user1.tag==self.btn_user3.tag) {
        [ApplicationUtils MsgBox:@"玩家(1) 与 玩家(3) 不能为同一个人！"];
        return;
    }
    if (self.btn_user1.tag==self.btn_user4.tag) {
        [ApplicationUtils MsgBox:@"玩家(1) 与 玩家(4) 不能为同一个人！"];
        return;
    }
    if (self.btn_user2.tag==self.btn_user3.tag) {
        [ApplicationUtils MsgBox:@"玩家(2) 与 玩家(3) 不能为同一个人！"];
        return;
    }
    if (self.btn_user2.tag==self.btn_user4.tag) {
        [ApplicationUtils MsgBox:@"玩家(2) 与 玩家(4) 不能为同一个人！"];
        return;
    }
    if (self.btn_user3.tag==self.btn_user4.tag) {
        [ApplicationUtils MsgBox:@"玩家(3) 与 玩家(4) 不能为同一个人！"];
        return;
    }
    int winNum=0;
    if (self.btn_user_1.selected) {
        winNum++;
    }
    if (self.btn_user_2.selected) {
        winNum++;
    }
    if (self.btn_user_3.selected) {
        winNum++;
    }
    if (self.btn_user_4.selected) {
        winNum++;
    }
    if (winNum!=2) {
        [ApplicationUtils MsgBox:@"请选择2位赢家！"];
        return;
    }
    
    float set_p = 1;// 平扣基础分
    float set_d = 2;// 单扣基础分
    float set_s = 3;// 双扣基础分
    
    float set_6 = 1;// 6扇贡献分
    float set_7 = 2;// 7扇贡献分
    float set_8 = 4;// 8扇贡献分
    float set_9 = 8;// 9扇贡献分
    float set_10 = 16;// 10扇贡献分
    float set_11 = 32;// 11扇贡献分
    float set_12 = 64;// 12扇贡献分
    int set_max = 0;// 最高翻至
    
    float nGet1=0;//玩家1得分
    float nGet2=0;//玩家2得分
    float nGet3=0;//玩家3得分
    float nGet4=0;//玩家4得分
    
    NSString *SqlStr=@"Select set_p,set_d,set_s,set_max,set_6,set_7,set_8,set_9,set_10,set_11,set_12 from systemSet";
    NSArray *rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
    if (rst.count>0) {
        set_p=[[[rst objectAtIndex:0] objectForKey:@"set_p"] floatValue];
        set_d=[[[rst objectAtIndex:0] objectForKey:@"set_d"] floatValue];
        set_s=[[[rst objectAtIndex:0] objectForKey:@"set_s"] floatValue];
        set_max=[[[rst objectAtIndex:0] objectForKey:@"set_max"] floatValue];
        
        set_6=[[[rst objectAtIndex:0] objectForKey:@"set_6"] floatValue];
        set_7=[[[rst objectAtIndex:0] objectForKey:@"set_7"] floatValue];
        set_8=[[[rst objectAtIndex:0] objectForKey:@"set_8"] floatValue];
        set_9=[[[rst objectAtIndex:0] objectForKey:@"set_9"] floatValue];
        set_10=[[[rst objectAtIndex:0] objectForKey:@"set_10"] floatValue];
        set_11=[[[rst objectAtIndex:0] objectForKey:@"set_11"] floatValue];
        set_12=[[[rst objectAtIndex:0] objectForKey:@"set_12"] floatValue];
    }
    // 界面数据变量
    int nS = 0;// 倍数
    float nAlt = 0;// 牌面得分
    NSString *sAlt = @"";
    
    float nRlt1 = 0;// 玩家一进供
    NSString *sRlt1 = @"";
    float nRlt2 = 0;// 玩家二进供
    NSString *sRlt2 = @"";
    float nRlt3 = 0;// 玩家三进供
    NSString *sRlt3 = @"";
    float nRlt4 = 0;// 玩家四进供
    NSString *sRlt4 = @"";
    
    NSString *sGet1 = @"";
    NSString *sGet2 = @"";
    NSString *sGet3 = @"";
    NSString *sGet4 = @"";
    
    if (self.btn_user_1.selected) {
        if (self.btn1_5.selected) {
            nS = 1;
        }
        if (self.btn1_6.selected) {
            nS = 2;
        }
        if (self.btn1_7.selected) {
            nS = 3;
        }
        if (self.btn1_8.selected) {
            nS = 4;
        }
        if (self.btn1_9.selected) {
            nS = 5;
        }
        if (self.btn1_10.selected) {
            nS = 6;
        }
        if (self.btn1_11.selected) {
            nS = 7;
        }
        if (self.btn1_12.selected) {
            nS = 8;
        }
    }
    if (self.btn_user_2.selected) {
        if (self.btn2_5.selected && nS < 1) {
            nS = 1;
        }
        if (self.btn2_6.selected && nS < 2) {
            nS = 2;
        }
        if (self.btn2_7.selected && nS < 3) {
            nS = 3;
        }
        if (self.btn2_8.selected && nS < 4) {
            nS = 4;
        }
        if (self.btn2_9.selected && nS < 5) {
            nS = 5;
        }
        if (self.btn2_10.selected && nS < 6) {
            nS = 6;
        }
        if (self.btn2_11.selected && nS < 7) {
            nS = 7;
        }
        if (self.btn2_12.selected && nS < 8) {
            nS = 8;
        }
    }
    if (self.btn_user_3.selected) {
        if (self.btn3_5.selected && nS < 1) {
            nS = 1;
        }
        if (self.btn3_6.selected && nS < 2) {
            nS = 2;
        }
        if (self.btn3_7.selected && nS < 3) {
            nS = 3;
        }
        if (self.btn3_8.selected && nS < 4) {
            nS = 4;
        }
        if (self.btn3_9.selected && nS < 5) {
            nS = 5;
        }
        if (self.btn3_10.selected && nS < 6) {
            nS = 6;
        }
        if (self.btn3_11.selected && nS < 7) {
            nS = 7;
        }
        if (self.btn3_12.selected && nS < 8) {
            nS = 8;
        }
    }
    if (self.btn_user_4.selected) {
        if (self.btn4_5.selected && nS < 1) {
            nS = 1;
        }
        if (self.btn4_6.selected && nS < 2) {
            nS = 2;
        }
        if (self.btn4_7.selected && nS < 3) {
            nS = 3;
        }
        if (self.btn4_8.selected && nS < 4) {
            nS = 4;
        }
        if (self.btn4_9.selected && nS < 5) {
            nS = 5;
        }
        if (self.btn4_10.selected && nS < 6) {
            nS = 6;
        }
        if (self.btn4_11.selected && nS < 7) {
            nS = 7;
        }
        if (self.btn4_12.selected && nS < 8) {
            nS = 8;
        }
    }
    
    if (set_max != 0 && nS > set_max) {
        nS = set_max;
    }
    
    // 算牌面分
    if (self.btn_p.selected) {
        nAlt =set_p * pow(2, nS);
        sAlt=[NSString stringWithFormat:@"%@x%@",[ApplicationUtils formatNumber:set_p],[ApplicationUtils formatNumber:pow(2, nS)]];
    } else if (self.btn_d.selected) {
        nAlt = set_d * pow(2, nS);
        sAlt=[NSString stringWithFormat:@"%@x%@",[ApplicationUtils formatNumber:set_d],[ApplicationUtils formatNumber:pow(2, nS)]];
    } else if (self.btn_s.selected) {
        nAlt = set_s * pow(2, nS);
        sAlt=[NSString stringWithFormat:@"%@x%@",[ApplicationUtils formatNumber:set_s],[ApplicationUtils formatNumber:pow(2, nS)]];
    }
    // 算玩家进供
    // 赢家一
    if (self.btn1_6.selected) {
        nRlt1 = nRlt1 + set_6;
    }
    if (self.btn1_7.selected) {
        nRlt1 = nRlt1 + set_7;
    }
    if (self.btn1_8.selected) {
        nRlt1 = nRlt1 + set_8;
    }
    if (self.btn1_9.selected) {
        nRlt1 = nRlt1 + set_9;
    }
    if (self.btn1_10.selected) {
        nRlt1 = nRlt1 + set_10;
    }
    if (self.btn1_11.selected) {
        nRlt1 = nRlt1 + set_11;
    }
    if (self.btn1_12.selected) {
        nRlt1 = nRlt1 + set_12;
    }
    // 赢家二
    if (self.btn2_6.selected) {
        nRlt2 = nRlt2 + set_6;
    }
    if (self.btn2_7.selected) {
        nRlt2 = nRlt2 + set_7;
    }
    if (self.btn2_8.selected) {
        nRlt2 = nRlt2 + set_8;
    }
    if (self.btn2_9.selected) {
        nRlt2 = nRlt2 + set_9;
    }
    if (self.btn2_10.selected) {
        nRlt2 = nRlt2 + set_10;
    }
    if (self.btn2_11.selected) {
        nRlt2 = nRlt2 + set_11;
    }
    if (self.btn2_12.selected) {
        nRlt2 = nRlt2 + set_12;
    }
    // 输家一
    if (self.btn3_6.selected) {
        nRlt3 = nRlt3 + set_6;
    }
    if (self.btn3_7.selected) {
        nRlt3 = nRlt3 + set_7;
    }
    if (self.btn3_8.selected) {
        nRlt3 = nRlt3 + set_8;
    }
    if (self.btn3_9.selected) {
        nRlt3 = nRlt3 + set_9;
    }
    if (self.btn3_10.selected) {
        nRlt3 = nRlt3 + set_10;
    }
    if (self.btn3_11.selected) {
        nRlt3 = nRlt3 + set_11;
    }
    if (self.btn3_12.selected) {
        nRlt3 = nRlt3 + set_12;
    }
    // 输家二
    if (self.btn4_6.selected) {
        nRlt4 = nRlt4 + set_6;
    }
    if (self.btn4_7.selected) {
        nRlt4 = nRlt4 + set_7;
    }
    if (self.btn4_8.selected) {
        nRlt4 = nRlt4 + set_8;
    }
    if (self.btn4_9.selected) {
        nRlt4 = nRlt4 + set_9;
    }
    if (self.btn4_10.selected) {
        nRlt4 = nRlt4 + set_10;
    }
    if (self.btn4_11.selected) {
        nRlt4 = nRlt4 + set_11;
    }
    if (self.btn4_12.selected) {
        nRlt4 = nRlt4 + set_12;
    }
    
    // 算得分
    sRlt1 = [ApplicationUtils formatNumber:nRlt1];
    sRlt2 = [ApplicationUtils formatNumber:nRlt2];
    sRlt3 = [ApplicationUtils formatNumber:nRlt3];
    sRlt4 = [ApplicationUtils formatNumber:nRlt4];
    if (self.btn_user_1.selected) {
        nGet1 = nRlt1 * 3 - nRlt2 - nRlt3 - nRlt4 + nAlt;
        sGet1=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt1],(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt2],(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt3],(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt4],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"+%@",sAlt]];
    }else{
        nGet1 = nRlt1 * 3 - nRlt2 - nRlt3 - nRlt4 - nAlt;
        sGet1=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt1],(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt2],(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt3],(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt4],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"-%@",sAlt]];
    }
    if (self.btn_user_2.selected) {
        nGet2 = nRlt2 * 3 - nRlt1 - nRlt3 - nRlt4 + nAlt;
        sGet2=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt2],(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt1],(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt3],(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt4],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"+%@",sAlt]];
    }else{
        nGet2 = nRlt2 * 3 - nRlt1 - nRlt3 - nRlt4 - nAlt;
        sGet2=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt2],(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt1],(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt3],(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt4],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"-%@",sAlt]];
    }
    if (self.btn_user_3.selected) {
        nGet3 = nRlt3 * 3 - nRlt1 - nRlt2 - nRlt4 + nAlt;
        sGet3=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt3],(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt1],(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt2],(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt4],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"+%@",sAlt]];
    }else{
        nGet3 = nRlt3 * 3 - nRlt1 - nRlt2 - nRlt4 - nAlt;
        sGet3=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt3],(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt1],(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt2],(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt4],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"-%@",sAlt]];
    }
    if (self.btn_user_4.selected) {
        nGet4 = nRlt4 * 3 - nRlt1 - nRlt2 - nRlt3 + nAlt;
        sGet4=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt4],(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt1],(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt2],(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt3],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"+%@",sAlt]];
    }else{
        nGet4 = nRlt4 * 3 - nRlt1 - nRlt2 - nRlt3 - nAlt;
        sGet4=[NSString stringWithFormat:@"%@%@%@%@%@",(nRlt4 == 0) ? @"" : [NSString stringWithFormat:@"(%@)x3",sRlt4],(nRlt1 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt1],(nRlt2 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt2],(nRlt3 == 0) ? @"" : [NSString stringWithFormat:@"-%@",sRlt3],(nAlt == 0) ? @"" : [NSString stringWithFormat:@"-%@",sAlt]];
    }
    
    NSMutableArray *array=[NSMutableArray array];
    BOOL win1=NO,win2=NO,win3=NO,win4=NO;
    ResultModel *model;
    for (int i=0; i<2; i++) {
        if (self.btn_user_1.selected && !win1) {
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user1.tag name:self.btn_user1.titleLabel.text count:nGet1 mark:sGet1];
            NSLog(@"model1=%@",model.toString);
            [array addObject:model];
            win1=YES;
        }else if (self.btn_user_2.selected && !win2){
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user2.tag name:self.btn_user2.titleLabel.text count:nGet2 mark:sGet2];
            [array addObject:model];
            win2=YES;
        }else if(self.btn_user_3.selected && !win3){
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user3.tag name:self.btn_user3.titleLabel.text count:nGet3 mark:sGet3];
            [array addObject:model];
            win3=YES;
        }else if (self.btn_user_4.selected && !win4){
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user4.tag name:self.btn_user4.titleLabel.text count:nGet4 mark:sGet4];
            [array addObject:model];
            win4=YES;
        }
    }
    NSLog(@"add no select");
    for (int i=0; i<2; i++) {
        if (!win1) {
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user1.tag name:self.btn_user1.titleLabel.text count:nGet1 mark:sGet1];
            [array addObject:model];
            win1=YES;
        }else if (!win2){
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user2.tag name:self.btn_user2.titleLabel.text count:nGet2 mark:sGet2];
            [array addObject:model];
            win2=YES;
        }else if(!win3){
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user3.tag name:self.btn_user3.titleLabel.text count:nGet3 mark:sGet3];
            [array addObject:model];
            win3=YES;
        }else if (!win4){
            model=[[ResultModel alloc] initWithDictionary:(int)self.btn_user4.tag name:self.btn_user4.titleLabel.text count:nGet4 mark:sGet4];
            [array addObject:model];
            win4=YES;
        }
    }
    
    [self performSegueWithIdentifier:@"showResult" sender:array];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showResult"]) {
        [segue.destinationViewController setValue:sender forKey:@"resultArray"];
        [segue.destinationViewController setValue:self forKey:@"delegate"];
    }else if([segue.identifier isEqualToString:@"showStatistics"]){
        [segue.destinationViewController setValue:[((NSNotification *)sender).userInfo objectForKey:@"rowIndex"] forKey:@"statisticsType"];
        [segue.destinationViewController setValue:[((NSNotification *)sender).userInfo objectForKey:@"title"] forKey:@"titleString"];
    }
}

- (IBAction)hidePlayerSelectView:(UIControl *)sender {
    self.playerSelectView.hidden=YES;
    self.view_result.hidden=NO;
}

- (IBAction)doCheck:(UIButton *)sender {
    sender.selected=!sender.selected;
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
    switch (userSelectIndex) {
        case 1:
            [self.btn_user1 setTitle:model.name forState:UIControlStateNormal];
            self.btn_user1.tag=model.playId;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:model.playId] forKey:@"playId1"];
            [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:@"playname1"];
            break;
        case 2:
            [self.btn_user2 setTitle:model.name forState:UIControlStateNormal];
            self.btn_user2.tag=model.playId;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:model.playId] forKey:@"playId2"];
            [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:@"playname2"];
            break;
        case 3:
            [self.btn_user3 setTitle:model.name forState:UIControlStateNormal];
            self.btn_user3.tag=model.playId;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:model.playId] forKey:@"playId3"];
            [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:@"playname3"];
            break;
        case 4:
            [self.btn_user4 setTitle:model.name forState:UIControlStateNormal];
            self.btn_user4.tag=model.playId;
            [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInt:model.playId] forKey:@"playId4"];
            [[NSUserDefaults standardUserDefaults] setObject:model.name forKey:@"playname4"];
            break;
            
        default:
            break;
    }
    
    self.playerSelectView.hidden=YES;
    self.view_result.hidden=NO;
}

- (void)showPlayerManager:(id)sender{
    [self performSegueWithIdentifier:@"showPlayerManager" sender:nil];
}

- (void)showSetting:(id)sender{
    [self performSegueWithIdentifier:@"showSetting" sender:nil];
}

- (void)showAboutMe:(id)sender{
    [self performSegueWithIdentifier:@"showAboutMe" sender:nil];
}

- (void)showStatistics:(id)sender{
    [self performSegueWithIdentifier:@"showStatistics" sender:sender];
}

@end
