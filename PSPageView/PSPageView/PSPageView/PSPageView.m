//
//  PSPageView.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PSPageView.h"
#import "PSPageTitleView.h"
#import "PSPageContentView.h"

@interface  PSPageView ()<PSPageTitleViewDelegate>

@property (nonatomic,strong) PSPageTitleView *titleView;
@property (nonatomic,strong) PSPageContentView *contentView;


@end


@implementation PSPageView

- (instancetype)initWithFrame:(CGRect)frame
                style:(PSPageStyle *)style
               titles:(NSMutableArray *)titles
 childViewControllers:(NSMutableArray *)childViewControllers
             withCurrentIndex:(NSInteger)currentIndex{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _currentIndex = currentIndex;
        self.style = style;
        self.titles = titles;
        self.childViewControllers = childViewControllers;
        //UI相关设置
        [self setBaseUI];
    }
    return self;
}

#pragma mark ==================UI相关设置==================
- (void)setBaseUI {
    
    [self addSubview:self.titleView];
    [self addSubview:self.contentView];
    self.titleView.delegate = self.contentView;
    self.contentView.delegate = self.titleView;
}

#pragma mark ==================懒加载==================
-(PSPageTitleView *)titleView {
    
    if (!_titleView) {
        
        _titleView = [[PSPageTitleView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.style.titleViewHeight) withStyle:self.style withTitles:self.titles withCurrentIndex:_currentIndex withChildViewControllers:self.childViewControllers];
    }
    return _titleView;
}
-(PSPageContentView *)contentView {
    
    if (!_contentView) {
        
        _contentView = [[PSPageContentView alloc] initWithFrame:CGRectMake(0, self.style.titleViewHeight, self.bounds.size.width, self.bounds.size.height - self.style.titleViewHeight) withStyle:self.style withChildViewControllers:self.childViewControllers withStartIndex:_currentIndex withTitles:self.titles];
    }
    return _contentView;
}


@end
