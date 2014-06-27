//
//  MDTimerMaro.h
//  OwnerApp
//
//  Created by tinkl on 20/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "blocktypedef.h"

@interface MDTimerMaro : NSObject
/*!
 *  倒计时 时间
 */
@property (atomic,assign) unsigned long long secondsCountDown;

/*!
 *  开始计时 递减
 */
-(void) startRunningWithTimeADD:(SLNumberBlock) timeNumber forTimeSpace:(unsigned long long ) timers;

/*!
 *  开始计时 递增
 */
-(void) startRunningWithTimeMinus:(SLNumberBlock) timeNumber forTimeSpace:(unsigned long long ) timers;


/*!
 *  关闭计时
 */
-(void) Close;


@end
