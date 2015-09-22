//
//  PlayerEditViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "PlayerEditViewController.h"
#import "ApplicationUtils.h"
#import "SQLiteManager.h"

@interface PlayerEditViewController ()

@end

@implementation PlayerEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.playerModel) {
        self.txtName.text=self.playerModel.name;
        self.btnUnuse.selected=self.playerModel.closed;
    }
}

- (IBAction)doCheck:(UIButton *)sender {
    sender.selected=!sender.selected;
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doSave:(UIBarButtonItem *)sender {
    if ([self.txtName.text isEqual:@""]) {
        [ApplicationUtils MsgBox:@"玩家名称不能为空！"];
        return;
    }
    NSString *SqlStr;
    int maxId;
    if (!self.playerModel) {
        SqlStr=[NSString stringWithFormat:@"Select 1 from playerList Where name='%@'",self.txtName.text];
    }else{
        SqlStr=[NSString stringWithFormat:@"Select 1 from playerList Where name='%@' and id<>%d",self.txtName.text,self.playerModel.playId];
    }
    NSArray *rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
    if (rst.count>0) {
        [ApplicationUtils MsgBox:@"当前已经存在该名称的玩家！"];
        return;
    }
    SqlStr=@"Select max(id) as id from playerList";
    rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
    if (rst.count>0) {
        maxId=[[[rst objectAtIndex:0] objectForKey:@"id"] intValue]+1;
    }else{
        maxId=1;
    }
    if (!self.playerModel) {
        SqlStr =[NSString stringWithFormat:@"Insert into playerList(id,name,closed)Values(%d,'%@',0)",maxId,self.txtName.text];
    } else {
        SqlStr =[NSString stringWithFormat:@"Update playerList set name='%@' Where id=%i",self.txtName.text,self.playerModel.playId];
    }
    if ([[SQLiteManager sharedInstance] executeUpdate:SqlStr]) {
        if ([_delegate respondsToSelector:@selector(doRefresh:)]) {
            [_delegate doRefresh:nil];
        }
        [ApplicationUtils MsgBox:@"玩家保存成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ApplicationUtils MsgBox:@"玩家保存失败！"];
    }
}
@end
