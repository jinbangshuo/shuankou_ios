//
//  ResultModel.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultModel : NSObject

@property(assign, nonatomic) int playId;
@property(strong, nonatomic) NSString *name;
@property(assign, nonatomic) float count;
@property(strong, nonatomic) NSString *mark;

- (id)initWithDictionary:(int) playId name:(NSString *)name count:(float) count mark:(NSString *) mark;
- (NSString *)toString;
@end
