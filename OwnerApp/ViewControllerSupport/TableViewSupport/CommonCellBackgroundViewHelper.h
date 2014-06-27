//
//  CommonCellBackgroundViewHelper.h
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonTableView.h"
#import "CommonTableViewCell.h"

typedef NS_ENUM(NSInteger, CommonCellBackgroundViewType) {
    CommonCellBackgroundViewTypeGroupFirst = 6,
    CommonCellBackgroundViewTypeGroupMiddle,
    CommonCellBackgroundViewTypeGroupLast,
    CommonCellBackgroundViewTypeGroupSingle,
    CommonCellBackgroundViewTypePlainNormal,
    CommonCellBackgroundViewTypePlainNotInLastSectionAndLastInSection,
    CommonCellBackgroundViewTypeGroupFirstHighlighted = 12,
    CommonCellBackgroundViewTypeGroupMiddleHighlighted,
    CommonCellBackgroundViewTypeGroupLastHighlighted,
    CommonCellBackgroundViewTypeGroupSingleHighlighted,
    CommonCellBackgroundViewTypePlainNormalHighlighted,
    CommonCellBackgroundViewTypePlainNotInLastSectionAndLastInSectionHighlighted,
};

@interface CommonCellBackgroundViewHelper : NSObject

+ (NSInteger)CommonTableViewCellPositionToBackgroundViewType:(CommonTableViewCellPosition)position selected:(BOOL)selected;
+ (UIView *)backgroundViewForTableViewCell:(CommonTableViewCell *)cell withType:(CommonCellBackgroundViewType)type;

@end


