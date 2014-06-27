//
//  MDAppDelegate.m
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDAppDelegate.h"
#import "MDTools.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MDDrawerVisualStateManager.h"
#import "MMNavigationController.h"
#import "MDProtocol.h"
#import <Objection.h>
#import "TKUtilsMacro.h"
#import "MobClick.h"
#import "UIAlertViewAddition.h"
#import <UALogger.h>
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import <JPush/APService.h>

/*!
 *  objection module
 */
#import "MDMyExpressModule.h"
#import "MDMyOrderModule.h"
#import "MDRealNameAuthModule.h"
#import "MDModifyPersonalInfoModule.h"
#import "MDRealNameAuthModule.h"
#import "MDRechargeModule.h"
#import "MDFeedEasyCenterModule.h"
#import "MDSideDrawerModule.h"
#import "MDMyPermissionsDetailModule.h"

#import "Constant.h"
//#import "MDPaySuccessViewController.h"

/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wx483dafc09117a3d0";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppKey = @"Pm2GQlkyVNoSfAVz7aCQiL6uVBzJrY0nxAEeFr0AYepM3QUcLXQwA70w4EoKfKoxBUSqTmnGtdZYEklxhxzmPamCiIeZ3WT0JlcZnRXtmndUzwQRbf2ueRn7OeqCANvR";

/**
 * 微信开放平台和商户约定的密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppSecret = @"865c21f8991bd6b229f535648296d088";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXPartnerKey = @"d4a8415b5845bf446a0fc44da5158deb";

/**
 *  微信公众平台商户模块生成的ID
 */
NSString * const WXPartnerId = @"1218670701";

/*!
 *  HUDDismissNotification
 */
NSString * const HUDDismissNotification = @"HUDDismissNotification_weichatpay";


NSString * const JPUSHKEY = @"4defe429328fb4a0fcd2f40c";


@interface MDAppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation MDAppDelegate

/*!
 *  init setup objection jector
 */
-(void) setupModule
{
    JSObjectionInjector *injector = [JSObjection defaultInjector]; // [1]
    injector = injector ? : [JSObjection createInjector]; // [2]
    injector = [injector withModules:
                [[MDMyExpressModule alloc] init],
                [[MDMyOrderModule alloc] init],
                [[MDRealNameAuthModule alloc] init],
                [[MDModifyPersonalInfoModule alloc] init],
                [[MDRealNameAuthModule alloc] init],
                [[MDRechargeModule alloc] init],
                [[MDFeedEasyCenterModule alloc] init],
                [[MDSideDrawerModule alloc] init],
                [[MDMyPermissionsDetailModule alloc] init],nil]; // [3]
    [JSObjection setDefaultInjector:injector]; // [4]
}


/*!
 *  set umeng Analytics_Sdk_3.1.2
 *
 */
-(void) umAnalytics
{
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    [MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    //
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) SEND_ON_EXIT channelId:@"App Store"];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
//    [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    //[MobClick updateOnlineConfig];  //在线参数配置
}


