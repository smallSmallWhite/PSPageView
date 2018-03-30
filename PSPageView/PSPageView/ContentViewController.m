//
//  ContentViewController.m
//  PSPageView
//
//  Created by mac on 2018/3/29.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "ContentViewController.h"
#import "PSPageReloadable.h"

@interface ContentViewController ()<PSPageReloadable,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
//类型
@property (nonatomic,strong) NSString *type;


@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark ==================点击标签时的代理方法==================
-(void)clickTitleWithIndex:(NSInteger)index withTitles:(NSMutableArray *)titles withViewController:(UIViewController *)viewController {
    
    _type = titles[index];
    [viewController.view addSubview:self.tableView];
    [self.tableView reloadData];
}
#pragma mark ==================视图滚动时的协议代理方法==================
-(void)contentViewScrollViewCurrentIndex:(NSInteger)currentIndex withTitles:(NSMutableArray *)titles withViewController:(UIViewController *)viewController{
    
    _type = titles[currentIndex];
    [viewController.view addSubview:self.tableView];
    [self.tableView reloadData];
}
#pragma mark ==================点击同一个标签时的协议代理方法==================
-(void)titleViewDidSelectedSameTitle {
    
    NSLog(@"点击了同一个标签");
}
#pragma mark ==================视图停止滚动时的协议代理==================
- (void)contentViewDidEndScroll {
    
    
    
}
#pragma mark ==================tableView代理方法==================
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _type;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 100;
}
#pragma mark ==================懒加载==================
-(UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 88 - 50 - 34) style:UITableViewStylePlain];
        _tableView.scrollEnabled = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
