//
//  PSPageTitleView.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "PSPageTitleView.h"
#import "PSPageStyle.h"
#import "PSPageContentView.h"
// 定义这个常量,就可以在使用Masonry不必总带着前缀 `mas_`:
#define MAS_SHORTHAND
// 定义这个常量,以支持在 Masonry 语法中自动将基本类型转换为 object 类型:
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"

@interface PSPageTitleView () <PSPageContentViewDelegate>
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIView *bottomLine;
@property (nonatomic,strong) UIView  *coverView;
//大小
@property (nonatomic,assign) CGRect currentFrame;
@end

@implementation PSPageTitleView

-(instancetype)initWithFrame:(CGRect)frame withStyle:(PSPageStyle *)style withTitles:(NSMutableArray *)titles withCurrentIndex:(NSInteger)currentIndex  withChildViewControllers:(NSMutableArray *)childControllers {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _currentFrame = frame;
        _titleLabels = [NSMutableArray array];
        self.style = [[PSPageStyle alloc] init];
        self.titles = [NSMutableArray array];
        self.childControllers = childControllers;
        self.style = style;
        self.titles = titles;
        self.currentIndex = currentIndex;
        //UI相关设置
        [self setBaseUI];
        //布局相关
        [self layOutViews];
        
    }
    return self;
   
}

