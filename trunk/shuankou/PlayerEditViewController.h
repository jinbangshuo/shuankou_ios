//
//  PlayerEditViewController.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerModel.h"

@protocol listDelegate <NSObject>
@optional
- (void)doRefresh:(id)sender;

@end

@interface PlayerEditViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtName;
@property (strong, nonatomic) IBOutlet UIButton *btnUnuse;
@property (strong, nonatomic) PlayerModel *playerModel;
@property (strong, nonatomic) id <listDelegate>delegate;

- (IBAction)doCheck:(UIButton *)sender;
- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)doSave:(UIBarButtonItem *)sender;

@end
