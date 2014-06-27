//
//  MDTools.m
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDTools.h"
#import "TKUtilsMacro.h"
#import "NSString+Addition.h"
#import "UIImage+Resize.h"
#import "MyMD5.h"
#import "DAHttpClient.h"
#import <AudioToolbox/AudioToolbox.h>
#import "DataHelper.h"

@implementation MDTools

+ (id)loadController:(Class)classType {
    NSString *className = NSStringFromClass(classType);
    UIViewController *controller = [[classType alloc] initWithNibName:className bundle:nil];
    return controller;
}

+(CGFloat) screenHeightWithIOS6AndIOS7
{
    if (IOS7)
        return ScreenHeight;
    return ScreenHeight+20-40;
}

+(void)playVirate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

/*设置导航栏默认背景*/
+(void) setnavigationBarbg:(UINavigationController *) navi{
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"XEATabBar_bg"]];
//        [navi.tabBarController.tabBar insertSubview:imageView atIndex:1];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
         [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
        [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"ios6_navbar"] forBarMetrics:UIBarMetricsDefault];
    }
    else {
        //iOS 4.whatever and below
        //        [navi.tabBarController.tabBar insertSubview:imageView atIndex:0];
    }
    //	navi.navigationBar.tintColor = [UIColor colorWithHex:0xf47c38];
    //	navi.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

+(NSString *) timeFormatStringforDate:(NSDate * ) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSInteger monthInt = [dateString substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [dateString substringWithRange:NSMakeRange(6, 2)].integerValue;
    NSString * str =[NSString stringWithFormat:@"%@年%d月%d日 %@:%@:%@",[dateString substringWithRange:NSMakeRange(0, 4)],(int)monthInt,(int)dayInt,[dateString substringWithRange:NSMakeRange(8, 2)],[dateString substringWithRange:NSMakeRange(10, 2)],[dateString substringWithRange:NSMakeRange(12, 2)]];
    return str;
}

+(NSString *) timeFormatStringforDateShort:(NSDate * ) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    NSInteger monthInt = [dateString substringWithRange:NSMakeRange(4, 2)].integerValue;
    NSInteger dayInt = [dateString substringWithRange:NSMakeRange(6, 2)].integerValue;
    NSString * str =[NSString stringWithFormat:@"%@年%d月%d日",[dateString substringWithRange:NSMakeRange(0, 4)],(int)monthInt,(int)dayInt];
    return str;
}

+(NSString *) timeFormatStringforDateShortTime:(double  ) date
{
     NSDate * dates =[NSDate dateWithTimeIntervalSince1970:date];
     return [self timeFormatStringforDateShort:dates];
}

/*!
 *  随机生成图片储存在本地的MD5名称
 *
 *  @return <#return value description#>
 */
+(NSString * ) getMD4HashWithObj
{
    NSTimeInterval doub = [[NSDate date] timeIntervalSinceNow];
    int x = arc4random() % 1000000;
    NSString * guid = [[NSString stringWithFormat:@"%f%d",doub, x] md5Hash];
    SLLog(@"gener guid: %@",guid);
    return guid;
}

+(void) tableviewInit:(UITableView *) tableview
{
    tableview.separatorColor = RGB(200, 199, 204);
    // 不同style的列表，背景色不一样
    if (tableview.style == UITableViewStylePlain) {
        tableview.backgroundView = [[UIView alloc] init];
        tableview.backgroundView.backgroundColor = [UIColor whiteColor ];
    } else {
        tableview.backgroundView = [[UIView alloc] init];
        tableview.backgroundView.backgroundColor = RGB(240, 240, 240);
    }
}

