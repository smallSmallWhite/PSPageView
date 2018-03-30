//
//  PSPageStyle.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PSPageStyle.h"

@implementation PSPageStyle

-(instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.isTitleScrollEnable = NO;
        self.titleColor = [UIColor blackColor];
        self.titleViewHeight = 30;
        self.titleSelectedColor = [UIColor blueColor];
        self.titleFontSize = 15;
        self.titleViewBackgroundColor = [UIColor whiteColor];
        self.titleMargin = 20;
        self.isShowBottomLine = NO;
        self.bottomLineColor = [UIColor blueColor];
        self.bottomLineHeight = 2;
        self.isScaleEnable = NO;
        self.maximumScaleFactor = 1.2;
        self.isShowCoverView = NO;
        self.contentViewBackgroundColor = [UIColor blackColor];
        self.coverViewAlpha = 0.4;
        self.coverMargin = 8;
        self.coverViewHeight = 25;
        self.coverViewRadius = 12;
        self.isContentScrollEnable = YES;
        self.contentViewBackgroundColor = [UIColor whiteColor];
    }
    return self;
}


@end
