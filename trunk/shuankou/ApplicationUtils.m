//
//  ApplicationUtils.m
//  zggqt
//
//  Created by Leo on 13-6-9.
//  Copyright (c) 2013年 Maitianer. All rights reserved.
//

#import "ApplicationUtils.h"

@implementation ApplicationUtils

//提示信息
+ (void) MsgBox:(NSString *)msgStr
{
    UIAlertView *alter=[[UIAlertView alloc] initWithTitle:nil message:msgStr delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alter show];
}

+ (NSString *)formatNumber:(float)num
{
    int iNum=(int)num;
    if (iNum==num) {
        return [NSString stringWithFormat:@"%d",iNum];
    }else{
        return [NSString stringWithFormat:@"%f",num];
    }
}
@end
