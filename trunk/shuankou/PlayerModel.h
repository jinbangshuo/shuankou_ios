//
//  PlayerModel.h
//  shuankou
//
//  Created by 邦铄 金 on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject

@property (nonatomic, assign) int playId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) bool closed;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
