//
//  BaseViewController.m
//  MobileProject
//
//  Created by wujunyang on 16/1/5.
//  Copyright © 2016年 wujunyang. All rights reserved.
//

#import "BaseViewController.h"
#import "SXLoadingView.h"
@interface BaseViewController ()
{
    CGFloat navigationY;
    CGFloat navBarY;
    CGFloat verticalY;
    BOOL _isShowMenu;
}
@property CGFloat original_height;
@property (nonatomic,weak) Reachability *hostReach;
@end

@implementation BaseViewController

-(void)viewDidLoad
{
    /**
     *大家可以在这里写一些所以公共类都要做的事情(PS:网络状态的判断)
     */
    [super viewDidLoad];
    //设置所有的背景图为白色
    self.view.backgroundColor = [UIColor whiteColor];
    //监听网络变化
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    self.hostReach = reach;
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(netStatusChange:) name:kReachabilityChangedNotification object:nil];
    //实现监听
    [reach startNotifier];
}


-(void)dealloc
{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//通知监听回调 网络状态发送改变 系统会发出一个kReachabilityChangedNotification通知，然后会触发此回调方法
- (void)netStatusChange:(NSNotification *)noti{
    NSLog(@"-----%@",noti.userInfo);
    //判断网络状态
    switch (self.hostReach.currentReachabilityStatus) {
        case NotReachable:{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"当前网络连接失败，请查看设置" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            }];
            
            UIAlertAction *otherAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
               NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication]canOpenURL:url]) {
                    [[UIApplication sharedApplication]openURL:url];
                }
                
            }];
            
            // Add the actions.
            [alertController addAction:cancelAction];
            [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        }
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi上网2");
            break;
        case ReachableViaWWAN:
            NSLog(@"手机上网2");
            break;
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //基类里面实现 所有子类里面继承
    self.view.backgroundColor = kRandomColor;
}
@end
