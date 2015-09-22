//
//  ResultModel.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "ResultModel.h"

@implementation ResultModel

- (id)initWithDictionary:(int) playId name:(NSString *)name count:(float) count mark:(NSString *) mark{
    self=[super init];
    if (self) {
        self.playId=playId;
        self.name=name;
        self.count=count;
        self.mark=mark;
    }
    return self;
}

- (NSString *)toString
{
    return [NSString stringWithFormat:@"playId=%d name=%@ count=%f mark=%@",self.playId,self.name,self.count,self.mark];
    
}

@end
