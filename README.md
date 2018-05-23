# CountDownTimer
简单的封装GCD的倒计时，实现了实现了APP在后台倒计时（APP进入后台再返回前台时对比当前的系统时间）
```
 __block MKCoutDownTimer *t =  [MKCoutDownTimer timerWithCountdownTime:60.f rate:1.f executeBlock:^(int second){
        NSLog(@"倒计时%d",second);
        if (second == 50) {
            [t invalidate];
        }
    } endBlock:^{
        NSLog(@"结束");
    }];
```
