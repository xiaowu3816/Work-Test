//
//  ViewController.m
//  test
//
//  Created by 王鑫 on 16/4/5.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "RootViewController.h"
#define WIDTH self.view.bounds.size.width
#define HEIGHT  self.view.bounds.size.height

@interface ViewController ()<UIAlertViewDelegate>

@property(nonatomic, strong)UILabel *CMAlabel; /**< 加速度 */
@property(nonatomic, strong)CMMotionManager *motionManager;
@property(nonatomic, assign)CGFloat changeX;
@property(nonatomic, assign)CGFloat changeY;

@property(nonatomic, assign)NSInteger tag;
@property(nonatomic, assign)NSInteger changetag;
@property(nonatomic, retain)UIView *dview;
@property(nonatomic, retain)UILabel *scorelabel;
@property(nonatomic, retain)NSTimer *timer;

@end

@implementation ViewController {
    UIView * view;
    CGFloat X ;
    CGFloat Y ;
    NSInteger score;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.changetag = 100;
    self.view.backgroundColor = [UIColor whiteColor];

    //创建CMMotionManager
    self.motionManager = [[CMMotionManager alloc] init];
    //创建子线程来更新数据
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    if (self.motionManager.accelerometerAvailable) {
        //设置CMMotionManager的加速度读更新频率;
        self.motionManager.accelerometerUpdateInterval = 0.02;
        //使用代码块开始获取加速度的数据
        [self.motionManager startAccelerometerUpdatesToQueue:queue withHandler:^(CMAccelerometerData *   accelerometerData, NSError *   error) {
            if (error) {
                //停止获取加速度数据
                [self.motionManager stopAccelerometerUpdates];
            } else {
                self.changeX = accelerometerData.acceleration.x;
                self.changeY = accelerometerData.acceleration.y;
            }
        
        }];
    } else {
        NSLog(@"该设备不支持获取加速度数据");
    }
    
    X = 0.3;
    Y = -0.3;
    
    self.dview = [[UIView alloc] init];
    self.dview.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.dview];
    self.dview.layer.cornerRadius = 5;
    
    // create random point
    [self makePoint];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(click) userInfo:nil repeats:YES];
    
    self.tag = 10000;
    
    self.scorelabel = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH - 60, 12, WIDTH, 30)];
    [self.view addSubview:self.scorelabel];
    self.scorelabel.font = [UIFont systemFontOfSize:20];
    self.scorelabel.center = self.view.center;
    self.scorelabel.text = [NSString stringWithFormat:@"得分:0"];
    self.scorelabel.textAlignment = NSTextAlignmentCenter;
}
// create random point
- (void)makePoint {
    NSInteger xx = self.view.bounds.size.width - 20;
    NSInteger x = arc4random() % xx + 10;
    
    NSInteger yy = self.view.bounds.size.height - 20;
    NSInteger y = arc4random() % yy+ 10;
    self.dview.frame = CGRectMake(x, y, 10, 10);
    self.dview.backgroundColor = [UIColor yellowColor];
}

#pragma mark - Method click
- (void)click{
    
    if (fabs(self.changeX) > 0.3 ||fabs(self.changeY) > 0.3 ) {
        if (fabs(self.changeX) < 1 ||fabs(self.changeY) < 1) {
            X = self.changeX;
            Y = self.changeY;
        }
    
    }
    // 设置越屏的状态
    if (view.frame.origin.x > WIDTH) {
        view = [[UIView alloc]initWithFrame:CGRectMake(0, view.frame.origin.y, 10, 10)];
        
    }
    if (view.frame.origin.y > HEIGHT) {
        view = [[UIView alloc]initWithFrame:CGRectMake(view.frame.origin.x, 0, 10, 10)];
        
    }
    if (view.frame.origin.x < 0) {
        view = [[UIView alloc]initWithFrame:CGRectMake(WIDTH, view.frame.origin.y, 10, 10)];
        
    }
    if (view.frame.origin.y < 0) {
        view = [[UIView alloc]initWithFrame:CGRectMake(view.frame.origin.x, HEIGHT, 10, 10)];
    
    }
    
    view = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x + X, view.frame.origin.y - Y, 10, 10)];
    view.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                      saturation:( arc4random() % 256 / 256.0 )
                                      brightness:( arc4random() % 256 / 256.0 )
                                           alpha:1];
    for (UIView *temp in [self.view subviews]) {
        if (temp.tag > 10000) {
            temp.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                              saturation:( arc4random() % 256 / 256.0 )
                                              brightness:( arc4random() % 256 / 256.0 )
                                                   alpha:1];
        }
    }
    
    view.tag = self.tag++;
    view.layer.cornerRadius = 5;
    [[self.view viewWithTag:self.tag - self.changetag] removeFromSuperview];
    if (fabs(view.center.x - self.dview.center.x) < 7  && fabs(view.center.y - self.dview.center.y) < 7) {
        self.changetag += 7;
        [self makePoint];
        score += 1;
        self.scorelabel.text = [NSString stringWithFormat:@"得分:%ld",(long)score];
    
    } else {
        
        for (UIView *hisself in [self.view subviews]) {
            if (fabs(view.center.x - hisself.center.x) < 5 && fabs(view.center.y - hisself.center.y) < 5 && hisself.tag > 10000 && hisself.tag < self.tag - 30) {
                [self.timer invalidate];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"游戏结束" message:[NSString stringWithFormat:@"得分:%ld", (long)score] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
                [controller addAction:cancel];
                [self presentViewController:controller animated:YES completion:nil];
                NSInteger i =[defaults integerForKey:@"fen"];
                score = score > i ? score:i;
                [defaults setInteger:score forKey:@"fen"];
                
            }
        }
    }
    
    [self.view addSubview:view];
    
}

#pragma mark - Method prefersStatusBarHidden
- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Mthod push first controller
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    RootViewController *rootVC = [[RootViewController alloc] init];
    [self presentViewController:rootVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
