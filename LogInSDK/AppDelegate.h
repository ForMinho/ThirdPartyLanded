//
//  AppDelegate.h
//  LogInSDK
//
//  Created by For_Minho on 15-1-29.
//  Copyright (c) 2015年 For_Minho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)AppDelegate;
+ (void)LogInWitWXApi:(SendAuthReq *)req;
@end

