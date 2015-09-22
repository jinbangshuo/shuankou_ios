//
//  ScoreModel.h
//  shuankou
//
//  Created by 金邦铄 on 14-5-23.
//  Copyright (c) 2014年 金邦铄. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreModel : NSObject

@property (nonatomic, assign) float aScore;
@property (assign, nonatomic) float allAcore;
@property (assign, nonatomic) float maxWidth;
@property (nonatomic, strong) NSString *title;
@end
