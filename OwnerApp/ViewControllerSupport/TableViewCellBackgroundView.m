//
//  TableViewCellBackgroundView.m
//  OwnerApp
//
//  Created by tinkl on 27/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "TableViewCellBackgroundView.h"
#import "TKUtilsMacro.h"

@implementation TableViewCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (id)initForCell:(UITableViewCell *)cell {
    if (self = [super initWithFrame:CGRectZero]) {
        self.type = CommonCellBackgroundViewTypeGroupSingle;
        self.cell =cell;
        self.separatorCGColor = RGB(200, 199, 204);
        if (self.type >= 6 && self.type <= 11) {
            self.backgroundColor = [UIColor whiteColor];
        } else if (self.type >= 12 && self.type <= 17) {
            self.backgroundColor = RGB(232, 232, 232);
        }
        _borderEdgeInsets = UIEdgeInsetsMake(0, -1, 0, -1);
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawGroupSeparatorLineWithContext:context rect:rect];
}


- (void)drawPlainSeparatorLineWithContext:(CGContextRef)context rect:(CGRect)rect
{
    if (self.borderEdgeInsets.left == -1) {
        self.borderInsetLeft = CGRectGetMinX(self.cell.contentView.frame) + CGRectGetMinX(self.cell.textLabel.frame);
    } else {
        self.borderInsetLeft = self.borderEdgeInsets.left;
    }
    if (self.borderEdgeInsets.right == -1 || self.borderEdgeInsets.right == 0) {
        self.borderInsetRight = CGRectGetWidth(rect);
    } else {
        self.borderInsetRight = CGRectGetWidth(rect) - self.borderEdgeInsets.right;
    }
    
    CGContextSetStrokeColorWithColor(context, self.separatorCGColor.CGColor);
    CGContextSetLineWidth(context, 1);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, self.borderInsetLeft, CGRectGetHeight(rect));
    CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
    CGContextStrokePath(context);
    
    if (self.type == CommonCellBackgroundViewTypePlainNormal || self.type == CommonCellBackgroundViewTypePlainNormalHighlighted) {
        
    }
}

- (void)drawGroupSeparatorLineWithContext:(CGContextRef)context rect:(CGRect)rect {
    if (self.borderEdgeInsets.left == -1) {
        self.borderInsetLeft = CGRectGetMinX(self.cell.contentView.frame) + CGRectGetMinX(self.cell.textLabel.frame);
    } else {
        self.borderInsetLeft = self.borderEdgeInsets.left;
    }
    if (self.borderEdgeInsets.right == -1 || self.borderEdgeInsets.right == 0) {
        self.borderInsetRight = CGRectGetWidth(rect);
    } else {
        self.borderInsetRight = CGRectGetWidth(rect) - self.borderEdgeInsets.right;
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
//        CGContextAddLineToPoint(context, self.borderInsetRight, 0);
        CGContextStrokePath(context);
        CGContextBeginPath(context);
        CGContextMoveToPoint(context, 0, CGRectGetHeight(rect));
        CGContextAddLineToPoint(context, self.borderInsetRight, CGRectGetHeight(rect));
        CGContextStrokePath(context);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
