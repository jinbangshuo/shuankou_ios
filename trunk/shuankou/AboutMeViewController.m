//
//  AboutMeViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "AboutMeViewController.h"

@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.lblVersion.text=[NSString stringWithFormat:@"当前版本 V %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
