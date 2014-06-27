//
//  MDTimerMaro.m
//  OwnerApp
//
//  Created by tinkl on 20/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDTimerMaro.h"


typedef enum {
    MDTimerMaroTypeRunning,
    MDTimerMaroTypePuse,
    MDTimerMaroTypeResume,
    MDTimerMaroTypeClose,
} MDTimerMaroType;

/*!
 *  快件倒计时
 */
@interface MDTimerMaro ()
{
 
    NSTimer * countDownTimer;
    
    SLNumberBlock block;
}

@end

@implementation MDTimerMaro

-(void) startRunningWithTimeADD:(SLNumberBlock) timeNumber forTimeSpace:(unsigned long long ) timers
{
    self.secondsCountDown = timers;
    if (!countDownTimer) {
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethodAdd) userInfo:nil repeats:YES];
    }
    block = timeNumber;
}

-(void)timeFireMethodAdd{
    self.secondsCountDown--;
    block(@(self.secondsCountDown));
    if(self.secondsCountDown==0){
        [countDownTimer invalidate];
    }
}

-(void) startRunningWithTimeMinus:(SLNumberBlock) timeNumber forTimeSpace:(unsigned long long ) timers
{
    self.secondsCountDown = timers;
    if (!countDownTimer) {
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethodMinus) userInfo:nil repeats:YES];
    }
    block = timeNumber;
}

-(void)timeFireMethodMinus{
    self.secondsCountDown++;
    block(@(self.secondsCountDown));
}

-(void) Close
{
    [countDownTimer invalidate];
}

@end
