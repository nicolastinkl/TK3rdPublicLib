//
//  AFAppAPIClient.m
//  Kidswant
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 xianchangjia. All rights reserved.
//

#import "AFAppAPIClient.h"
#import "AFNetworkActivityIndicatorManager.h"


//static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.31.156:9292/";
 static NSString * const AFAppDotNetAPIBaseURLString = @"http://112.124.15.115:13131/";

@implementation AFAppAPIClient

+ (instancetype)sharedClient {
    static AFAppAPIClient *_sharedClient = nil;
//    NSString * kAPIBaseURLString =[USER_DEFAULT valueForKey:KeyChain_yunqi_account_notifyServerhostName];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy defaultPolicy]];
    });
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    return _sharedClient;
}

@end
