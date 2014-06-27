//
//  WXPayClient.m
//  WechatPayDemo
//
//  Created by Alvin on 3/22/14.
//  Copyright (c) 2014 Alvin. All rights reserved.
//

#import "WXPayClient.h"
//#import <ASIHTTPRequest/ASIHTTPRequest.h>
#import "CommonUtil.h"
#import "Constant.h"
#import <JSONHTTPClient.h>
#import <UALogger.h>
#import "TKUtilsMacro.h"
#import "MDTools.h"
#import "MDJsonModel.h"
#import <SVProgressHUD.h>
#import "UIAlertViewAddition.h"

NSString *AccessTokenKey = @"access_token";
NSString *PrePayIdKey = @"prepayid";
NSString *errcodeKey = @"errcode";
NSString *errmsgKey = @"errmsg";
NSString *expiresInKey = @"expires_in";

@interface WXPayClient ()
{

    NSString * cNotify_url;
    MDPayTypeModel * payModel;
}
//@property (nonatomic, strong) ASIHTTPRequest *request;
@property (nonatomic, copy) NSString *timeStamp;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, copy) NSString *traceId;

@end

@implementation WXPayClient

#pragma mark - Public

+ (instancetype)shareInstance 
{
    static WXPayClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[WXPayClient alloc] init];
    });
    return sharedClient;
}

- (void)payProduct:(MDPayTypeModel * ) model withNotify:(NSString *) notify
{
    payModel = model;
    cNotify_url = notify;
    [self getAccessToken];
}

#pragma mark - 生成各种参数

- (NSString *)genTimeStamp
{
    return [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970]];
}

/**
 * 注意：商户系统内部的订单号,32个字符内、可包含字母,确保在商户系统唯一
 */
- (NSString *)genNonceStr
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

/**
 * 建议 traceid 字段包含用户信息及订单信息，方便后续对订单状态的查询和跟踪
 */
- (NSString *)genTraceId
{
    return [NSString stringWithFormat:@"crestxu_%@", [self genTimeStamp]];
}

- (NSString *)genOutTradNo
{
    return [CommonUtil md5:[NSString stringWithFormat:@"%d", arc4random() % 10000]];
}

-(NSString *) getproductNameWithIndex:(NSInteger) type
{
    switch (type) {
        case 1:
            return  @"充值";
            break;
        case 2:
            return @"快件超期";
            break;
        case 3:
            return @"租用";
            break;
        case 4:
            return @"租用超期";
            break;
        case 5:
            return @"存放";
            break;
        case 6:
            return @"存放超期";
            break;
        case 7:
            return @"寄件";
            break;
        case 8:
            return @"权限升级";
            break;
            
        default:
            break;
    }
    return @"";
	
    
}

- (NSString *)genPackage
{
    // 构造参数列表
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; 
    [params setObject:@"WX" forKey:@"bank_type"];
    [params setObject:[self getproductNameWithIndex:payModel.order_type] forKey:@"body"];
    [params setObject:@"1" forKey:@"fee_type"];
    [params setObject:@"UTF-8" forKey:@"input_charset"];
    if (!cNotify_url) {
        [params setObject:@"http://weixin.qq.com" forKey:@"notify_url"];
    }else{
        [params setObject:cNotify_url forKey:@"notify_url"];
    }
//    [params setObject:F(@"%@%@",MDSYSTEMDOMAIN,[MDTools plistforSystemConfiguation:TKsystemConfigType_weixinpay]) forKey:@"notify_url"];
    
    [params setObject:[self genOutTradNo] forKey:@"out_trade_no"];
    [params setObject:WXPartnerId forKey:@"partner"];
    [params setObject:[CommonUtil getIPAddress:YES] forKey:@"spbill_create_ip"];
    double dou = payModel.fee;
    dou = dou*100;
    if (dou == 0) {
       [params setObject:@"1" forKey:@"total_fee"];    // 1 =＝ ¥0.01
    }else
        [params setObject:F(@"%d",(int)dou) forKey:@"total_fee"];    // 1 =＝ ¥0.01
    
    if (NEED_OUTPUT_LOG) {
        [params setObject:@"1" forKey:@"total_fee"];
    }
    
    NSArray *keys = [params allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) { 
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成 packageSign
    NSMutableString *package = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [package appendString:key];
        [package appendString:@"="];
        [package appendString:[params objectForKey:key]];
        [package appendString:@"&"];
    }
    
    [package appendString:@"key="];
    [package appendString:WXPartnerKey]; // 注意:不能hardcode在客户端,建议genPackage这个过程都由服务器端完成
    
    // 进行md5摘要前,params内容为原始内容,未经过url encode处理
    NSString *packageSign = [[CommonUtil md5:[package copy]] uppercaseString]; 
    package = nil;
    
    // 生成 packageParamsString
    NSString *value = nil;  
    package = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [package appendString:key];
        [package appendString:@"="];
        value = [params objectForKey:key];
        
        // 对所有键值对中的 value 进行 urlencode 转码
        value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)value, nil, (CFStringRef)@"!*'&=();:@+$,/?%#[]", kCFStringEncodingUTF8));
        
        [package appendString:value];
        [package appendString:@"&"];
    }
    NSString *packageParamsString = [package substringWithRange:NSMakeRange(0, package.length - 1)];

    NSString *result = [NSString stringWithFormat:@"%@&sign=%@", packageParamsString, packageSign];
    
    NSLog(@"--- Package: %@", result);
    
    return result;
}

