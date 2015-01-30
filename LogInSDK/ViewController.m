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
    rect.origin.x = self.view.center.x;
    rect.origin.y = 100;
   
    rect.size.width = 100;
    rect.size.height = 50;
    UIButton *qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [qqBtn setFrame:rect];
    [qqBtn setTitle:@"QQ" forState:UIControlStateNormal];
    [self.view addSubview:qqBtn];
    
    [[LogInObject sharedLogInObject] LogInWithWeiBo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