+(void)tableViewCellInit:(UITableViewCell *  ) cell
{
    cell.backgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView = [[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
    cell.selectedBackgroundView.backgroundColor = RGB(232, 232, 232);
    
    if (IOS6) {
        cell.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
        cell.backgroundView.backgroundColor = [UIColor whiteColor];
        cell.selectedBackgroundView.frame = cell.backgroundView.frame;
        cell.contentView.frame = CGRectSetX(cell.contentView.frame, CGRectGetMinX(cell.contentView.frame) - 5);
    }
}

+(NSString *) cellTypeForIndex:(NSInteger ) index
{
    switch (index) {
        case 2:
            return  @"小箱";
            break;
        case 1:
            return  @"中箱";
            break;
        case 0:
            return  @"大箱";
            break;
            
        default:
            break;
    }
    return @"小箱";
}

+(NSData * ) imageDataForUrl:(NSString * ) strSrcURL
{
    UIImage * image = [UIImage imageWithContentsOfFile:strSrcURL];
    float quality;
    if (image.size.height > image.size.width) {
        quality = image.size.height/image.size.width;
    }else{
        quality = image.size.width/image.size.height;
    }
    quality = quality/2;
    if (quality > 1) {
        quality = .5;
    }
    UIImage * newimage = [image resizedImage:CGSizeMake(image.size.width * quality, image.size.height * quality) interpolationQuality:kCGInterpolationDefault];
    NSData * FileData = UIImageJPEGRepresentation(newimage, 0.5);
    if (!FileData) {
        FileData  = UIImageJPEGRepresentation(image, 0.5);
    }
    SLog(@"FileData size : %ld kb",FileData.length/1024);
    return FileData;
}

+ (void) setButtonSelected:(UIButton *) button
{
//    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2.0f;
}

+ (void) setButtonUnselected:(UIButton *) button
{
//    button.backgroundColor = [UIColor whiteColor];
    button.layer.borderColor = RGB(200, 199, 204).CGColor;
    button.layer.borderWidth = .5f;
}

+(void)tableViewCellInitLable:(UILabel *  ) cell
{
    cell.layer.borderColor = RGB(200, 199, 204).CGColor;
    cell.layer.borderWidth = .5f;
    cell.backgroundColor = [UIColor whiteColor];
}

+(NSDictionary * ) plistforSystemConfiguation
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //获取文件路径
    NSString *pathmd5 = [documentsDirectory stringByAppendingPathComponent:@"config.plist"];
    NSString * md5OnLine = [USER_DEFAULT stringForKey:KeyChain_MD_configMd5];
    NSString * localFileMd5 = [MyMD5 md5WithFilePath:pathmd5];
    //e713eeda84959dc34dbd6a83a3ce3de5c552a1d0
    //7c773e97d8401e3b2a7d7f0495be445f7d39d8ee
    SLog(@"localFileMd5 %@",localFileMd5);
    BOOL isSameFile = [md5OnLine isEqualToString:localFileMd5];
    if (isSameFile) {
        
    
        NSData *plistData =  [NSData dataWithContentsOfFile:pathmd5 options:0 error:NULL];
        id plist = [NSPropertyListSerialization propertyListFromData:plistData
                                                    mutabilityOption:NSPropertyListImmutable
                                                              format:nil
                                                    errorDescription:nil];
        return (NSDictionary *)plist;
    }
    // request from network
    [[DAHttpClient sharedDAHttpClient] downloadFileReturnMd5:^(id obj) {
        
    }];

    NSData *plistData =  [NSData dataWithContentsOfFile:pathmd5 options:0 error:NULL];
    id plist = [NSPropertyListSerialization propertyListFromData:plistData
                                                mutabilityOption:NSPropertyListImmutable
                                                          format:nil
                                                errorDescription:nil];
    if (plist) {
        return (NSDictionary *)plist;
    }
    return @{};
}

+(id ) plistforSystemConfiguation:(TKsystemConfigType) type
{
    switch (type) {
              /* NSString */
        case TKsystemConfigType_weixinpay:
            return [self plistforSystemConfiguation][@"weixin_back"];
            break;
        case TKsystemConfigType_alipay:
            return [self plistforSystemConfiguation][@"alipay_back"];
            break;
        case TKsystemConfigType_page_size:
            return [self plistforSystemConfiguation][@"page_size"];
            break;
            
            /* NSDictionary */
            
        case TKsystemConfigType_discount_level:
            return [self plistforSystemConfiguation][@"discount_level"];
            break;
        case TKsystemConfigType_express_price:
            return [self plistforSystemConfiguation][@"express_price"];
            break;
        case TKsystemConfigType_rent_price:
            return [self plistforSystemConfiguation][@"rent_price"];
            break;

        case TKsystemConfigType_user_level:
            return [self plistforSystemConfiguation][@"user_level"];
            break;
        default:
            break;
    }
    return @"";
}

//1.0.0
+ (NSString *)bundleShortVersionString{
    static NSString *key = @"CFBundleShortVersionString";
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:key];
}

