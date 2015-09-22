//
//  SQLiteManager.h
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLiteManager : NSObject

@property(strong,nonatomic) NSNumber *version;

+ (SQLiteManager *)sharedInstance;
-(BOOL)executeUpdate:(NSString*)sqlString;
-(BOOL)executeUpdateByTran:(NSArray *)sqlStrArray;
-(NSArray *)executeQuery:(NSString*)sqlString;

@end