- (NSString *)genSign:(NSDictionary *)signParams
{
    // 排序
    NSArray *keys = [signParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) { 
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    // 生成
    NSMutableString *sign = [NSMutableString string];
    for (NSString *key in sortedKeys) {
        [sign appendString:key];
        [sign appendString:@"="];
        [sign appendString:[signParams objectForKey:key]];
        [sign appendString:@"&"];
    }
    NSString *signString = [[sign copy] substringWithRange:NSMakeRange(0, sign.length - 1)];
    
    NSString *result = [CommonUtil sha1:signString];
    NSLog(@"--- Gen sign: %@", result);
    return result;
}

- (NSMutableData *)getProductArgs
{
    self.timeStamp = [self genTimeStamp];
    self.nonceStr = [self genNonceStr]; // traceId 由开发者自定义，可用于订单的查询与跟踪，建议根据支付用户信息生成此id
    self.traceId = [self genTraceId];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary]; 
    [params setObject:WXAppId forKey:@"appid"];
    [params setObject:WXAppKey forKey:@"appkey"];
    [params setObject:self.timeStamp forKey:@"noncestr"];
    [params setObject:self.timeStamp forKey:@"timestamp"];
    [params setObject:self.traceId forKey:@"traceid"];
    [params setObject:[self genPackage] forKey:@"package"];
    [params setObject:[self genSign:params] forKey:@"app_signature"];
    [params setObject:@"sha1" forKey:@"sign_method"];
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error: &error];
    NSLog(@"--- ProductArgs: %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    return [NSMutableData dataWithData:jsonData]; 
}

#pragma mark - 主体流程

- (void)getAccessToken
{
    NSString *getAccessTokenUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%@&secret=%@", WXAppId, WXAppSecret];
    
    NSLog(@"--- GetAccessTokenUrl: %@", getAccessTokenUrl);
    
#pragma mark json model request
    __weak WXPayClient *weakSelf = self;
    [JSONHTTPClient getJSONFromURLWithString:getAccessTokenUrl params:nil completion:^(id dict, JSONModelError *err) {
        if (err && err.httpResponse.statusCode  != 200) {
//            [weakSelf showAlertWithTitle:@"错误" msg:@"获取 AccessToken 失败"];
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            return;
        } else {
            UALog(@"--- %@", dict);
//            [weakSelf showAlertWithTitle:@"错误" msg:@"获取 AccessToken 失败"];
        }
        
        NSString *accessToken = dict[AccessTokenKey];
        if (accessToken) {
            UALog(@"--- AccessToken: %@", accessToken);
            
            __strong WXPayClient *strongSelf = weakSelf;
            [strongSelf getPrepayId:accessToken];
        } else {
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            
//            NSString *strMsg = [NSString stringWithFormat:@"errcode: %@, errmsg:%@", dict[errcodeKey], dict[errmsgKey]];
//            [weakSelf showAlertWithTitle:@"错误" msg:strMsg];
        }
        
    }];
    
#pragma mark asiHttprequest
    
    /* asiHttprequest
    self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getAccessTokenUrl]];
    
    __weak WXPayClient *weakSelf = self;
    __weak ASIHTTPRequest *weakRequest = self.request;
    
    [self.request setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[weakRequest responseData] 
                                                             options:kNilOptions 
                                                               error:&error];
        if (error) {
            [weakSelf showAlertWithTitle:@"错误" msg:@"获取 AccessToken 失败"];
            return;
        } else {
            NSLog(@"--- %@", [weakRequest responseString]);
        }
        
        NSString *accessToken = dict[AccessTokenKey];
        if (accessToken) {
            NSLog(@"--- AccessToken: %@", accessToken);
            
            __strong WXPayClient *strongSelf = weakSelf;
            [strongSelf getPrepayId:accessToken];
        } else {
            NSString *strMsg = [NSString stringWithFormat:@"errcode: %@, errmsg:%@", dict[errcodeKey], dict[errmsgKey]];
            [weakSelf showAlertWithTitle:@"错误" msg:strMsg];
        }
    }];
    
    [self.request setFailedBlock:^{
        [weakSelf showAlertWithTitle:@"错误" msg:@"获取 AccessToken 失败"];
    }];
    [self.request startAsynchronous];
     */
}

