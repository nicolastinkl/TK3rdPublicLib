//
//  DAHttpClient.m
//  Kidswant
//
//  Created by apple on 13-10-14.
//  Copyright (c) 2013年 xianchangjia. All rights reserved.
//

#import "DAHttpClient.h"
#import "SINGLETONGCD.h"
#import "AFAppAPIClient.h"
#import "MyMD5.h"
#import "OpenUDID.h"
#import "NSString+Addition.h"
#import "NSDataAddition.h"
#import "AFAppDotNetAPIClient6.h"

#import "TKUtilsMacro.h"
#import "MyMD5.h"
#import <UALogger.h>
#import "MDTools.h"
#import "MDTools.h"

#import <SVProgressHUD.h>
@implementation DAHttpClient

SINGLETON_GCD(DAHttpClient);

- (NSURLSessionDataTask *)getRequestWithParameters:(NSMutableDictionary *) parames Action:(NSString *) action success:(SLObjectBlock)success error:(SLIndexBlock)error
{
    
    if (parames == nil) {
        parames = [[NSMutableDictionary alloc] init];
    }
    [MDTools addAuthMD5:parames];    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        [[AFAppDotNetAPIClient6 sharedClient] GET:action parameters:parames success:^(AFHTTPRequestOperation *operation, id JSON) {
            if(JSON){
                UALog(@"json : %@",JSON);
                if ([JSON[@"code"] intValue] == -1) {
                    [self logoutByOtherDevices];
                }else{
                    success(JSON);
                }
            }else{
                error(0);           //0  failure
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *errossr) {
                error(1);               //1 error
        }];
    }else{
        
        return [[AFAppAPIClient sharedClient] GET:action parameters:parames success:^(NSURLSessionDataTask * __unused task, id JSON) {
            if(JSON){
                UALog(@"json : %@",JSON);
                if ([JSON[@"code"] intValue] == -1) {
                    [self logoutByOtherDevices];
                }else{
                    success(JSON);
                }
            }else{
                error(0);           //0  failure
            }
        } failure:^(NSURLSessionDataTask *__unused task, NSError *err) {
            error(1);               //1 error
        }];
    }
    return nil;
}

-(void) logoutByOtherDevices
{
    [SVProgressHUD showErrorWithStatus:@"您的帐号在其它设备登录，请重新登录"];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWithName_LoginOut object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWithName_LoginWithRegsiter object:nil];
}

- (NSURLSessionDataTask *) postRequestWithParameters:(NSMutableDictionary *) parames Action:(NSString *) action success:(SLObjectBlock)success error:(SLIndexBlock)error
{    
    
    if (parames == nil) {
        parames = [[NSMutableDictionary alloc] init];
    }
    
    [MDTools addAuthMD5:parames];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        [[AFAppDotNetAPIClient6 sharedClient] POST:action parameters:parames success:^(AFHTTPRequestOperation *operation, id JSON) {
            UALog(@"json : %@",JSON);
            if(JSON){
                if ([JSON[@"code"] intValue] == -1) {
                    [self logoutByOtherDevices];
                }else{
                    success(JSON);
                }
            }else{
                error(0);           //0  failure
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *errossr) {
            UALog(@"errossr %@",errossr.userInfo);
            error(1);               //1 error
        }];
    }else{
        return [[AFAppAPIClient sharedClient] POST:action parameters:parames success:^(NSURLSessionDataTask * __unused task, id JSON) {
            if(JSON){
                UALog(@"json : %@",JSON);
                if ([JSON[@"code"] intValue] == -1) {
                    [self logoutByOtherDevices];
                }else{
                    success(JSON);
                }
            }else{
                error(0);           //0  failure
            }
        } failure:^(NSURLSessionDataTask *__unused task, NSError *err) {
            error(1);               //1 error
        }];
    }
    return  nil;
}

-(void) downloadFileReturnMd5:(SLObjectBlock) md5
{
    NSString * md5OnLine = [USER_DEFAULT stringForKey:KeyChain_MD_configMd5];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pathmd5 = [documentsDirectory stringByAppendingPathComponent:@"config.plist"];
    BOOL isSameFile = [md5OnLine isEqualToString:[MyMD5 md5WithFilePath:pathmd5]];
    
    ////如果匹配 无需网络请求
    if (isSameFile) {
        md5([MyMD5 md5WithFilePath:pathmd5]);
    }else{
        //remove old file
        
        NSError *error;
        if ([[NSFileManager defaultManager] removeItemAtPath:pathmd5 error:&error] != YES)
            NSLog(@"Unable to delete file: %@", [error localizedDescription]);
        
        NSString * stringToken = [USER_DEFAULT stringForKey:KeyChain_MD_account_auth_token];
        NSString * userid = [USER_DEFAULT stringForKey:KeyChain_MD_account_user_id];
        
        NSString * md5Sign = [MDTools addAuthMD5:nil];
        
        NSURL *URL = [NSURL URLWithString:F(@"%@%@?token=%@&user_id=%@&sign=%@",MDSYSTEMDOMAIN,@"/config.plist",stringToken,userid,md5Sign)];
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        if (IOS7) {
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
//            NSString * stringToken = [USER_DEFAULT stringForKey:KeyChain_MD_account_auth_token];
//            if (stringToken && stringToken.length > 0) {
//                [request  addValue:stringToken forHTTPHeaderField:@"token"];
//                NSString * userid = [USER_DEFAULT stringForKey:KeyChain_MD_account_user_id];
//                [request  addValue:userid forHTTPHeaderField:@"user_id"];
//            }
            NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                
                return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
            } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                NSLog(@"ios7 File downloaded to: %@  ", filePath);
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                //获取文件路径
                NSString *pathmd5 = [documentsDirectory stringByAppendingPathComponent:@"config.plist"];
                md5([MyMD5 md5WithFilePath:pathmd5]);
            }];
            [downloadTask resume];
        }else{
            
            NSURL *filePath = [documentsDirectoryURL URLByAppendingPathComponent:@"config.plist"];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
            
            NSString * stringToken = [USER_DEFAULT stringForKey:KeyChain_MD_account_auth_token];
            if (stringToken && stringToken.length > 0) {
                [request  addValue:stringToken forHTTPHeaderField:@"token"];
                NSString * userid = [USER_DEFAULT stringForKey:KeyChain_MD_account_user_id];
                [request  addValue:userid forHTTPHeaderField:@"user_id"];
            }
            
            AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
            operation.outputStream = [NSOutputStream outputStreamWithURL:filePath append:NO];
            //[NSOutputStream outputStreamToFileAtPath:filePath append:NO];
            
            [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"ios 6 Successfully downloaded file to %@  ", filePath);
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"Error: %@", error);
            }];
            [operation setCompletionBlock:^{
                
                NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSString *documentsDirectory = [paths objectAtIndex:0];
                //获取文件路径
                NSString *pathmd5 = [documentsDirectory stringByAppendingPathComponent:@"config.plist"];
                md5([MyMD5 md5WithFilePath:pathmd5]);
                
            }];
            [operation start];
            
        }

    }
    
}

@end
