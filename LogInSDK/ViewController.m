//
//  ViewController.m
//  LogInSDK
//
//  Created by For_Minho on 15-1-29.
//  Copyright (c) 2015年 For_Minho. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.x = self.view.center.x  - 100;
    rect.origin.y = 100;
   
    rect.size.width = 100;
    rect.size.height = 50;
    
    
    
    NSArray *btnArr = [LogInObject AppInstallOnPhone];
    
    NSString *bundle = [[NSBundle mainBundle] pathForResource:@"ButtonInfo" ofType:@"plist"];
    NSDictionary *infoDic = [[NSDictionary alloc] initWithContentsOfFile:bundle];
    
    for (NSString *temp in btnArr) {
        NSDictionary *tempDic = infoDic[temp];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:rect];
        [btn setTitle:tempDic[ButtonName] forState:UIControlStateNormal];
    
        [btn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
         
        [btn addTarget:self action:NSSelectorFromString(tempDic[Slector]) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        rect.origin.y = CGRectGetMaxY(btn.frame) + 30;
    }
//    [[LogInObject sharedLogInObject] LogInWithWeiBo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)LogInWithTencent
{
    [[LogInObject sharedLogInObject] LogInWithTencent:^(NSDictionary *dic)
    {
        [self showUserInfo:dic];
    }];
}
- (void)LogInWithWeiBo
{
    [[LogInObject sharedLogInObject] LogInWithWeiBo:^(NSDictionary *dic)
     {
         [self showUserInfo:dic];
     }];
}
- (void)LogInWithWX
{
    
}
- (void)showUserInfo:(NSDictionary *)dic
{
    
    NSMutableString *infoStr = [[NSMutableString alloc] init];
    for (id key in dic) {
        [infoStr appendFormat:@"%@:%@ \n",key,dic[key]];
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo" message:infoStr delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

@end
