//
//  MDMyPermissionsCell.m
//  OwnerApp
//
//  Created by tinkl on 19/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDMyPermissionsCell.h"
#import "TKUtilsMacro.h"

@implementation MDMyPermissionsCell

//- (void)awakeFromNib
//{
//    if (IOS6) {        
//        // Initialization code
//        self.backgroundView = [[UIView alloc] init];
//        self.selectedBackgroundView = [[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
//        self.selectedBackgroundView.backgroundColor = RGB(232, 232, 232);
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)layoutSubviews
//{
//    [super layoutSubviews];
//    // 对于iOS6及以下版本的系统，背景在默认、编辑时都固定不动，模拟iOS7
//    if (IOS6) {
//        self.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
//        self.backgroundView.backgroundColor = [UIColor whiteColor];
//        self.selectedBackgroundView.frame = self.backgroundView.frame;
//        self.contentView.frame = CGRectSetX(self.contentView.frame, CGRectGetMinX(self.contentView.frame) - 5);
//    }
//}

@end
