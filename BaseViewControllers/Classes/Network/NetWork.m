//
//  NetWork.m
//  RDpublicHealth
//
//  Created by rmbp840 on 16/7/5.
//  Copyright © 2016年 rmbp840. All rights reserved.
//

#import "NetWork.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"

@implementation NetWork
+ (void)GETWithUrl:(NSString *)url parameters:(NSDictionary *)parameters view:(UIView *)view ifMBP:(BOOL)mark success:(void(^)(id responseObject))success fail:(void(^)())fail{
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <=0) {
            MBProgressHUD *mb1 = [MBProgressHUD showHUDAddedTo:view animated:YES];
            mb1.mode = MBProgressHUDModeText;
            mb1.labelText = @"请检查网络连接";
            [mb1 hide:YES afterDelay:1];
 
        }
        else{
            if (mark == YES) {
                MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
                mb.mode = MBProgressHUDModeIndeterminate;
                mb.labelText = @"数据加载中...";
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                manager.requestSerializer.timeoutInterval = 30.0f;
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
                
                [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (responseObject) {
                        
                        [mb removeFromSuperview];
                        if (success) {
                            if ([responseObject[@"code"] integerValue] == 404) {
                                [SXLoadingView showAlertHUD:@"网络不给力" duration:2];
                                [self haha];
                            }else if([responseObject[@"code"] integerValue] == 1){
                                success(responseObject);
                            }else{
                                [SXLoadingView showAlertHUD:responseObject[@"text"] duration:2];
                            }
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    mb.mode = MBProgressHUDModeText;
                    mb.labelText = @"数据请求失败";
                    [mb hide:YES afterDelay:1];
                        if (fail) {
                            fail(error);
                        }
                        NSLog(@"<<<%@",error);
                }];
            }else{
                
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.requestSerializer.timeoutInterval = 30.0f;
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
                [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (responseObject) {
                        if (success) {
                            if ([responseObject[@"code"] integerValue] == 404) {
                                [SXLoadingView showAlertHUD:@"网络不给力" duration:2];
                                [self haha];
                            }else if([responseObject[@"code"] integerValue] == 1){
                                success(responseObject);
                            }else{
                                [SXLoadingView showAlertHUD:responseObject[@"text"] duration:2];
                            }
                        }
                    }
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (fail) {
                        fail(error);
                    }
                    NSLog(@">>>%@",error);

                }];
            }
        }
    }];
}

+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)parameters view:(UIView *)view  ifMBP:(BOOL)mark success:(void(^)(id responseObject))success fail:(void(^)())fail{
    NSLog(@"%@---%@",url,parameters);
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status <=0) {
//            MBProgressHUD *mb1 = [MBProgressHUD showHUDAddedTo:view animated:YES];
//            mb1.mode = MBProgressHUDModeText;
//            mb1.labelText = @"请检查网络连接";
//            [mb1 hide:YES afterDelay:110];
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请检查网络连接" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"朕知道了", nil];
            [alert show];
        }else{
            if (mark == YES) {
                MBProgressHUD *mb = [MBProgressHUD showHUDAddedTo:view animated:YES];
                mb.mode = MBProgressHUDModeIndeterminate;
                mb.labelText = @"数据加载中...";
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.requestSerializer.timeoutInterval = 30.0f;
                manager.requestSerializer=[AFHTTPRequestSerializer serializer];
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif",nil];
                
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
                
                [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"%@",responseObject);
                    if (responseObject) {
                        
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                        [mb removeFromSuperview];
                        if (success) {
                            if ([responseObject[@"code"] integerValue] == 404) {
                                [SXLoadingView showAlertHUD:@"网络不给力" duration:2];
                                [self haha];
                            }else if([responseObject[@"code"] integerValue] == 200){
                                success(responseObject);
                            }else{
                                if ([responseObject[@"text"] isEqualToString:@"success"]||[responseObject[@"text"] isEqualToString:@""]) {
                                    
                                }else{
                                [SXLoadingView showAlertHUD:responseObject[@"text"] duration:2];
                                }
                            }
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    mb.mode = MBProgressHUDModeText;
                    mb.labelText = @"数据请求失败";
                    [mb hide:YES afterDelay:1];
                    if (fail) {
                        fail(error);
                    }
                    NSLog(@"==%@",error);
                }];
            }else{
                
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                manager.responseSerializer = [AFJSONResponseSerializer serializer];
                manager.requestSerializer.timeoutInterval = 30.0f;
                manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
                [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (responseObject) {
                        if (success) {
                            if ([responseObject[@"code"] integerValue] == 404) {
                                [SXLoadingView showAlertHUD:@"网络不给力" duration:2];
                                [self haha];
                            }else if([responseObject[@"code"] integerValue] == 1){
                                success(responseObject);
                            }else{
                                [SXLoadingView showAlertHUD:responseObject[@"text"] duration:2];
                            }
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (fail) {
                        fail(error);
                    }
                    NSLog(@"---%@",error);
                }];
            }
        }
    }];
}

+ (void)haha{
    [kUserDefaults  setObject:@"" forKey:@"userid"];
    [kUserDefaults setObject:@"" forKey:@"token"];

    [kUserDefaults setObject:@"" forKey:@"autoLogin"];
    [kUserDefaults synchronize];
    NSNotification *notification =[NSNotification notificationWithName:@"shoppingNum" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    });
    
//    [[RCIMClient sharedRCIMClient] logout];
    UIViewController * login = [[UIViewController alloc]init];
    //    takeVC.title = @"本闻学院";
    BaseNavigationController * vc = [[BaseNavigationController alloc]initWithRootViewController:login];
    AppDelegate * app =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.window.rootViewController = vc;

}
@end
