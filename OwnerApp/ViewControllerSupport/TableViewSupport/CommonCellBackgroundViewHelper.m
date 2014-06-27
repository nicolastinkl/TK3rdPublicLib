//
//  CommonCellBackgroundViewHelper.m
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import "CommonCellBackgroundViewHelper.h"
#import "CommonUI.h"

@interface CommonCellBackgroundView : UIView

@property(nonatomic, weak) CommonTableViewCell *cell;
@property(nonatomic, assign) CommonCellBackgroundViewType type;
@property(nonatomic, retain) UIColor *separatorCGColor;
@property(nonatomic, assign) CGFloat borderInsetLeft;
@property(nonatomic, assign) CGFloat borderInsetRight;

- (id)initForCell:(CommonTableViewCell *)cell withType:(CommonCellBackgroundViewType)type;

@end

@implementation CommonCellBackgroundView

- (id)initForCell:(CommonTableViewCell *)cell withType:(CommonCellBackgroundViewType)type {
    if (self = [super initWithFrame:CGRectZero]) {
        self.type = type;
        self.cell = cell;
        self.separatorCGColor = cell.parentTableView.separatorColor;
        if (self.type >= 6 && self.type <= 11) {
            self.backgroundColor = UIColorWhite;
        } else if (self.type >= 12 && self.type <= 17) {
            self.backgroundColor = UIColorMake(232, 232, 232);
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.cell.parentTableView.style == UITableViewStyleGrouped) {
        [self drawGroupSeparatorLineWithContext:context rect:rect];
    } else if (self.cell.parentTableView.style == UITableViewStylePlain) {
        [self drawPlainSeparatorLineWithContext:context rect:rect];
    } else {
        return ;
    }
}
- (void)drawPlainSeparatorLineWithContext:(CGContextRef)context rect:(CGRect)rect
{
    if (self.cell.borderEdgeInsets.left == -1) {
        self.borderInsetLeft = CGRectGetMinX(self.cell.contentView.frame) + CGRectGetMinX(self.cell.textLabel.frame);
    } else {
        self.borderInsetLeft = self.cell.borderEdgeInsets.left;
    }
    if (self.cell.borderEdgeInsets.right == -1 || self.cell.borderEdgeInsets.right == 0) {
        self.borderInsetRight = CGRectGetWidth(rect);
    } else {
        self.borderInsetRight = CGRectGetWidth(rect) - self.cell.borderEdgeInsets.right;
    }
    
    if (self.type == CommonCellBackgroundViewTypePlainNormal || self.type == CommonCellBackgroundViewTypePlainNormalHighlighted) {
        CGContextSetStrokeColorWithColor(context, self.separatorCGColor.CGColor);
        CGContextSetLineWidth(context, 1);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, self.borderInsetLeft, CGRectGetHeight(rect));
        CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
        CGContextStrokePath(context);
    }
}
- (void)drawGroupSeparatorLineWithContext:(CGContextRef)context rect:(CGRect)rect {
    if (self.cell.borderEdgeInsets.left == -1) {
        self.borderInsetLeft = CGRectGetMinX(self.cell.contentView.frame) + CGRectGetMinX(self.cell.textLabel.frame);
    } else {
        self.borderInsetLeft = self.cell.borderEdgeInsets.left;
    }
    if (self.cell.borderEdgeInsets.right == -1 || self.cell.borderEdgeInsets.right == 0) {
        self.borderInsetRight = CGRectGetWidth(rect);
    } else {
        self.borderInsetRight = CGRectGetWidth(rect) - self.cell.borderEdgeInsets.right;
    }
    CGContextSetStrokeColorWithColor(context, self.separatorCGColor.CGColor);
    CGContextSetLineWidth(context, 1);
    if (self.type == CommonCellBackgroundViewTypeGroupFirst || self.type == CommonCellBackgroundViewTypeGroupFirstHighlighted) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, self.borderInsetRight, 0);
        CGContextStrokePath(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, self.borderInsetLeft, CGRectGetHeight(rect));
        CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
        CGContextStrokePath(context);
    } else if (self.type == CommonCellBackgroundViewTypeGroupMiddle || self.type == CommonCellBackgroundViewTypeGroupMiddleHighlighted) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, self.borderInsetLeft, CGRectGetHeight(rect));
        CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
        CGContextStrokePath(context);
    } else if (self.type == CommonCellBackgroundViewTypeGroupLast || self.type == CommonCellBackgroundViewTypeGroupLastHighlighted) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, CGRectGetHeight(rect));
        CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
        CGContextStrokePath(context);
    } else if (self.type == CommonCellBackgroundViewTypeGroupSingle || self.type == CommonCellBackgroundViewTypeGroupSingleHighlighted) {
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, self.borderInsetRight, 0);
        CGContextStrokePath(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, CGRectGetHeight(rect));
        CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
        CGContextStrokePath(context);
    }
}

@end

@implementation CommonCellBackgroundViewHelper

+ (UIView *)backgroundViewForTableViewCell:(CommonTableViewCell *)cell withType:(CommonCellBackgroundViewType)type
{
    return [[CommonCellBackgroundView alloc] initForCell:cell withType:type];
}

+ (NSInteger)CommonTableViewCellPositionToBackgroundViewType:(CommonTableViewCellPosition)position selected:(BOOL)selected
{
    if (selected) {
        return position + 6 + 6;
    } else {
        return position + 6;
    }
    return 0;
}

@end
