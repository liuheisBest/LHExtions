//
//  MainViewController.m
//  PBOA
//
//  Created by 刘贺 on 16/12/6.
//  Copyright © 2016年 com.poba. All rights reserved.
//  https://github.com/liuheisBest/LHExtions
//
#define kClassKey   @"rootVCClassString"
#define kTitleKey   @"title"
#define kImgKey     @"imageName"
#define kSelImgKey  @"selectedImageName"
#define Global_tintColor [UIColor colorWithRed:(68 / 255.0) green:(192 / 255.0) blue:(250 / 255.0) alpha:1]

#import "MainViewController.h"
#import "BaseNavigationController.h"
#import "PBCollectionViewControllerOne.h"
#import "PBCollectionViewControllerTwo.h"
#import "PBCollectionViewControllerThree.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *childItemsArray = @[
                                 @{kClassKey  : [PBCollectionViewControllerOne description],
                                   kTitleKey  : @"工作台",
                                   kImgKey    : @"w01",
                                   kSelImgKey : @"w02"},
                                 
                                 @{kClassKey  : [PBCollectionViewControllerTwo description],
                                   kTitleKey  : @"项目管理",
                                   kImgKey    : @"project01",
                                   kSelImgKey : @"project02"},
                                 
                                 @{kClassKey  : [PBCollectionViewControllerThree description],
                                   kTitleKey  : @"知识库",
                                   kImgKey    : @"knows01",
                                   kSelImgKey : @"knows02"}];
    
    [childItemsArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
        UIViewController *vc = [NSClassFromString(dict[kClassKey]) new];
        vc.title = dict[kTitleKey];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.title = dict[kTitleKey];
        item.image = [UIImage imageNamed:dict[kImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[kSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : Global_tintColor} forState:UIControlStateSelected];
        [self addChildViewController:nav];
    }];
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
