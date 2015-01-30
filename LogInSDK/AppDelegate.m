//
//  AppDelegate.m
//  LogInSDK
//
//  Created by For_Minho on 15-1-29.
//  Copyright (c) 2015年 For_Minho. All rights reserved.
//

#import "AppDelegate.h"
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate ()<WeiboSDKDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*——————————————————————微博————————————————————*/
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WeiBoAppKey];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WXApi handleOpenURL:url delegate:self] || [WeiboSDK handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WXApi handleOpenURL:url delegate:self] || [WeiboSDK handleOpenURL:url delegate:self] || [TencentOAuth HandleOpenURL:url];
}

+ (AppDelegate *)AppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
#pragma mark -- weibo
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    //调用第三方成功后，获取用户的信息，包括昵称、头像等
    NSLog(@"%@",response.requestUserInfo);
    if ((NSInteger)response.statusCode == 0) {
        WBAuthorizeResponse *wbAuthorize = (WBAuthorizeResponse *)response;
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&source=%@&access_token=%@",wbAuthorize.userID,WeiBoAppKey,wbAuthorize.accessToken]];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request
                                             returningResponse:nil error:nil];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"dic == %@",dic);
        [[NSNotificationCenter defaultCenter] postNotificationName:UserInfoNotification object:dic];
    }
}
@end