//2938
+ (NSString *)bundleBuildVersionString{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
}

+(NSString *) addAuthMD5:(NSMutableDictionary * ) parames
{
    if (!parames) {
        parames = [[NSMutableDictionary alloc] init];
    }
    
    NSString * stringToken = [USER_DEFAULT stringForKey:KeyChain_MD_account_auth_token];
    if (stringToken && stringToken.length > 0) {
        [parames  setValue:stringToken forKey:@"token"];
        NSString * userid = [USER_DEFAULT stringForKey:KeyChain_MD_account_user_id];
        [parames  setValue:userid forKey:@"user_id"];        
    }
    
    NSArray *keysArray = [parames allKeys];
   
    NSArray * reslut =  [keysArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    /*!
     format
     *  "[213412342134123:mobile]|[213421:password]|zUt1kYIZ3fZYNlonmlNniHqpgudPw4bt"
        [213412342134123:mobile]|
    */
    NSMutableString * tokenString = [NSMutableString stringWithString:@""];
    [reslut enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString * value = parames[obj];
        [tokenString appendFormat:@"[%@:%@]|",value,obj];
    }];
    
    [tokenString appendString:@"zUt1kYIZ3fZYNlonmlNniHqpgudPw4bt"];
    
    CFStringRef  aCFString = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)tokenString, NULL, (CFStringRef)@"!*’();:@&=+$,/?%#[]| ", kCFStringEncodingUTF8);
    NSString *aNSString = (__bridge NSString *)aCFString;
    
    NSString * stringmd5 = [MyMD5 md532:aNSString];
    
    [parames setValue:stringmd5 forKey:@"sign"];
    
    SLog(@"token %@  \n stringmd5: \n %@ ",aNSString , stringmd5);
    
    CFBridgingRelease(aCFString);
    return stringmd5;
}

+ (NSString *)intervalFromLastDate: (unsigned long long) dateString1  toTheDate:(unsigned long long) dateString2
{    
    NSTimeInterval cha= dateString2-dateString1;
    int hour =  (int)cha/3600;
    int day =  (int)cha/3600/24;
    if (day>0) {
        return  F(@"%d天%d小时",day,hour-24*day);
    }
    
    return F(@"%d小时%d分钟",hour,(int)cha/60%60);
}

+(NSString * ) payTypeWithIndex:(NSInteger)index
{
    switch (index) {
        case 1:
            return @"账户支付";
            break;
        case 2:
            return @"支付宝支付";
            break;
        case 3:
            return @"微信支付";
            break;
            
        default:
            break;
    }
    return @"未知";
}

+(NSString * ) orderTypeWithIndex:(NSInteger)index
{
    /*typedef enum : NSUInteger {
     paytype_Recharge = 1,
     paytype_express_TimeOut,
     paytype_hireBox,
     paytype_hireBox_TimeOut,
     paytype_TempStorage,
     paytype_TempStorage_TimeOut,
     paytype_SendExpress,
     } paytypeEnum;*/
    switch (index) {
        case paytype_Recharge:
            return @"充值";
            break;
        case paytype_express_TimeOut:
            return @"快件超期";
            break;
        case paytype_hireBox:
            return @"租用箱格";
            break;
        case paytype_hireBox_TimeOut:
            return @"租用箱格超期";
            break;
        case paytype_TempStorage:
            return @"临时存放";
            break;
        case paytype_TempStorage_TimeOut:
            return @"临时存放超期";
            break;
        case paytype_SendExpress:
            return @"寄快件";
            break;
        case paytype_PermissionLevel:
            return @"权限升级";
            break;
        default:
            break;
    }
    return @"未知";
}


/*!
 *  根据会员等级算箱子价格
 */
