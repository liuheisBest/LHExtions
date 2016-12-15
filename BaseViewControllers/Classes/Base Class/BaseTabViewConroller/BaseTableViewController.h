//
//  BaseTableViewController.h
//  PBOA
//
//  Created by 刘贺 on 16/12/1.
//  Copyright © 2016年 com.poba. All rights reserved.
//  https://github.com/liuheisBest/LHExtions
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController
//页数索引
@property (nonatomic,assign) NSInteger pageNO;
//每页显示多少条
@property (nonatomic,assign) NSInteger pageSize;
//数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic, strong)   UITableView *tableView;
//开启头部刷新
@property (nonatomic,assign) BOOL  isOpenHeaderRefresh;
//开启脚部刷新
@property (nonatomic,assign) BOOL  isOpenFooterRefresh;

//头部刷新请求 (子类需要重写)
- (void)headerRequestWithData;

- (void)footerRequestWithData;

@end
