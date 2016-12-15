//
//  MDYAFHelp.m
//  MDYNews
//
//  Created by Medalands on 15/2/26.
//  Copyright (c) 2015年 Medalands. All rights reserved.
//


#define NetTimeOutInterval 15.f


#import "MDYAFHelp.h"
#import "AppDelegate.h"
#import "BaseNavigationController.h"
@implementation MDYAFHelp

/**
 * 给每次的请求加上 默认必须添加的参数 比如版本号（版本升级时 不同的版本分别处理） 渠道号 (Appstore 和越狱的一些渠道如：91手机助手、同步推)
 
 手机型号（区分安卓和iPhone 在需要的时候做不同的处理）
 */
+(void)setDefaultParamToDic:(NSMutableDictionary *)dic
{
    if (dic)
    {
        // 版本号 参数
        NSString * versionParam = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        
        // 渠道号 参数
        NSString * unionIdParam = @"000"; // 和后台约定的任意字符 120 或 182 或 123
        
        // 手机型号 参数
        NSString * osParam = @"iphone"; // iphone android
        
        
        // 添加参数
        [dic setObject:versionParam forKey:@"versionParam"];
        
        [dic setObject:unionIdParam forKey:@"unionIdParam"];
        
        [dic setObject:osParam forKey:@"osParam"];
        
    }
    
    
}


+(void)AFGetHost:(NSString *)hostString bindPath:(NSString *)bindPath param:(NSMutableDictionary *)dic success:(void(^)(id responseObject))success failure:(void(^)())failure
{
    [MDYAFHelp setDefaultParamToDic:dic];
    
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [manager GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (failure) {
            failure(error);
        }
    }];
    
    
    
    
}



+(void)AFPostHost:(NSString *)hostString bindPath:(NSString *)bindPath postParam:(NSMutableDictionary *)postParam getParam:(NSMutableDictionary *)getParam success:(void(^)(id responseObject))success failure:(void(^)())failure
{
    
    NSString* url = [NSString stringWithFormat:@"%@%@",hostString,bindPath];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", @"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.allowInvalidCertificates = YES;
    /**
     * NSString *cookieValue = @"AQIC5wM2LY4SfcxpzbIz4Pm51J82O5VFMd50x_es65I1DNU.*AAJTSQACMDEAAlNLABM1NjQ2MDM4ODMzNDI0NDkxOTcy*,JSESSIONID=50B3DDCD8ADDA7ACB3E5C36EFD0BB62F";
     NSString *cookieKey = @"iPlanetDirectoryPro";    //Cookie的基本设置
     NSDictionary *properties = [[NSMutableDictionary alloc] init];
     [properties setValue:cookieValue forKey:NSHTTPCookieValue];
     [properties setValue:cookieKey forKey:NSHTTPCookieName];
     [properties setValue:@"" forKey:NSHTTPCookieDomain];
     [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
     [properties setValue:@"/" forKey:NSHTTPCookiePath];
     NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
     NSArray *cookies=[NSArray arrayWithObjects:cookie,nil];
     NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
     NSMutableDictionary *dic = [NSMutableDictionary dictionary];
     [dic setObject:tokenIdValue forKey:tokenIdKey];
     AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
     //将Cookie绑定request请求
     [manager.requestSerializer setValue:[headers objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
     */
//    NSString *cookieValue = kToken;
//    NSString *cookieKey = @"JSESSIONID";    //Cookie的基本设置
//    NSDictionary *properties = [[NSMutableDictionary alloc] init];
//    [properties setValue:cookieValue forKey:NSHTTPCookieValue];
//    [properties setValue:cookieKey forKey:NSHTTPCookieName];
//    [properties setValue:@"" forKey:NSHTTPCookieDomain];
//    [properties setValue:[NSDate dateWithTimeIntervalSinceNow:60*60] forKey:NSHTTPCookieExpires];
//    [properties setValue:@"/" forKey:NSHTTPCookiePath];
//    //新建NSHTTPCookie
//    NSHTTPCookie *cookie = [[NSHTTPCookie alloc] initWithProperties:properties];
//    //添加到数组
//    NSArray *cookies=[NSArray arrayWithObjects:cookie,nil];
//    //放进请求头
//    NSDictionary *headers=[NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//    //将Cookie绑定request请求
//    [manager.requestSerializer setValue:[headers objectForKey:@"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    manager.securityPolicy = securityPolicy;
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [manager POST:url parameters:postParam progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            NSLog(@"%@",responseObject);
            NSInteger code= [responseObject[@"code"] integerValue];
            if ( code == 404) {
                [SXLoadingView showAlertHUD:@"网络不给力" duration:2];
                [self haha];
            }else if(code == 1|| code == 200){
                success(responseObject);
            }else{
                [SXLoadingView showAlertHUD:responseObject[@"text"] duration:2];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (failure) {
            failure(error);
        }
    }];
    
    NSLog(@"AFPost:%@",url);
    NSLog(@"AFPostDic:%@",postParam);
    
    
    
    
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
    
    //    takeVC.title = @"本闻学院";
    BaseNavigationController * vc = [[BaseNavigationController alloc]initWithRootViewController:[UIViewController new]];
    AppDelegate * app =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.window.rootViewController = vc;
    
}

+(NSString *)setParamDIc:(NSMutableDictionary *)paramDic toUrlString:(NSString *)url
{
    //选填get参数
    if (paramDic) {
        
        NSRange range = [url rangeOfString:@"?"];
        
        if (range.location != NSNotFound) // 有 ？ 问好 表示 就有 参数 可以直接 用 & 添加
        {
            NSArray *arrK = [paramDic allKeys];
            for (int i = 0; i<[arrK count]; i++) {
                url = [NSString stringWithFormat:@"%@&%@=%@",url,[arrK objectAtIndex:i],[paramDic objectForKey:[arrK objectAtIndex:i]]];
            }
            
        }else // 没有问号 表示没有参数 第一个参数 要用？value= 添加 从第二个 开始 用 & 添加
        {
            NSArray *arrK = [paramDic allKeys];
            for (int i = 0; i<[arrK count]; i++) {
                
                if (i == 0)
                {
                    url = [NSString stringWithFormat:@"%@?%@=%@",url,[arrK objectAtIndex:i],[paramDic objectForKey:[arrK objectAtIndex:i]]];
                }else
                {
                    url = [NSString stringWithFormat:@"%@&%@=%@",url,[arrK objectAtIndex:i],[paramDic objectForKey:[arrK objectAtIndex:i]]];
                }
            }
        }
    }
    return url;
}


#pragma mark -
#pragma mark 取消网络请求
+ (void)cancelAllRequest {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.operationQueue cancelAllOperations];
}

@end
