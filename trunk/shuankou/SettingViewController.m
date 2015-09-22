//
//  SettingViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "SettingViewController.h"
#import "SQLiteManager.h"
#import "ApplicationUtils.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    
    NSString *SqlStr=@"Select set_p,set_d,set_s,set_max,set_6,set_7,set_8,set_9,set_10,set_11,set_12 from systemSet";
    NSArray *rst =[[SQLiteManager sharedInstance] executeQuery:SqlStr];
    if (rst && rst.count>0) {
        NSDictionary *dit=[rst objectAtIndex:0];
        self.txt_p.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_p"]] ;
        self.txt_d.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_d"]];
        self.txt_s.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_s"]];
        if ([@"0" isEqual:[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_max"]]]) {
            self.txt_max.text=@"0";
        }else{
            self.txt_max.text=[NSString stringWithFormat:@"%d",[[dit objectForKey:@"set_max"] intValue]+4];
        }
        self.txt_6.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_6"]];
        self.txt_7.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_7"]];
        self.txt_8.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_8"]];
        self.txt_9.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_9"]];
        self.txt_10.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_10"]];
        self.txt_11.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_11"]];
        self.txt_12.text=[NSString stringWithFormat:@"%@",[dit objectForKey:@"set_12"]];
        bExists=YES;
    }else{
        bExists=NO;
        [self doDefaultAction];
    }
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    CGRect keyBoardRect=[aNotification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    int height = keyBoardRect.size.height;
    self.viewBottomDistence.constant=height;
}

- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    self.viewBottomDistence.constant=0;
}

- (void)doDefaultAction
{
    self.txt_p.text=@"1";
    self.txt_d.text=@"2";
    self.txt_s.text=@"3";
    self.txt_max.text=@"0";
    self.txt_6.text=@"1";
    self.txt_7.text=@"2";
    self.txt_8.text=@"4";
    self.txt_9.text=@"8";
    self.txt_10.text=@"16";
    self.txt_11.text=@"32";
    self.txt_12.text=@"64";
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doSave:(UIBarButtonItem *)sender {
    NSString *SqlStr=@"";
    int sMax;
    if ([self.txt_p.text isEqualToString:@""]) {
        [ApplicationUtils MsgBox:@"请设置基础分！"];
        return;
    }
    if ([self.txt_6.text isEqualToString:@""]) {
        [ApplicationUtils MsgBox:@"请设置贡献分！"];
        return;
    }
    if ([self.txt_max.text isEqual:@""] || [self.txt_max.text isEqual:@"0"]) {
        sMax=0;
    }else{
        sMax=[self.txt_max.text intValue]-4;
        if (sMax<0) {
            sMax=0;
        }
    }
    if (bExists) {
        SqlStr=[NSString stringWithFormat:@"Update systemSet set set_p=%@,set_d=%@,set_s=%@,set_max=%d,set_6=%@,set_7=%@,set_8=%@,set_9=%@,set_10=%@,set_11=%@,set_12=%@",self.txt_p.text,self.txt_d.text,self.txt_s.text,sMax,self.txt_6.text,self.txt_7.text,self.txt_8.text,self.txt_9.text,self.txt_10.text,self.txt_11.text,self.txt_12.text];
    }else{
        SqlStr=[NSString stringWithFormat:@"Insert into systemSet(set_p,set_d,set_s,set_max,set_6,set_7,set_8,set_9,set_10,set_11,set_12)Values(%@,%@,%@,%d,%@,%@,%@,%@,%@,%@,%@)",self.txt_p.text,self.txt_d.text,self.txt_s.text,sMax,self.txt_6.text,self.txt_7.text,self.txt_8.text,self.txt_9.text,self.txt_10.text,self.txt_11.text,self.txt_12.text];
    }
    if ([[SQLiteManager sharedInstance] executeUpdate:SqlStr]) {
        [ApplicationUtils MsgBox:@"保存成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ApplicationUtils MsgBox:@"保存失败，请重试！"];
    }
}

- (IBAction)autoSetJCF:(UITextField *)sender {
    if ([self.txt_p.text isEqualToString:@""]) {
        self.txt_d.text=@"";
        self.txt_s.text=@"";
    }else{
        float p=[self.txt_p.text floatValue];
        self.txt_d.text=[ApplicationUtils formatNumber:p*2];
        self.txt_s.text=[ApplicationUtils formatNumber:p*3];
    }
}

- (IBAction)autoSetGXF:(UITextField *)sender {
    if ([self.txt_6.text isEqualToString:@""]) {
        self.txt_7.text=@"";
        self.txt_8.text=@"";
        self.txt_9.text=@"";
        self.txt_10.text=@"";
        self.txt_11.text=@"";
        self.txt_12.text=@"";
    }else{
        float p=[self.txt_6.text floatValue];
        self.txt_7.text=[ApplicationUtils formatNumber:p*pow(2, 1)];
        self.txt_8.text=[ApplicationUtils formatNumber:p*pow(2, 2)];
        self.txt_9.text=[ApplicationUtils formatNumber:p*pow(2, 3)];
        self.txt_10.text=[ApplicationUtils formatNumber:p*pow(2, 4)];
        self.txt_11.text=[ApplicationUtils formatNumber:p*pow(2, 5)];
        self.txt_12.text=[ApplicationUtils formatNumber:p*pow(2, 6)];
    }
}

- (IBAction)hidekeyBoard:(UIControl *)sender {
    [self.view endEditing:YES];
}
@end
