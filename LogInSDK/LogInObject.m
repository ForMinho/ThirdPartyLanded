//
//  LogInObject.m
//  LogInSDK
//
//  Created by For_Minho on 15-1-29.
//  Copyright (c) 2015年 For_Minho. All rights reserved.
//

#import "LogInObject.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface LogInObject()<WXApiDelegate,WeiboSDKDelegate>

@end

@implementation LogInObject
+ (instancetype)sharedLogInObject
{
    static LogInObject *object = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        object = [[LogInObject alloc] init];
    });
    return object;
}
#pragma mark -- WeiBo
- (void)LogInWithWeiBo
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WeiBoRedirectUrl;
    [WeiboSDK sendRequest:request];
}


@end
