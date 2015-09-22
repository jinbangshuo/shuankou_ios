//
//  ResultViewController.h
//  shuankou
//
//  Created by 邦铄 金 on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ContentDelegate <NSObject>
@optional
- (void)doClear:(id)sender;

@end

@interface ResultViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lbl_name_1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name_3;
@property (strong, nonatomic) IBOutlet UILabel *lbl_name_4;

@property (strong, nonatomic) IBOutlet UILabel *lbl_count_1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_count_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_count_3;
@property (strong, nonatomic) IBOutlet UILabel *lbl_count_4;

@property (strong, nonatomic) IBOutlet UILabel *lbl_mark_1;
@property (strong, nonatomic) IBOutlet UILabel *lbl_mark_2;
@property (strong, nonatomic) IBOutlet UILabel *lbl_mark_3;
@property (strong, nonatomic) IBOutlet UILabel *lbl_mark_4;


@property (strong, nonatomic) NSArray *resultArray;
@property (strong, nonatomic) id <ContentDelegate>delegate;

- (IBAction)goBack:(UIBarButtonItem *)sender;
- (IBAction)doSaveResult:(UIBarButtonItem *)sender;
@end