#pragma mark ==================UI相关设置==================
- (void)setBaseUI {
    
    [self addSubview:self.scrollView];
    self.scrollView.backgroundColor = self.style.titleViewBackgroundColor;
    
    //添加头部滚动视图上的文字
    [self setupTitleLabels];
    //设置底部的线条
    [self setUpBottomLine];
    //设置覆盖视图
    [self setUpCoverView];
    //布局
    [self layOutViews];
    
}
#pragma mark ==================布局相关==================
- (void)layOutViews {
    
    self.scrollView.frame = self.bounds;
    //label标签的布局
    [self setupLabelsLayout];
    //下划线的布局
    [self setBottomLineViewLayout];
}
#pragma mark ==================私有方法==================
- (void)setupTitleLabels {
    
    for (int i = 0; i < self.titles.count; i++) {
        
        NSString *title = self.titles[i];
        UILabel *label = [[UILabel alloc] init];
        label.tag = i;
        label.text = title;
        label.textColor = i == self.currentIndex ? self.style.titleSelectedColor : self.style.titleColor;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:self.style.titleFontSize];
        [self.scrollView addSubview:label];
        
        [_titleLabels addObject:label];
        
        //添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tap];
        label.userInteractionEnabled = YES;
    }
}
- (void)setUpBottomLine {
    
    if (self.style.isShowBottomLine) {
        
        [self.scrollView addSubview:self.bottomLine];
    }
}
- (void)setUpCoverView {
    
    if (self.style.isShowCoverView) {
        
        [self.scrollView insertSubview:self.coverView atIndex:0];
        self.coverView.layer.cornerRadius = self.style.coverViewRadius;
        self.coverView.layer.masksToBounds = YES;
    }
}
#pragma mark ==================titleView上面label的布局==================
- (void)setupLabelsLayout {
    
    CGFloat labelH = _currentFrame.size.height;
    CGFloat labelY = 0.0;
    CGFloat labelW = 0.0;
    CGFloat labelX = 0.0;
    NSInteger count = _titleLabels.count;
    //计算全部的宽度
    CGFloat allWidth = 0.0;
    CGFloat width = 0.0;
    for (int i = 0; i < _titleLabels.count; i++) {
        
        UILabel *titleLabel = _titleLabels[i];
        if (self.style.isTitleScrollEnable) {
            
            //可以滚动
            if (i >= 1) {
                
                NSString *title = _titles[i-1];
                UILabel *label = _titleLabels[i - 1];
                NSDictionary *attrs = @{NSFontAttributeName :label.font};
                CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, labelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
                width = rect.size.width + width + self.style.titleMargin * 0.5;
                NSString *title1 = _titles[i];
                NSDictionary *attrs1 = @{NSFontAttributeName :titleLabel.font};
                CGRect rect1 = [title1 boundingRectWithSize:CGSizeMake(MAXFLOAT, labelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs1 context:nil];
                labelW = rect1.size.width;
                allWidth = width + rect1.size.width + self.style.titleMargin * 0.5;
                
            }else{
                
                NSString *title = _titles[i];
                NSDictionary *attrs = @{NSFontAttributeName :titleLabel.font};
                CGRect rect = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, labelH) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil];
                labelW = rect.size.width;
                allWidth = labelW + self.style.titleMargin * 0.5;
            }
            labelX = i == 0 ? self.style.titleMargin * 0.5 : width
            + self.style.titleMargin * 0.5;
            
        }else{
            
            //不可以滚动
            labelW = (self.bounds.size.width) / count;
            labelX = labelW * i;
        }
        titleLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    }
    //TODO:该功能待完善
    if (self.style.isScaleEnable) {
        
      
    }
    //上面可以滑动
    if (self.style.isTitleScrollEnable) {
        self.scrollView.contentSize = CGSizeMake(allWidth, _currentFrame.size.height);
    }
    
}
#pragma mark ==================设置底部下划线的布局==================
- (void)setBottomLineViewLayout {
    
    UILabel *label = _titleLabels[self.currentIndex];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.bottom).offset(0);
        make.height.equalTo(self.style.bottomLineHeight);
        make.width.equalTo(label.frame.size.width);
        make.leading.equalTo(label.leading).offset(0);
    }];
    
}
#pragma mark ==================点击事件回调==================
- (void)titleLabelClick:(UITapGestureRecognizer *)sender {
    
    //点击事件回调
    if (self.clickHandler) {
        
        self.clickHandler(self, sender.view.tag);
    }
    UILabel *targetLabel = (UILabel *)sender.view;
    //当点击同一个按钮时的回调事件
    if (targetLabel.tag == self.currentIndex) {
        
        //点击的按钮和选中的按钮一样
        [self.delegate.reloader titleViewDidSelectedSameTitle];
        return;
    }
    //得到最初选中的label
    UILabel *sourceLabel = _titleLabels[self.currentIndex];
    sourceLabel.textColor = self.style.titleColor;
    targetLabel.textColor = self.style.titleSelectedColor;
    self.currentIndex = targetLabel.tag;
    
    //调整位置到当前点击的位置
    [self adjustLabelPosition:targetLabel];
    
    //点击标签时，底部的视图跟随移动的协议代理方法
    [self.delegate clickTitleView:self withIndex:self.currentIndex];
    
    //展示底部的线
    if (self.style.isShowBottomLine) {
        
        [UIView animateWithDuration:0.25 animations:^{
           
            CGRect frame = self.bottomLine.frame;
            frame.origin.x = targetLabel.frame.origin.x;
            frame.size.width = targetLabel.frame.size.width;
            self.bottomLine.frame = frame;
        }];
    }
}
#pragma mark ==================PSPageContentViewDelegate==================
-(void)contentViewWithIndex:(NSInteger)index withContentView:(PSPageContentView *)contentView {
    
    self.currentIndex = index;
    
    UILabel *targetLabel = _titleLabels[self.currentIndex];
    
    // 2.让targetLabel居中显示
    [self adjustLabelPosition:targetLabel];
    
    [self fixUI:targetLabel];
}
-(void)contentViewWithSourceIndex:(NSInteger)sourceIndex withTargetIndex:(NSInteger)targetIndex withContentView:(PSPageContentView *)contentView {
    
    if (sourceIndex > _titleLabels.count - 1 || sourceIndex < 0) {
        return;
    }
    if (targetIndex > _titleLabels.count - 1 || targetIndex < 0) {
        return;
    }
    UILabel *targetLabel = _titleLabels[targetIndex];
    
    //显示底部下划线的时候
    if (self.style.isShowBottomLine) {
        CGRect frame = self.bottomLine.frame;
        frame.origin.x = targetLabel.frame.origin.x;
        frame.size.width = targetLabel.frame.size.width;
        self.bottomLine.frame = frame;
    }
    
}
#pragma mark ==================调整位置==================
- (void)adjustLabelPosition:(UILabel *)targetLabel {
    
    if (self.style.isTitleScrollEnable) {
        
        //标题可以滚动
        CGFloat offsetX = targetLabel.center.x - self.bounds.size.width * 0.5;
        
        if (offsetX < 0 ){
            offsetX = 0;
        }
        if (offsetX > self.scrollView.contentSize.width - self.scrollView.bounds.size.width) {
            offsetX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
        }
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}
- (void)fixUI:(UILabel *)targetlabel {
    
    [UIView animateWithDuration:0.05 animations:^{
       
        //将全部按钮变为没有选中的颜色
        for (UILabel *titleLabel in _titleLabels) {
            
            titleLabel.textColor = self.style.titleColor;
        }
        targetlabel.textColor = self.style.titleSelectedColor;
    }];
}
#pragma mark ==================懒加载==================
-(UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    return _scrollView;
}
-(UIView *)bottomLine {
    
    if (!_bottomLine) {
        
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = self.style.bottomLineColor;
    }
    return _bottomLine;
}
-(UIView *)coverView {
    
    if (!_coverView) {
        
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = self.style.coverViewBackgroundColor;
        _coverView.alpha = self.style.coverViewAlpha;
    }
    return _coverView;
}

@end
