//
//  WXPayClient.h
//  WechatPayDemo
//
//  Created by Alvin on 3/22/14.
//  Copyright (c) 2014 Alvin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "MDJsonModel.h"

@interface WXPayClient : NSObject

+ (instancetype)shareInstance;

- (void)payProduct:(MDPayTypeModel * ) model withNotify:(NSString *) notify;

@end
