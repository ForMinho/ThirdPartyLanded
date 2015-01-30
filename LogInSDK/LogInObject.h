//
//  LogInObject.h
//  LogInSDK
//
//  Created by For_Minho on 15-1-29.
//  Copyright (c) 2015年 For_Minho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LogInObject : NSObject

@property (nonatomic, strong) NSDictionary *info;

+ (instancetype)sharedLogInObject;
- (void)LogInWithWeiBo;
@end