+(double) cell_typeForPrice:(NSInteger) cell_type
{
    int level = [DataHelper getIntegerValue:[USER_DEFAULT stringForKey:KeyChain_MD_account_user_vip_level] defaultValue:0];
    
    NSDictionary * dict = [self plistforSystemConfiguation:TKsystemConfigType_user_level];
    /*{
     "box_1" = "1.5";
     "box_2" = 2;
     "box_3" = "2.5";
     exp = 0;
     "express_exp" = 5;
     fee = 0;
     "fee_origin" = 0;
     "free_day" = 1;
     "free_time" = 1;
     "login_exp" = 1;
     "package_exp" = 1;
     "storage_times" = 0;
     }*/
    if (dict) {
        NSDictionary * values = dict[F(@"%d",level)];
        if (values) {
            
            switch (cell_type) {
                case 1: //小箱
                    return [DataHelper getDoubleValue:values[@"box_1"] defaultValue:1.5];
                    break;
                case 2://中箱
                    return [DataHelper getDoubleValue:values[@"box_2"] defaultValue:2.0];
                    break;
                case 3://大箱
                    return [DataHelper getDoubleValue:values[@"box_3"] defaultValue:2.5];
                    break;
                default:
                    break;
            }
        }
    }else{
        switch (cell_type) {
            case 1: //小箱
                return 1.5;
                break;
            case 2://中箱
                return 2.0;
                break;
            case 3://大箱
                return 2.5;
                break;
            default:
                break;
        }
    }
    return 0.0;
}

