//
//  BaseTableViewController.m
//  PBOA
//
//  Created by 刘贺 on 16/12/1.
//  Copyright © 2016年 com.poba. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, assign)   UITableViewStyle tableViewStyle;


@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNO = 1;
    _pageSize = 15;
    [self.view addSubview:self.tableView];
}
//上拉刷新
- (void)setIsOpenHeaderRefresh:(BOOL)isOpenHeaderRefresh{
    if (_isOpenHeaderRefresh != isOpenHeaderRefresh) {
        
        _isOpenHeaderRefresh = isOpenHeaderRefresh;
        
        WeakSelf(self);
        if (isOpenHeaderRefresh) {
            //设置头部刷新
            self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                weakSelf.pageNO = 1;
                [weakSelf headerRequestWithData];
            }];
            
        }
        
    }
}
//下拉刷新
- (void)setIsOpenFooterRefresh:(BOOL)isOpenFooterRefresh{
    if (_isOpenFooterRefresh != isOpenFooterRefresh) {
        _isOpenHeaderRefresh = isOpenFooterRefresh;
        WeakSelf(self);
        if (isOpenFooterRefresh) {
            self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                weakSelf.pageNO++;
                [weakSelf footerRequestWithData];
                
            }];
        }
    }
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return  _dataArray;
}
- (UITableView *)tableView{
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:_tableViewStyle];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        //去掉多余的行
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //     下面这几行代码是用来设置cell的上下行线的位置
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    //按照作者最后的意思还要加上下面这一段，才能做到底部线控制位置，所以这里按stackflow上的做法添加上吧。
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]){
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}


- (instancetype)initWithTableViewStyle:(UITableViewStyle)tableViewStyle{
    self = [super init];
    if (self) {
        _tableViewStyle = tableViewStyle;
    }
    
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _tableViewStyle = UITableViewStylePlain;
    }
    
    return self;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
//头部刷新请求 (子类需要重写)
- (void)headerRequestWithData{
    
}

- (void)footerRequestWithData{
    
}


@end
