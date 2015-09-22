//
//  ResultViewController.m
//  shuankou
//
//  Created by 邦铄 金 on 15/9/16.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "ResultViewController.h"
#import "ResultModel.h"
#import "SQLiteManager.h"
#import "ApplicationUtils.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (int i=0; i<self.resultArray.count; i++) {
        ResultModel *model=[self.resultArray objectAtIndex:i];
        switch (i) {
            case 0:
                self.lbl_name_1.text=[NSString stringWithFormat:@"%@：",model.name];
                self.lbl_count_1.text=[ApplicationUtils formatNumber:model.count];
                self.lbl_mark_1.text=model.mark;
                break;
            case 1:
                self.lbl_name_2.text=[NSString stringWithFormat:@"%@：",model.name];
                self.lbl_count_2.text=[ApplicationUtils formatNumber:model.count];
                self.lbl_mark_2.text=model.mark;
                break;
            case 2:
                self.lbl_name_3.text=[NSString stringWithFormat:@"%@：",model.name];
                self.lbl_count_3.text=[ApplicationUtils formatNumber:model.count];
                self.lbl_mark_3.text=model.mark;
                break;
            case 3:
                self.lbl_name_4.text=[NSString stringWithFormat:@"%@：",model.name];
                self.lbl_count_4.text=[ApplicationUtils formatNumber:model.count];
                self.lbl_mark_4.text=model.mark;
                break;
                
            default:
                break;
        }
    }
}

- (IBAction)goBack:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)doSaveResult:(UIBarButtonItem *)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd-HHmmss"];
    NSString *panKey = [dateFormatter stringFromDate:[NSDate date]];
    NSMutableArray *sqlstrArray=[NSMutableArray array];
    for (int i=0; i<self.resultArray.count; i++) {
        ResultModel *model=[self.resultArray objectAtIndex:i];
        NSString *sqlstr=[NSString stringWithFormat:@"Insert into recordList(panId,staffId,fdate,findex,fcount,remark)Values('%@',%d,datetime('now','localtime'),%d,%@,'%@')",panKey,model.playId,i+1,[ApplicationUtils formatNumber:model.count],model.mark];
        [sqlstrArray addObject:sqlstr];
    }
    if ([[SQLiteManager sharedInstance] executeUpdateByTran:sqlstrArray]) {
        [ApplicationUtils MsgBox:@"保存成功！"];
        if ([_delegate respondsToSelector:@selector(doClear:)]) {
            [_delegate doClear:nil];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [ApplicationUtils MsgBox:@"保存失败，请重试！"];
    }
}
@end
