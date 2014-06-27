//
//  TKUtilsMacro.h
//  TKDynamicRACTableView
//
//  Created by tinkl on 10/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.


#define NEED_OUTPUT_LOG                     1   // 0 relese  1 debug

/*!
 *  public macro
 */
#define ApplicationDelegate                 ((MDAppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define IOS7                                [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define IOS6                                [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0
#define KEY_WINDOW                          [[UIApplication sharedApplication]keyWindow]
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define RectSetOriginWH(x, w, h)            CGRectMake(x, 5, w, h)
#define RectSetOriginXYWH(x,y, w, h)            CGRectMake(x, y, w, h)

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
#define F(string, args...)                  [NSString stringWithFormat:string, args]
#define USER_DEFAULT                        [NSUserDefaults standardUserDefaults]
#define FILE_MANAGER                        [NSFileManager defaultManager]
#define APP_CACHES_PATH                     [NSSearchPathForDirectoriesInDomains (NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define ios7BlueColor                        [UIColor colorWithRed:0.188 green:0.655 blue:1.000 alpha:1.000]

// 是否iPad
#define isPad_SC (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)//设备类型改为Universal才能生效
#define isPad_AllTargetMode_SC ([[UIDevice currentDevice].model rangeOfString:@"iPad"].location != NSNotFound)//设备类型为任何类型都能生效

//iPhone5及以上设备，按钮的位置放在下面。iPhone5以下的按钮放上面。
#define isHigherThaniPhone4_SC ((isPad_AllTargetMode_SC && [[UIScreen mainScreen] applicationFrame].size.height <= 960 ? NO : ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height > 960 ? YES : NO) : NO)))
//#define isHigherThaniPhone4_SC (isPad_SC ? YES : ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? ([[UIScreen mainScreen] currentMode].size.height > 960 ? YES : NO) : NO))

#define TableViewBackgroundViewColor        RGB(244, 244, 244)
#define TableViewSelectBackgroundViewColor  RGB(232, 232, 232)
 

// CGRect扩张
CG_INLINE CGRect
CGRectSetX(CGRect rect, CGFloat x)
{
    rect.origin.x = x;
    return rect;
}
CG_INLINE CGRect
CGRectSetY(CGRect rect, CGFloat y)
{
    rect.origin.y = y;
    return rect;
}
CG_INLINE CGRect
CGRectMakeWithSize(CGSize size)
{
    return CGRectMake(0, 0, size.width, size.height);
}

/*!
 * 加载本地文件
 */
#define PATH(NAME,EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

#define IMAGE(NAME,EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

//应用程序的名字
#define AppDisplayName              [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]

/*!
 *  字体大小（常规/粗体）
 */
#define BOLDSYSTEMFONT(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME,FONTSIZE)      [UIFont fontWithName:(NAME) size:(FONTSIZE)]


/**
    pay enum type
 */

typedef enum : NSUInteger {
    paytype_Recharge = 1,
    paytype_express_TimeOut,
    paytype_hireBox,
    paytype_hireBox_TimeOut,
    paytype_TempStorage,
    paytype_TempStorage_TimeOut,
    paytype_SendExpress,
    paytype_PermissionLevel,
} paytypeEnum;


/*
 server url
*/
#define MDSYSTEMDOMAIN          @"http://112.124.15.115:13131"

/*keychain group*/

/*
 "user_id
 is_auth
 name
 exp
 vip_discount
 vip_level
 vip_free_storage_time"
 
 "user_id
 auth_token"
 */
#define KeyChain_MD_account_auth_token          @"KeyChain_MD_account_auth_token"
#define KeyChain_MD_account_phone               @"Mind.MD.chengdu.account_phone"
#define KeyChain_MD_account_pwd                 @"Mind.MD.chengdu.account_pwd"
#define KeyChain_MD_account_user_id             @"Mind.MD.chengdu.account_user_id"
#define KeyChain_MD_account_user_name           @"KeyChain_MD_account_user_name"
#define KeyChain_MD_account_user_numberID       @"KeyChain_MD_account_user_numberID"
#define KeyChain_MD_account_user_is_auth        @"KeyChain_MD_account_user_is_auth"
#define KeyChain_MD_account_user_vip_discount   @"KeyChain_MD_account_user_vip_discount"
#define KeyChain_MD_account_user_vip_level      @"KeyChain_MD_account_user_vip_level"
#define KeyChain_MD_account_user_vip_yue        @"KeyChain_MD_account_user_vip_yue"
#define KeyChain_MD_account_user_vip_free_storage_time       @"KeyChain_MD_account_user_vip_free_storage_time"
#define KeyChain_MD_account_exp                 @"KeyChain_MD_account_exp"
#define KeyChain_MD_account_is_verify           @"KeyChain_MD_account_is_verify"


