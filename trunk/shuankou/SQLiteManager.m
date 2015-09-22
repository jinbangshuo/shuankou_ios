//
//  SQLiteManager.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/15.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "SQLiteManager.h"
#import <FMDB/FMDB.h>

@implementation SQLiteManager

static SQLiteManager *myGolad=nil;
static NSString *dbName=@"data.sqlite";

+ (SQLiteManager *)sharedInstance
{
    if(myGolad==nil)
    {
        myGolad=[[self alloc] init];
        myGolad.version=[NSNumber numberWithInt:1];
        [myGolad update];
    }
    return myGolad;
}

- (FMDatabase *)getDBManager{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [pathArray objectAtIndex:0];
    NSString *sqliteFilePath=[documentsDirectory stringByAppendingPathComponent:dbName];
    return [FMDatabase databaseWithPath:sqliteFilePath];
}

//更新数据库
- (void)update{
    NSNumber *oldVersion=[[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if (!oldVersion || [self.version intValue]>[oldVersion intValue]) {
        NSMutableArray *sqlstrArray=[NSMutableArray array];
        if (!oldVersion) {//刚开始新建
            [sqlstrArray addObject:@"DROP TABLE IF EXISTS recordList;"];
            [sqlstrArray addObject:@"CREATE TABLE recordList (panId text(50,0),staffId integer DEFAULT 0,fdate datetime,findex integer,fcount numeric(18,2),remark text(50,0),UNIQUE (panId COLLATE RTRIM ASC, staffId COLLATE RTRIM ASC));"];
            [sqlstrArray addObject:@"DROP TABLE IF EXISTS playerList;"];
            [sqlstrArray addObject:@"CREATE TABLE playerList (id integer NOT NULL,name text,closed smallint,PRIMARY KEY(id),UNIQUE (id COLLATE RTRIM ASC));"];
            [sqlstrArray addObject:@"DROP TABLE IF EXISTS systemSet;"];
            [sqlstrArray addObject:@"CREATE TABLE systemSet (set_p numeric(18,2),set_d numeric(18,2),set_s numeric(18,2),set_max integer,set_6 numeric(18,2),set_7 numeric(18,2),set_8 numeric(18,2),set_9 numeric(18,2),set_10 numeric(18,2),set_11 numeric(18,2),set_12 numeric(18,2));"];
            //[sqlstrArray addObject:@"CREATE INDEX R1 ON recordList (staffId ASC, fdate ASC, panId ASC);"];
            
            [sqlstrArray addObject:@"INSERT INTO playerList(id,name,closed) VALUES (1, '玩家(1)', 0);"];
            [sqlstrArray addObject:@"INSERT INTO playerList(id,name,closed) VALUES (2, '玩家(2)', 0);"];
            [sqlstrArray addObject:@"INSERT INTO playerList(id,name,closed) VALUES (3, '玩家(3)', 0);"];
            [sqlstrArray addObject:@"INSERT INTO playerList(id,name,closed) VALUES (4, '玩家(4)', 0);"];
            [sqlstrArray addObject:@"INSERT INTO systemSet(set_p,set_d,set_s,set_max,set_6,set_7,set_8,set_9,set_10,set_11,set_12) VALUES (1, 2, 3, 0, 1, 2, 4, 8, 16, 32, 64);"];
        }else{//后期更新
            
        }
        if (sqlstrArray.count>0) {
            [self executeUpdateByTran:sqlstrArray];
        }
        [[NSUserDefaults standardUserDefaults] setValue:self.version forKey:@"version"];
    }
}

//执行事务
-(BOOL)executeUpdate:(NSString*)sqlString
{
    BOOL isOK=NO;
    if (sqlString && ![sqlString isEqualToString:@""]) {
        FMDatabase *dbmanager=[self getDBManager];
        if ([dbmanager open]) {
            isOK=[dbmanager executeUpdate:sqlString];
            [dbmanager close];
            return isOK;
        }else{
            return isOK;
        }
    }else{
        return isOK;
    }
}

//批量执行事务

-(BOOL)executeUpdateByTran:(NSArray *)sqlStrArray
{
    BOOL isOK=NO;
    if (sqlStrArray && sqlStrArray.count>0) {
        FMDatabase *dbmanager=[self getDBManager];
        if ([dbmanager open]) {
            [dbmanager beginTransaction];
            for (int i=0; i<sqlStrArray.count; i++) {
                NSString *sqlstr=[sqlStrArray objectAtIndex:i];
                isOK=[dbmanager executeUpdate:sqlstr];
                if (!isOK) {
                    break;
                }
            }
            if (isOK) {
                [dbmanager commit];
            }else{
                [dbmanager rollback];
            }
            [dbmanager close];
        }
    }
    return isOK;
}

//执行查询
-(NSArray *)executeQuery:(NSString*)sqlString
{
    if (sqlString && ![sqlString isEqualToString:@""]) {
        FMDatabase *dbmanager=[self getDBManager];
        if ([dbmanager open]) {
            FMResultSet *rst=[dbmanager executeQuery:sqlString];
            NSMutableArray *array=[NSMutableArray array];
            while ([rst next]) {
                [array addObject:[rst resultDictionary]];
            }
            [dbmanager close];
            return array;
        }else{
            return nil;
        }
    }else{
        return nil;
    }
}

@end
