//
//  PlayerModel.m
//  shuankou
//
//  Created by 邦铄 金 on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel

- (id)initWithDictionary:(NSDictionary *)dic{
    self=[super init];
    if (self) {
        self.playId=[[dic objectForKey:@"id"] intValue];
        self.name=[dic objectForKey:@"name"];
        self.closed=NO;
    }
    return self;
}

@end
