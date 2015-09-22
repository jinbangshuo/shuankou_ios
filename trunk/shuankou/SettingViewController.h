//
//  SettingViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
{
    BOOL bExists;
}
@property (strong, nonatomic) IBOutlet UITextField *txt_p;
@property (strong, nonatomic) IBOutlet UITextField *txt_d;
@property (strong, nonatomic) IBOutlet UITextField *txt_s;
@property (strong, nonatomic) IBOutlet UITextField *txt_max;
@property (strong, nonatomic) IBOutlet UITextField *txt_6;
@property (strong, nonatomic) IBOutlet UITextField *txt_7;
@property (strong, nonatomic) IBOutlet UITextField *txt_8;
@property (strong, nonatomic) IBOutlet UITextField *txt_9;
@property (strong, nonatomic) IBOutlet UITextField *txt_10;
@property (strong, nonatomic) IBOutlet UITextField *txt_11;
@property (strong, nonatomic) IBOutlet UITextField *txt_12;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewBottomDistence;

- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)doSave:(UIBarButtonItem *)sender;
- (IBAction)autoSetJCF:(UITextField *)sender;
- (IBAction)autoSetGXF:(UITextField *)sender;
- (IBAction)hidekeyBoard:(UIControl *)sender;
@end
