//
//  AFAppDotNetAPIClient6.m
//  AFNetworking iOS Example
//
//  Created by apple on 4/17/14.
//  Copyright (c) 2014 Gowalla. All rights reserved.
//

#import "AFAppDotNetAPIClient6.h"

#import "AFNetworkActivityIndicatorManager.h"

@implementation AFAppDotNetAPIClient6
// static NSString * const AFAppDotNetAPIBaseURLString = @"http://192.168.31.156:9292/";
 static NSString * const AFAppDotNetAPIBaseURLString = @"http://112.124.15.115:13131/";

+ (AFAppDotNetAPIClient6 *)sharedClient {
//    NSString * kAPIBaseURLString =[USER_DEFAULT valueForKey:KeyChain_yunqi_account_notifyServerhostName];
    static AFAppDotNetAPIClient6 *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AFAppDotNetAPIClient6 alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        [_sharedClient setSecurityPolicy:[AFSecurityPolicy defaultPolicy]];
    });
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    return _sharedClient;
}

@end
