//
//  PBCollectionViewControllerOne.m
//  BaseViewControllerWithTableViewControllerWithCollectionVC
//
//  Created by 刘贺 on 16/12/15.
//  Copyright © 2016年 com.poba. All rights reserved.
//

#import "PBCollectionViewControllerOne.h"

@interface PBCollectionViewControllerOne ()

@end

@implementation PBCollectionViewControllerOne
/**
 *大家平时继承自UIViewController的 以后都可以改为继承
 *BaseViewController , 这样可以集中处理一下事情 ,比如网络状态,
 *就不用每个控制器都写了
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
