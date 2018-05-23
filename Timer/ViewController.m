//
//  ViewController.m
//  Timer
//
//  Created by make on 2018/5/23.
//  Copyright © 2018年 make. All rights reserved.
//

#import "ViewController.h"
#import "MKCoutDownTimer.h"
@interface ViewController ()
@property (nonatomic, strong)dispatch_source_t time;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __block int i = 0;
    
//    //获得队列
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    //创建一个定时器
//    self.time = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    //设置开始时间
//    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
//    //设置时间间隔
//    uint64_t interval = (uint64_t)(1.0* NSEC_PER_SEC);
//    //设置定时器
//    dispatch_source_set_timer(self.time, start, interval, 0);
//    //设置回调
//    dispatch_source_set_event_handler(self.time, ^{
//
//        NSLog(@"%d",i);
//
//        i++;
//    });
//    //启动定时器 (默认是关闭的)
//    dispatch_resume(self.time);
//
////                dispatch_cancel(self.time);
    
    [self countDown];
    
    
}

- (void)countDown{

 __block MKCoutDownTimer *t =  [MKCoutDownTimer timerWithCountdownTime:60.f rate:1.f executeBlock:^(int second){
        NSLog(@"倒计时%d",second);
        if (second == 50) {
            [t invalidate];
        }
    } endBlock:^{
        NSLog(@"结束");
    }];
}

- (void)openCountdown {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0); // 每秒执行一次
    
    NSTimeInterval seconds = 60.f;
    NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:seconds]; // 最后期限
    
    dispatch_source_set_event_handler(_timer, ^{
        int interval = [endTime timeIntervalSinceNow];
        if (interval > 0) { // 更新倒计时
            NSString *timeStr = [NSString stringWithFormat:@"%d秒后重发", interval];
            dispatch_async(dispatch_get_main_queue(), ^{

                NSLog(@"%@",timeStr);

            });
        } else { // 倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"倒计时结束");
                
            });
        }
    });
    dispatch_resume(_timer);
}



@end
