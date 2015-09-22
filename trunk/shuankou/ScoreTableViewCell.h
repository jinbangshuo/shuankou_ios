//
//  ScoreTableViewCell.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreModel.h"

@interface ScoreTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIView *viewScore;
@property (strong, nonatomic) IBOutlet UILabel *lblScore;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewWidthConstr;

@property (strong, nonatomic) ScoreModel *model;
@end