- (void)getPrepayId:(NSString *)accessToken
{
    NSString *getPrepayIdUrl = [NSString stringWithFormat:@"https://api.weixin.qq.com/pay/genprepay?access_token=%@", accessToken];
    
    UALog(@"--- GetPrepayIdUrl: %@", getPrepayIdUrl);
    
    NSMutableData *postData = [self getProductArgs];
    
#pragma mark json model request
    __weak WXPayClient *weakSelf = self;
    [JSONHTTPClient postJSONFromURLWithString:getPrepayIdUrl bodyData:postData completion:^(id dict, JSONModelError *err) {
        if (err &&  err.httpResponse.statusCode != 200) {
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            
//            [weakSelf showAlertWithTitle:@"错误" msg:@"获取 PrePayId 失败"];
            return;
        }else{
            UALog(@"dict %@",dict);
            NSString *prePayId = dict[PrePayIdKey];
            if (prePayId) {
                UALog(@"--- PrePayId: %@", prePayId);
                
                // 调起微信支付
                PayReq *request   = [[PayReq alloc] init];
                request.partnerId = WXPartnerId;
                request.prepayId  = prePayId;
                request.package   = @"Sign=WXPay";      // 文档为 `Request.package = _package;` , 但如果填写上面生成的 `package` 将不能支付成功
                request.nonceStr  = weakSelf.nonceStr;
                request.timeStamp = [weakSelf.timeStamp  longLongValue];
                
                // 构造参数列表
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                [params setObject:WXAppId forKey:@"appid"];
                [params setObject:WXAppKey forKey:@"appkey"];
                [params setObject:request.nonceStr forKey:@"noncestr"];
                [params setObject:request.package forKey:@"package"];
                [params setObject:request.partnerId forKey:@"partnerid"];
                [params setObject:request.prepayId forKey:@"prepayid"];
                [params setObject:weakSelf.timeStamp forKey:@"timestamp"];
                request.sign = [weakSelf genSign:params];
                
                // 在支付之前，如果应用没有注册到微信，应该先调用 [WXApi registerApp:appId] 将应用注册到微信
                [WXApi safeSendReq:request];
            } else {
                [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
//                NSString *strMsg = [NSString stringWithFormat:@"errcode: %@, errmsg:%@", dict[errcodeKey], dict[errmsgKey]];
//                [weakSelf showAlertWithTitle:@"错误" msg:strMsg];
            }
        }
    }];
    
#pragma mark ASIhttprequset
    /*
    // 文档: 详细的订单数据放在 PostData 中,格式为 json
    self.request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:getPrepayIdUrl]];
    [self.request addRequestHeader:@"Content-Type" value:@"application/json"];  
    [self.request addRequestHeader:@"Accept" value:@"application/json"];
    [self.request setRequestMethod:@"POST"];
    [self.request setPostBody:postData];
    
    __weak WXPayClient *weakSelf = self;
    __weak ASIHTTPRequest *weakRequest = self.request;
    
    [self.request setCompletionBlock:^{
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[weakRequest responseData] 
                                                             options:kNilOptions 
                                                               error:&error];
        
        if (error) {
            [weakSelf showAlertWithTitle:@"错误" msg:@"获取 PrePayId 失败"];
            return;
        } else {
            NSLog(@"--- %@", [weakRequest responseString]);
        }
        
        NSString *prePayId = dict[PrePayIdKey];
        if (prePayId) {
            NSLog(@"--- PrePayId: %@", prePayId);
            
            // 调起微信支付
            PayReq *request   = [[PayReq alloc] init];
            request.partnerId = WXPartnerId;
            request.prepayId  = prePayId;
            request.package   = @"Sign=WXPay";      // 文档为 `Request.package = _package;` , 但如果填写上面生成的 `package` 将不能支付成功
            request.nonceStr  = weakSelf.nonceStr;
            request.timeStamp = [weakSelf.timeStamp longLongValue];
            
            // 构造参数列表
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            [params setObject:WXAppId forKey:@"appid"];
            [params setObject:WXAppKey forKey:@"appkey"];
            [params setObject:request.nonceStr forKey:@"noncestr"];
            [params setObject:request.package forKey:@"package"];
            [params setObject:request.partnerId forKey:@"partnerid"];
            [params setObject:request.prepayId forKey:@"prepayid"];
            [params setObject:weakSelf.timeStamp forKey:@"timestamp"];
            request.sign = [weakSelf genSign:params];
            
            // 在支付之前，如果应用没有注册到微信，应该先调用 [WXApi registerApp:appId] 将应用注册到微信
            [WXApi safeSendReq:request];
        } else {
            NSString *strMsg = [NSString stringWithFormat:@"errcode: %@, errmsg:%@", dict[errcodeKey], dict[errmsgKey]];
            [weakSelf showAlertWithTitle:@"错误" msg:strMsg];
        }
    }];
    [self.request setFailedBlock:^{
        [weakSelf showAlertWithTitle:@"错误" msg:@"获取 PrePayId 失败"];
    }];
    [self.request startAsynchronous];
     */
}

#pragma mark - Alert

- (void)showAlertWithTitle:(NSString *)title msg:(NSString *)msg
{
    [UIAlertView showAlertViewWithTitle:title message:msg];
//    [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
}

@end
