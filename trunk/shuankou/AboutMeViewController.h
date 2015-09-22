//
//  AboutMeViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblVersion;

- (IBAction)goBack:(UIBarButtonItem *)sender;
@end
