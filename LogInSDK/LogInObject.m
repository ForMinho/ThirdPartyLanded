//
//  LogInObject.m
//  LogInSDK
//
//  Created by For_Minho on 15-1-29.
//  Copyright (c) 2015年 For_Minho. All rights reserved.
//

#import "LogInObject.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface LogInObject()<TencentSessionDelegate>
@property (strong, nonatomic) TencentOAuth *oauth;
@property (strong, nonatomic) GetUserInfo getUserInfo;
@end

@implementation LogInObject
- (instancetype)init
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GetNotification:) name:UserInfoNotification object:nil];
    return self;
}
+ (instancetype)sharedLogInObject
{
    static LogInObject *object = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        object = [[LogInObject alloc] init];
    });
    return object;
}

+ (NSArray *)AppInstallOnPhone
{
    NSMutableArray *appArr = [[NSMutableArray alloc] init];
    if ([TencentOAuth iphoneQQInstalled]) {
        [appArr addObject:NSStringFromClass([TencentOAuth class])];
    }
    if ([WeiboSDK isWeiboAppInstalled]) {
        [appArr addObject:NSStringFromClass([WeiboSDK class])];
    }
    if ([WXApi isWXAppInstalled]) {
        [appArr addObject:NSStringFromClass([WXApi class])];
    }
    return appArr;
}
#pragma mark -- WeiBo
- (void)LogInWithWeiBo:(GetUserInfo)userInfo
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = WeiBoRedirectUrl;
    [WeiboSDK sendRequest:request];
    self.getUserInfo = userInfo;
}

#pragma mark -- Tencent
- (void)LogInWithTencent:(GetUserInfo)userInfo
{
    self.oauth = [[TencentOAuth alloc] initWithAppId:QQAppKey andDelegate:self];
    NSArray  *_permissions = [NSArray arrayWithObjects:
                              kOPEN_PERMISSION_GET_USER_INFO,
                              kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                              kOPEN_PERMISSION_ADD_ALBUM,
                              kOPEN_PERMISSION_ADD_IDOL,
                              kOPEN_PERMISSION_ADD_ONE_BLOG,
                              kOPEN_PERMISSION_ADD_PIC_T,
                              kOPEN_PERMISSION_ADD_SHARE,
                              kOPEN_PERMISSION_ADD_TOPIC,
                              kOPEN_PERMISSION_CHECK_PAGE_FANS,
                              kOPEN_PERMISSION_DEL_IDOL,
                              kOPEN_PERMISSION_DEL_T,
                              kOPEN_PERMISSION_GET_FANSLIST,
                              kOPEN_PERMISSION_GET_IDOLLIST,
                              kOPEN_PERMISSION_GET_INFO,
                              kOPEN_PERMISSION_GET_OTHER_INFO,
                              kOPEN_PERMISSION_GET_REPOST_LIST,
                              kOPEN_PERMISSION_LIST_ALBUM,
                              kOPEN_PERMISSION_UPLOAD_PIC,
                              kOPEN_PERMISSION_GET_VIP_INFO,
                              kOPEN_PERMISSION_GET_VIP_RICH_INFO,
                              kOPEN_PERMISSION_GET_INTIMATE_FRIENDS_WEIBO,
                              kOPEN_PERMISSION_MATCH_NICK_TIPS_WEIBO,
                              nil];
    [self.oauth authorize:_permissions inSafari:NO];
    self.getUserInfo = userInfo;
}
- (void)tencentDidLogin
{
    if ([self.oauth accessToken] && [[self.oauth accessToken] length]) {
        [self.oauth getUserInfo];
        /*        self.oauth.openId  与qq号一一对应，可以作为唯一标示符     */

    }
}
- (void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户取消登陆" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
- (void)tencentDidNotNetWork
{
    
}
- (void)getUserInfoResponse:(APIResponse *)response
{
    if (response.retCode == URLREQUEST_SUCCEED) {
        NSDictionary *dic = response.jsonResponse;
        [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoNotification object:dic];
    }
}


- (void)GetNotification:(NSNotification *)notification
{
    NSDictionary *dic = notification.object;
    self.getUserInfo(dic);
}

@end
