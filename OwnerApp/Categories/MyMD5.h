//
//  MyMD5.h
//  GoodLectures
//
//  Created by yangshangqing on 11-10-11.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MyMD5 : NSObject {
    
}
/*****
 2011.09.15
 创建： shen
 MD5 加密
 *****/

+(NSString *) md5: (NSString *) inPutText ;

/**
 *  16位
 *
 *  @param inputtext <#inputtext description#>
 *
 *  @return <#return value description#>
 */
+(NSString*) md532 :(NSString * ) inputtext;


/*!
 * 文件MD5 值
 */

+(NSString*) md5WithFilePath :(NSString * ) filepath;

+(NSString*) md5WithFilePathURL :(NSURL * ) filepath;
@end
