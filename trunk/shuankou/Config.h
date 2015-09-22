//
//  Config.h
//  shuankou
//
//  Created by 邦铄 金 on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#ifndef shuankou_Config_h
#define shuankou_Config_h

//颜色配置
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define BarTintColor            UIColorFromRGB(0x4ab5e1)
#define GrayColor               UIColorFromRGB(0xe3e3e3)
#define LineColor               UIColorFromRGB(0xe7e7e7)
#define MenuBackColor           UIColorFromRGB(0xF5F5F5)
#define Yellow                  UIColorFromRGB(0xff7b00)
#define Green                   UIColorFromRGB(0x678900)

#endif
