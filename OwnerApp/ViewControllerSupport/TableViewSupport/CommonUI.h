//
//  CommonUI.h
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import <Foundation/Foundation.h>

// iOS版本
#ifndef IOS_VERSION
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#endif

// 颜色
#define UIColorClear [UIColor clearColor]
#define UIColorBlack [UIColor blackColor]
#define UIColorWhite [UIColor whiteColor]
#define UIColorGray  [UIColor grayColor]
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UIColorMakeRGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/1.0]

// size
#define UIFontMake(size) [UIFont systemFontOfSize:size]
#define NAVIGATIONBAR_HEIGHT 44

// style
#define CELL_TEXTLABEL_FORMAT(label) [label setFont:UIFontMake(17)];[label setTextColor:[UIColor blackColor]];

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

@interface CommonUI : NSObject

@end
