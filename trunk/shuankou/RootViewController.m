//
//  RootViewController.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "RootViewController.h"
#import "Config.h"

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scaleMenuView = YES;
    self.scaleContentView = YES;
    self.contentViewScaleValue = 0.7;
    self.panGestureEnabled = YES;
}

- (void)awakeFromNib{
    self.leftMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    
    self.contentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NavContentViewController"];
    
    self.rightMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenuViewController"];
}
@end
