//
//  RootViewController.m
//  test
//
//  Created by 王鑫 on 16/4/5.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController {
    UILabel *label;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // set backgroud
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"game test.jpg"];
    [self.view addSubview:imageview];
    // set button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"开始游戏" forState:UIControlStateNormal];
    button.frame = CGRectMake(140, 500, 85, 50);
    [button setTintColor:[UIColor colorWithRed:231 / 256.0 green:121 / 256.0 blue:132 / 256.0 alpha:1.0]];
    button.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:button];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 2;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    // globel label
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, button.frame.origin.y + 100, self.view.frame.size.width, 30)];
    label.backgroundColor = [UIColor blackColor];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger i =[defaults integerForKey:@"fen"];
    label.text = [NSString stringWithFormat:@"最高分记录:%ld分",(long)i];
    [self.view addSubview:label];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - Method viewWillAppear:(BOOL)animated
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    NSInteger i =[de integerForKey:@"fen"];
    label.text = [NSString stringWithFormat:@"最高分记录:%ld分",(long)i];
}

#pragma mark - Method click
- (void)click {
    ViewController *vvv = [ViewController new];
    [self presentViewController:vvv animated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