-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    UIViewController * leftSideDrawerViewController = [MDTools loadController:[MDSideDrawerViewController class]];
//    UIViewController * centerViewController = [MDTools loadController:[MDFeedEasyCenterTableViewController class]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    self.viewcontrollersDicty = dict;
    
    [self setupModule];

    
    UIViewController <MDSideDrawerViewControllerProtocol> *leftSideDrawerViewController = [[JSObjection defaultInjector] getObject:@protocol(MDSideDrawerViewControllerProtocol)];
    
    UIViewController <MDFeedEasyCenterTableViewControllerProtocol> *centerViewController = [[JSObjection defaultInjector] getObject:@protocol(MDFeedEasyCenterTableViewControllerProtocol)];
    
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:centerViewController];
    
    [self.viewcontrollersDicty setValue:navigationController forKey:@"centerView"];
    
    [navigationController setRestorationIdentifier:@"MDCenterNavigationControllerRestorationKey"];
    
    /* if(OSVersionIsAtLeastiOS7()){
        UINavigationController * leftSideNavController = [[MMNavigationController alloc] initWithRootViewController:leftSideDrawerViewController];
		[leftSideNavController setRestorationIdentifier:@"MMExampleLeftNavigationControllerRestorationKey"];
        self.drawerController = [[MMDrawerController alloc]
                                 initWithCenterViewController:navigationController
                                 leftDrawerViewController:leftSideNavController
                                 rightDrawerViewController:nil];
//        [self.drawerController setShowsShadow:NO];
    }
    else{
        self.drawerController = [[MMDrawerController alloc]
                                 initWithCenterViewController:navigationController
                                 leftDrawerViewController:leftSideDrawerViewController
                                 rightDrawerViewController:nil];
    }*/
    
    self.drawerController = [[MMDrawerController alloc]
                             initWithCenterViewController:navigationController
                             leftDrawerViewController:leftSideDrawerViewController
                             rightDrawerViewController:nil];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:120.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MDDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if(IOS7){
        UIColor * tintColor = [UIColor colorWithRed:29.0/255.0
                                              green:173.0/255.0
                                               blue:234.0/255.0
                                              alpha:1.0];
        [self.window setTintColor:tintColor];
    }
    [self.window setRootViewController:self.drawerController];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /*if (IOS7) {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        self.window.clipsToBounds =YES;
        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        
        //Added on 19th Sep 2013
        self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    }*/
    
    [self umAnalytics];
    
    [WXApi registerApp:WXAppId];
    
    // Required
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)];
    // Required
    [APService setupWithOption:launchOptions];
    
    [self registerThisAccount];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openLoginAndRegister:) name:NotificationWithName_LoginWithRegsiter object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerThisAccount) name:NotificationWithName_LoginWithRegsiter_ApplePush object:nil];
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    if (![MDAppDelegate hasLogin]) {
//        [self openLoginAndRegister:nil];
//    }
    return YES;
}

-(void) registerThisAccount
{

    if ([MDAppDelegate hasLogin]) {
        [APService setAlias:[USER_DEFAULT stringForKey:KeyChain_MD_account_phone] callbackSelector:@selector(callbackwithMsg:) object:self];
    }

}

-(void)callbackwithMsg:(id) msg
{
    UALog(@"callbackwithMsg %@",msg);
}

-(void) openLoginAndRegister:(NSNotification * ) notify
{
    
    [APService setAlias:@"" callbackSelector:@selector(callbackwithMsg:) object:self];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:StoryboardWithName_LoginWithRegsiter bundle:nil];
    UINavigationController * navigationController = [[MMNavigationController alloc] initWithRootViewController:[storyboard instantiateInitialViewController]];
    navigationController.navigationBarHidden = YES;
    [self.drawerController presentViewController:navigationController animated:NO completion:^{
    }];
}

/*!
 *  检测当前账号是否登录
 */
+(BOOL) hasLogin
{
    NSString * auth = [USER_DEFAULT stringForKey:KeyChain_MD_account_auth_token];
    BOOL bol = [USER_DEFAULT boolForKey:KeyChain_MD_account_HasLogin];
    if(auth.length > 1 && bol){
        return YES;
    }
    return NO;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber: -1];
    [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    NSString * key = [identifierComponents lastObject];
    if([key isEqualToString:@"MMDrawer"]){
        return self.window.rootViewController;
    }
    else if ([key isEqualToString:@"MDCenterNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).centerViewController;
    }
    else if ([key isEqualToString:@"MMExampleRightNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftNavigationControllerRestorationKey"]) {
        return ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
    }
    else if ([key isEqualToString:@"MMExampleLeftSideDrawerController"]){
        UIViewController * leftVC = ((MMDrawerController *)self.window.rootViewController).leftDrawerViewController;
        if([leftVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)leftVC topViewController];
        }
        else {
            return leftVC;
        }
    }
    else if ([key isEqualToString:@"MMExampleRightSideDrawerController"]){
        UIViewController * rightVC = ((MMDrawerController *)self.window.rootViewController).rightDrawerViewController;
        if([rightVC isKindOfClass:[UINavigationController class]]){
            return [(UINavigationController*)rightVC topViewController];
        }
        else {
            return rightVC;
        }
    }
    return nil;
}

//独立客户端回调函数
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [WXApi handleOpenURL:url delegate:self];
	[self parse:url application:application];
	return YES;
}

/*!
 *  微信支付
 *
 *  @param resp <#resp description#>
 */
