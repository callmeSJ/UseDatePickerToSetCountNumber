//
//  ViewController.m
//  UseDatePickerToSetCountNumber
//
//  Created by Sj on 16/5/24.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_timeButton addTarget:self action:@selector(startTime) forControlEvents:UIControlEventTouchUpInside];
}

-(void)startTime{
    __block int timeout                = n;
    dispatch_queue_t queue             = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer           = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_timeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
    _timeButton.userInteractionEnabled = YES;

            });
        }else
        {
//            int seconds = timeout % 60;
    int seconds                        = timeout;
    NSString *strTime                  = [NSString stringWithFormat:@"%.2d",seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_timeButton setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
    _timeButton.userInteractionEnabled = NO;

            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
- (IBAction)valueChanged:(UIDatePicker *)sender {
    n                                  = sender.countDownDuration;
    NSLog(@"倒计时时间为%.0f",n);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
