//
//  PBCollectionViewControllerThree.m
//  BaseViewControllerWithTableViewControllerWithCollectionVC
//
//  Created by 刘贺 on 16/12/15.
//  Copyright © 2016年 com.poba. All rights reserved.
//  https://github.com/liuheisBest/LHExtions
//

#import "PBCollectionViewControllerThree.h"

@interface PBCollectionViewControllerThree ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation PBCollectionViewControllerThree
static NSString * cellID = @"cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isOpenHeaderRefresh = YES;
    self.isOpenFooterRefresh = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 22;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = kRandomColor;
    return cell;
}
- (void)headerRequestWithData{
    NSLog(@"哪个类,执行了什么方法%s",__func__);
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView reloadData];
}

- (void)footerRequestWithData{
    NSLog(@"哪个类,执行了什么方法%s",__func__);
    [self.collectionView.mj_footer endRefreshing];
    [self.collectionView reloadData];
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