- (void)onResp:(BaseResp *)resp
{
    NSLog(@"resp : %d type: %d",resp.errCode ,resp.type);
    if ([resp isKindOfClass:[PayResp class]]) {
        
        if (resp.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MACRO_NOTIFICATION_USER_PAY_RESULT object:nil]; 
        }else{
            [UIAlertView showAlertViewWithMessage:@"支付失败"];
        }

        [[NSNotificationCenter defaultCenter] postNotificationName:HUDDismissNotification object:nil userInfo:nil];
    }
}

- (void)parse:(NSURL *)url application:(UIApplication *)application {
    
    /*	statusCode=9000
     statusMessage=支付结束
     signType=RSA
     signString=HuZIhd/M6/UTrEKkFI0lciNArkjdJV/hsTuspWXK3jNWqtaJJ1VD//Rs4o6BUMBWa4jCAvBma+DeTbf21W9yL91XkSvd5+JkGeTcdjY77OI4vitOxXKobJlQLsu2rypUHr0s5a8MhIsTYhMkgDLJx52DNpZDNKGNiQaNKOGSdAI=
     */
    //结果处理
    AlixPayResult* result = [self handleOpenURL:url];
    if (result == nil) {
        return;
    }
//    NSString *strTitle = [NSString stringWithFormat:@"支付结果"];
    NSLog(@" application %@",[result description]);
	if (result && result.statusCode == 9000)
    {
        /*
         *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
         */
        //交易成功
        NSString* key = @"签约帐户后获取到的支付宝公钥";
        id<DataVerifier> verifier;
        verifier = CreateRSADataVerifier(key);
        
        if ([verifier verifyString:result.resultString withSign:result.signString])
        {
            //验证签名成功，交易结果无篡改
            [[NSNotificationCenter defaultCenter] postNotificationName:MACRO_NOTIFICATION_USER_PAY_RESULT object:nil];
//            // tar get to Pay success viewcontroller
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardWithName_PaySuccess bundle:nil];
//            MDPaySuccessViewController * viewcontr = [storyboard instantiateViewControllerWithIdentifier:@"MDPaySuccessViewController"];
//            [self.drawerController.navigationController pushViewController:viewcontr animated:YES];
            
        }else{
            [UIAlertView showAlertViewWithMessage:@"支付失败"];
        }
        
    }
    else
    {
        //失败
            [UIAlertView showAlertViewWithMessage:@"支付失败"];
    }
}

- (AlixPayResult *)resultFromURL:(NSURL *)url {
	NSString * query = [[url query] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if ! __has_feature(objc_arc)
    return [[[AlixPayResult alloc] initWithString:query] autorelease];
#else
	return [[AlixPayResult alloc] initWithString:query];
#endif
}

- (AlixPayResult *)handleOpenURL:(NSURL *)url {
	AlixPayResult * result = nil;
	
	if (url != nil && [[url host] compare:@"safepay"] == 0) {
		result = [self resultFromURL:url];
	}
    
	return result;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
   
    /*
    userInfo {
        aps =     {
            alert = "\U60a8\U9884\U7ea6\U7684\U7bb1\U683c\U5df2\U7ecf\U6210\U529f!";
            badge = 1;
            sound = default;
        };
        event = "sudiyiapp#orderSuccess";
        "workorder_id" = 1;
    }
    */
    if (userInfo) {
        UALog(@"userInfo %@",userInfo);
        NSDictionary * dicAps = userInfo[@"aps"];
        //刷新首页数据
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationWithName_LeftSideFill object:nil];
        [MDTools playVirate];
        [UIAlertView showAlertViewWithMessage:dicAps[@"alert"]];
    }
    
    // Required
    [APService handleRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString* devtokenstring=[[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	devtokenstring=[devtokenstring stringByReplacingOccurrencesOfString:@" " withString:@""];
	devtokenstring=[devtokenstring stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	devtokenstring=[devtokenstring stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    //devtokenstring:  d8009e6c8e074d1bbcb592f321367feaef5674a82fc4cf3b78b066b7c8ad59bd
    UALog(@"devtokenstring : %@",devtokenstring);
    [USER_DEFAULT setValue:devtokenstring forKey:KeyChain_MD_apnsToken];
    [USER_DEFAULT synchronize];
    // Required
    [APService registerDeviceToken:deviceToken];
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0)
{
    UALog(@"error : %@",[error.userInfo objectForKey:NSLocalizedDescriptionKey]);
}

@end
