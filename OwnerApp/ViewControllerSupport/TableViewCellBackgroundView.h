//
//  TableViewCellBackgroundView.h
//  OwnerApp
//
//  Created by tinkl on 27/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface TableViewCellBackgroundView : UIView

@property(nonatomic, weak) UITableViewCell *cell;
@property(nonatomic, assign) CommonCellBackgroundViewType type;
@property(nonatomic,assign) UIEdgeInsets borderEdgeInsets;
@property(nonatomic, retain) UIColor *separatorCGColor;
@property(nonatomic, assign) CGFloat borderInsetLeft;
@property(nonatomic, assign) CGFloat borderInsetRight;
- (id)initForCell:(UITableViewCell *)cell ;
@end
