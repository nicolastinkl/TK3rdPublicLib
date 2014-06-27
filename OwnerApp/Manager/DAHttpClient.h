//
//  DAHttpClient.h
//  Kidswant
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 xianchangjia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "blocktypedef.h"


@interface DAHttpClient :  AFHTTPSessionManager
{
	NSString        *_apiBaseUrlString;
}

+ (DAHttpClient *)sharedDAHttpClient;

- (NSURLSessionDataTask *)getRequestWithParameters:(NSMutableDictionary *) parames Action:(NSString *) action success:(SLObjectBlock)success error:(SLIndexBlock)error;


- (NSURLSessionDataTask *) postRequestWithParameters:(NSMutableDictionary *) parames Action:(NSString *) action success:(SLObjectBlock)success error:(SLIndexBlock)error;


-(void) downloadFileReturnMd5:(SLObjectBlock) md5;

@end
