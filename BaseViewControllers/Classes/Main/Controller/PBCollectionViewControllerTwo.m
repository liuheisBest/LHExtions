//
//  PBCollectionViewControllerTwo.m
//  BaseViewControllerWithTableViewControllerWithCollectionVC
//
//  Created by 刘贺 on 16/12/15.
//  Copyright © 2016年 com.poba. All rights reserved.
//

#import "PBCollectionViewControllerTwo.h"

@interface PBCollectionViewControllerTwo ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation PBCollectionViewControllerTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //开启头部刷新
    self.isOpenHeaderRefresh = YES;
    //开始脚部刷新
    self.isOpenFooterRefresh = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    /**
     *PS:这里面需要注意的是开启顺序,先开启头部
     */
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellID = @"cellid";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.contentView.backgroundColor = kRandomColor;
    
    return cell;
}
- (void)headerRequestWithData{
    NSLog(@"哪个类,执行了什么方法%s",__func__);
    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
}

- (void)footerRequestWithData{
    NSLog(@"哪个类,执行了什么方法%s",__func__);
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
