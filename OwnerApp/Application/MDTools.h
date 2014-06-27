//
//  MDTools.h
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, TKsystemConfigType){
    TKsystemConfigType_weixinpay = 1,
    TKsystemConfigType_alipay,
    TKsystemConfigType_page_size,
    TKsystemConfigType_discount_level,
    TKsystemConfigType_express_price,
    TKsystemConfigType_rent_price,
    TKsystemConfigType_user_level,
};



@interface MDTools : NSObject

/*!
 *  load viewcontroller with viewcontroller name
 *
 */
+ (id)loadController:(Class)classType ;

/*!
 *  ios7 and ios6
 *
 *  @return <#return value description#>
 */
+(CGFloat) screenHeightWithIOS6AndIOS7;

/*!
 *  navigation bg
 *
 *  @param navi <#navi description#>
 */
+(void) setnavigationBarbg:(UINavigationController *) navi;

/*!
 *  时间格式化  * 2014年5月12日 12：23：34
 */
+(NSString *) timeFormatStringforDate:(NSDate * ) date;

/*!
 * 2014年5月12日
 */
+(NSString *) timeFormatStringforDateShort:(NSDate * ) date;

/*!
 *  根据时间搓计算时间 2014-12-13
 *
 */
+(NSString *) timeFormatStringforDateShortTime:( double  ) date;
/*!
 *  随机file名称
 *
 *  @return <#return value description#>
 */
+(NSString * ) getMD4HashWithObj;

/*!
 *  tableview 处理
 *
 *  @param tableview <#tableview description#>
 */
+(void) tableviewInit:(UITableView *) tableview;

/*!
 *  tableview cell 处理
 *
 *  @param cell <#cell description#>
 */
+(void)tableViewCellInit:(UITableViewCell *  ) cell;

/*!
 *  箱子类型 string
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
+(NSString *) cellTypeForIndex:(NSInteger ) index;

/*!
 *  图片压缩处理
 *
 *  @param strSrcURL <#strSrcURL description#>
 *
 *  @return <#return value description#>
 */
+(NSData * ) imageDataForUrl:(NSString * ) strSrcURL;

/*!
 *  设置箱格类型选中
 *
 *  @param button <#button description#>
 */
+ (void) setButtonSelected:(UIButton *) button;

/*!
 *   设置箱格类型 未 选中
 *
 *  @param button <#button description#>
 */
+ (void) setButtonUnselected:(UIButton *) button;

/*!
 *  设置UIlabel背景 ios7 style
 *
 *  @param cell <#cell description#>
 */
+(void)tableViewCellInitLable:(UILabel *  ) cell;

/*!
 *  全局plist 配置文件 dict
 */
+(NSDictionary * ) plistforSystemConfiguation;

/*!
 *  全局plist 配置文件 dict
 *
 *  @param type 获取不同属性
 *
 *  @return <#return value description#>
 */
+(id ) plistforSystemConfiguation:(TKsystemConfigType) type;

/*!
 *  1.0.xxx
 *
 *  @return <#return value description#>
 */
+ (NSString *)bundleShortVersionString;

/*!
 *  xxxx
 *
 *  @return <#return value description#>
 */
+ (NSString *)bundleBuildVersionString;

/*!
 *  添加token
 *
 *  @param parames <#parames description#>
 */
+(NSString *) addAuthMD5:(NSMutableDictionary * ) parames;


/*!
 *  两个时间间隔差
 *
 *  @param dateString1 <#dateString1 description#>
 *  @param dateString2 <#dateString2 description#>
 *
 *  @return <#return value description#>
 */
+ (NSString *)intervalFromLastDate: (unsigned long long) dateString1  toTheDate:(unsigned long long) dateString2;

/*!
 *  支付类型
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
+(NSString * ) payTypeWithIndex:(NSInteger)index;

/*!
 *  快件类型 支付
 */
+(NSString * ) orderTypeWithIndex:(NSInteger)index;

/*!
 *  根据不同规格箱子计算价格
 *
 *  @param cell_type <#cell_type description#>
 *
 *  @return <#return value description#>
 */
+(double) cell_typeForPrice:(NSInteger) cell_type;


/*!
 *  根据现有的数据刷新箱格状态
 *
 *  @param data  <#data description#>
 *  @param array <#array description#>
 */
+(void) cell_typeRefresh:(NSDictionary *) data withButtons:(NSArray *) array;

///震动 
+(void)playVirate;
@end