#define KeyChain_MD_account_HasLogin            @"KeyChain_MD_account_HasLogin"

#define KeyChain_MD_configMd5                   @"KeyChain_MD_configMd5"

#define KeyChain_MD_apnsToken                   @"KeyChain_MD_apnsToken"

#define KeyChain_MD_tableview_overdue_package                   @"KeyChain_MD_tableview_overdue_package"
#define KeyChain_MD_tableview_overdue_rent                      @"KeyChain_MD_tableview_overdue_rent"
#define KeyChain_MD_tableview_overdue_storage                   @"KeyChain_MD_tableview_overdue_storage"

/*
 keychain
 mindrunner.OwnerApp.Account
*/
#define KeyChain_MD_account_mindrunner_Ownerapp         @"mindrunner.OwnerApp"
#define KeyChain_MD_account_Service                     @"Service"

/*!
 *  Storyboard Name
 */
#define StoryboardWithName_LoginWithRegsiter    @"storyboardWithName_LoginWithRegsiter"
#define StoryboardWithName_BoxHire              @"storyboardWithNameBoxHire"
#define StoryboardWithName_SendExpress          @"storyboardWithNameSendExpress"
#define StoryboardWithName_Settings             @"storyboardWithName_Settings"
#define StoryboardWithName_MyExpress            @"storyboardWithName_MyExpress"
#define storyboardWithName_TempStorage          @"storyboardWithName_TempStorage"
#define storyboardWithName_latticeSearch        @"storyboardWithName_latticeSearch"
#define storyboardWithName_PaySuccess           @"storyboardWithName_PaySuccess"
#define storyboardWithName_feedback             @"storyboardWithName_feedback"

/*
 Notification Name
 */
#define NotificationWithName_LoginWithRegsiter      @"NotificationWithName_LoginWithRegsiter"
#define NotificationWithName_LeftSideFill           @"NotificationWithName_LeftSideFill"
#define MACRO_NOTIFICATION_USER_PAY_RESULT          @"ESUDI_NOTIFICATION_USER_PAY_RESULT"
#define NotificationWithName_SeePay_fee             @"NotificationWithName_SeePay_fee"
#define NotificationWithName_PayExcharge            @"NotificationWithName_PayExcharge"
#define NotificationWithName_createOrder            @"NotificationWithName_createOrder"
#define NotificationWithName_LoginOut               @"NotificationWithName_LoginOut"
#define NotificationWithName_LoginWithRegsiter_ApplePush    @"NotificationWithName_LoginWithRegsiter_ApplePush"
#define NotificationWithName_RefreshView            @"NotificationWithName_RefreshView"

/*!
 *  3rd key token
 */
#define UMENG_APPKEY                                @"537f029956240b9bb20a1384"

/*!
 *  SLog
 */
#if NEED_OUTPUT_LOG

#define SLog(xx, ...)   NSLog(xx, ##__VA_ARGS__)
#define SLLog(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

#define SLLogRect(rect) \
SLLog(@"%s x=%f, y=%f, w=%f, h=%f", #rect, rect.origin.x, rect.origin.y, \
rect.size.width, rect.size.height)

#define SLLogPoint(pt) \
SLLog(@"%s x=%f, y=%f", #pt, pt.x, pt.y)

#define SLLogSize(size) \
SLLog(@"%s w=%f, h=%f", #size, size.width, size.height)

#define SLLogColor(_COLOR) \
SLLog(@"%s h=%f, s=%f, v=%f", #_COLOR, _COLOR.hue, _COLOR.saturation, _COLOR.value)

#define SLLogSuperViews(_VIEW) \
{ for (UIView* view = _VIEW; view; view = view.superview) { SLLog(@"%@", view); } }

#define SLLogSubViews(_VIEW) \
{ for (UIView* view in [_VIEW subviews]) { SLLog(@"%@", view); } }

#else

#define SLog(xx, ...)  ((void)0)
#define SLLog(xx, ...)  ((void)0)

#endif