+(void) cell_typeRefresh:(NSDictionary *) data withButtons:(NSArray *) array
{
//    SLog(@"array  %@",array);
    NSArray * arrayButtons = [array firstObject];
    NSArray * arrayLabels = array[1];
    NSArray * arrayLabels_infos = [array lastObject];
    
    if (data) {
        int big_box_num = [data[@"big_box_num"] intValue];
        int middle_box_num = [data[@"middle_box_num"] intValue];
        int small_box_num = [data[@"small_box_num"] intValue];
     
        {
            //小箱子
            if (small_box_num<=5 && small_box_num>0) {
                //紧张
                ((UIButton *)arrayButtons[0]).userInteractionEnabled = YES;
                ((UIButton *)arrayButtons[0]).backgroundColor = [UIColor whiteColor];
                ((UIButton *)arrayButtons[0]).layer.borderColor = RGB(200, 199, 204).CGColor;
                ((UIButton *)arrayButtons[0]).layer.borderWidth = .5f;
                
                ((UILabel *)arrayLabels[0]).textColor = [UIColor blackColor];
                
                ((UILabel *)arrayLabels_infos[0]).textColor = HEXCOLOR(0xff5a00);
                ((UILabel *)arrayLabels_infos[0]).text = @"紧张";
            }else if (small_box_num >5)
            {
                //充足
                ((UIButton *)arrayButtons[0]).userInteractionEnabled = YES;
                
                ((UIButton *)arrayButtons[0]).backgroundColor = [UIColor whiteColor];
                ((UIButton *)arrayButtons[0]).layer.borderColor = RGB(200, 199, 204).CGColor;
                ((UIButton *)arrayButtons[0]).layer.borderWidth = .5f;
                
                ((UILabel *)arrayLabels[0]).textColor = [UIColor blackColor];
                
                ((UILabel *)arrayLabels_infos[0]).textColor = [UIColor colorWithRed:0.207 green:1.000 blue:0.105 alpha:1.000];
                ((UILabel *)arrayLabels_infos[0]).text = @"充足";
                
            }else if (small_box_num == 0)
            {
                //已满
                ((UIButton *)arrayButtons[0]).backgroundColor = [UIColor colorWithWhite:0.699 alpha:1.000];
                ((UIButton *)arrayButtons[0]).userInteractionEnabled = NO;
                
                ((UILabel *)arrayLabels[0]).textColor = [UIColor whiteColor];
                
                
                ((UILabel *)arrayLabels_infos[0]).textColor = [UIColor whiteColor];
                ((UILabel *)arrayLabels_infos[0]).text = @"已满";
                
            }
        }
        {
            //中箱子
            if (middle_box_num<=5 && middle_box_num>0) {
                //紧张
                ((UIButton *)arrayButtons[1]).userInteractionEnabled = YES;
                ((UIButton *)arrayButtons[1]).backgroundColor = [UIColor whiteColor];
                ((UIButton *)arrayButtons[1]).layer.borderColor = RGB(200, 199, 204).CGColor;
                ((UIButton *)arrayButtons[1]).layer.borderWidth = .5f;
                
                ((UILabel *)arrayLabels[1]).textColor = [UIColor blackColor];
                
                ((UILabel *)arrayLabels_infos[1]).textColor = HEXCOLOR(0xff5a00);
                ((UILabel *)arrayLabels_infos[1]).text = @"紧张";
            }else if (middle_box_num >5)
            {
                //充足
                ((UIButton *)arrayButtons[1]).userInteractionEnabled = YES;
                
                ((UIButton *)arrayButtons[1]).backgroundColor = [UIColor whiteColor];
                ((UIButton *)arrayButtons[1]).layer.borderColor = RGB(200, 199, 204).CGColor;
                ((UIButton *)arrayButtons[1]).layer.borderWidth = .5f;
                
                ((UILabel *)arrayLabels[1]).textColor = [UIColor blackColor];
                
                ((UILabel *)arrayLabels_infos[1]).textColor = [UIColor colorWithRed:0.207 green:1.000 blue:0.105 alpha:1.000];
                ((UILabel *)arrayLabels_infos[1]).text = @"充足";
                
            }else if (middle_box_num == 0)
            {
                //已满
                ((UIButton *)arrayButtons[1]).backgroundColor = [UIColor colorWithWhite:0.699 alpha:1.000];
                ((UIButton *)arrayButtons[1]).userInteractionEnabled = NO;
                
                ((UILabel *)arrayLabels[1]).textColor = [UIColor whiteColor];
                
                
                ((UILabel *)arrayLabels_infos[1]).textColor = [UIColor whiteColor];
                ((UILabel *)arrayLabels_infos[1]).text = @"已满";
            }
        }
      
        
        {
            //大箱子
            if (big_box_num<=5 && big_box_num>0) {
                //紧张
                ((UIButton *)arrayButtons[2]).userInteractionEnabled = YES;
                ((UIButton *)arrayButtons[2]).backgroundColor = [UIColor whiteColor];
                ((UIButton *)arrayButtons[2]).layer.borderColor = RGB(200, 199, 204).CGColor;
                ((UIButton *)arrayButtons[2]).layer.borderWidth = .5f;
                
                ((UILabel *)arrayLabels[2]).textColor = [UIColor blackColor];
                
                ((UILabel *)arrayLabels_infos[2]).textColor = HEXCOLOR(0xff5a00);
                ((UILabel *)arrayLabels_infos[2]).text = @"紧张";
            }else if (big_box_num >5)
            {
                //充足
                ((UIButton *)arrayButtons[2]).userInteractionEnabled = YES;
                
                ((UIButton *)arrayButtons[2]).backgroundColor = [UIColor whiteColor];
                ((UIButton *)arrayButtons[2]).layer.borderColor = RGB(200, 199, 204).CGColor;
                ((UIButton *)arrayButtons[2]).layer.borderWidth = .5f;
                
                ((UILabel *)arrayLabels[2]).textColor = [UIColor blackColor];
                
                ((UILabel *)arrayLabels_infos[2]).textColor = [UIColor colorWithRed:0.207 green:1.000 blue:0.105 alpha:1.000];
                ((UILabel *)arrayLabels_infos[2]).text = @"充足";
            }else if (big_box_num == 0)
            {
                //已满
                ((UIButton *)arrayButtons[2]).backgroundColor = [UIColor colorWithWhite:0.699 alpha:1.000];
                ((UIButton *)arrayButtons[2]).userInteractionEnabled = NO;
                
                ((UILabel *)arrayLabels[2]).textColor = [UIColor whiteColor];
                
                
                ((UILabel *)arrayLabels_infos[2]).textColor = [UIColor whiteColor];
                ((UILabel *)arrayLabels_infos[2]).text = @"已满";
            }
        }
        
    }
}


@end
