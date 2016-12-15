//
//  BaseNavigationController.m
//  PBOA
//
//  Created by 刘贺 on 16/12/1.
//  Copyright © 2016年 com.poba. All rights reserved.
//  https://github.com/liuheisBest/LHExtions
//

#import "BaseNavigationController.h"
#import "PBCollectionViewControllerOne.h"
#import "PBCollectionViewControllerTwo.h"
#import "PBCollectionViewControllerThree.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
//设置状态栏为黑色显示
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


//当执行该类的第一个方法之前执行,并且只执行一次
+ (void)initialize {
    //获取当前的导航条---获取到正在显示的导航条
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];
    
    //设置文字颜色
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBA(125, 125, 125, 1.0f)}];
    
    //获取当前的导航按钮---获取到正在显示的导航按钮
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    //设置导航按钮的文字颜色
    item.tintColor = [UIColor whiteColor];
    //文字大小
    [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} forState:UIControlStateNormal];
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

//重写导航控制器的push, 设置子控制器隐藏tabBAr,设置子控制器的自定义后退按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:
         /**
          *把不需要后退按钮的导航控制器 放到这个里面
          */
         [PBCollectionViewControllerOne class]] || [viewController isKindOfClass:[PBCollectionViewControllerTwo class]] ||
        [viewController isKindOfClass:[PBCollectionViewControllerThree class]]) {
        [self deleteBackButton:viewController];
    }else{
        //2 设置子控制器的自定义后退按钮
        [self addBackButton:viewController];
    }
    //真正实现跳转
    @try{
        [super pushViewController:viewController animated:animated];
        
    }
    @catch(NSException *exception) {
        NSLog(@"异常错误是:%@", exception);
    }
    @finally {
        
    }
    
}

- (void)deleteBackButton:(UIViewController *)viewController {
    
    //开启手势后退
    //   self.interactivePopGestureRecognizer.delegate = (id)self;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    //首页 取消回退
    //    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -10;
    self.navigationItem.leftBarButtonItems = @[fixed,fixed];
}
//2 自定义后退按钮
- (void)addBackButton:(UIViewController *)viewController {
    
    
    //开启手势后退
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];
    back.tintColor = [UIColor grayColor];
    //间距
    UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = -10;
    
    viewController.navigationItem.leftBarButtonItems = @[fixed,back];
}

//点击后退的时候执行的方法
- (void)backClick {
    [self popViewControllerAnimated:YES];
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
