//
//  ScoreTableViewCell.m
//  shuankou
//
//  Created by jinbangshuo on 15/9/17.
//  Copyright (c) 2015年 温州市麦田儿网络科技有限公司. All rights reserved.
//

#import "ScoreTableViewCell.h"
#import "Config.h"
#import "ApplicationUtils.h"

@implementation ScoreTableViewCell

- (void)setModel:(ScoreModel *)model{
    if (!model) {
        return;
    }
    _model = model;
    self.lblName.text=model.title;
    self.lblScore.text=[ApplicationUtils formatNumber:model.aScore];
    
    float fWidth=0;
    float count=fabs(model.aScore);
    float maxlen=model.maxWidth;
    if (model.allAcore == 0.0) {
        fWidth = 11.0f;
    } else {
        fWidth = (count * 1.0 / model.allAcore) * maxlen * (2.0f / 3.0f);
    }
    if (fWidth == 0.0) {
        fWidth = 11.0f;
    }
    if (fWidth>maxlen) {
        fWidth=maxlen;
    }
    self.viewWidthConstr.constant=fWidth;
    self.viewScore.layer.cornerRadius=3.0;
    if (model.aScore>0) {
        self.viewScore.backgroundColor=Yellow;
    }else{
        self.viewScore.backgroundColor=Green;
    }
}

@end
