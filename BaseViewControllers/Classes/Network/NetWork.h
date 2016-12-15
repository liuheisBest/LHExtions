//
//  NetWork.h
//  RDpublicHealth
//
//  Created by rmbp840 on 16/7/5.
//  Copyright © 2016年 rmbp840. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MBProgressHUD.h"
@interface NetWork : NSObject
+ (void)GETWithUrl:(NSString *)url parameters:(NSDictionary *)parameters view:(UIView *)view ifMBP:(BOOL)mark success:(void(^)(id responseObject))success fail:(void(^)())fail;

+ (void)POSTWithUrl:(NSString *)url parameters:(NSDictionary *)parameters view:(UIView *)view  ifMBP:(BOOL)mark success:(void(^)(id responseObject))success fail:(void(^)())fail;
@end
