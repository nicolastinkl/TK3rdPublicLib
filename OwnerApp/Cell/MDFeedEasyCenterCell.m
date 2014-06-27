//
//  MDFeedEasyCenterCell.m
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDFeedEasyCenterCell.h"
#import "UIView+Additon.h"
#import "CommonTableView.h"
#import "TKUtilsMacro.h"
#import "CommonCellBackgroundViewHelper.h"

@interface MDFeedEasyCenterCell ()


@end

@implementation MDFeedEasyCenterCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.enabled = YES;
    self.position = -1;
    self.borderEdgeInsets = UIEdgeInsetsMake(0, -1, 0, -1);
    
    if (IOS6) {
        self.parentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }else{
        self.backgroundColor= RGB(244, 244, 244);
    }
    // iOS7下背景色默认白色，之前的版本背景色继承tableView，这里统一设置为白色
    // 这里其实只对iOS7有作用，因为iOS6下通过setCellUIByPosition设置了两个view，所以覆盖了这两个设置
//    self.backgroundView =[[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
//    self.backgroundColor = RGB(244, 244, 244);
    self.selectedBackgroundView = [[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
    self.selectedBackgroundView.backgroundColor = RGB(232, 232, 232);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setCellUIByPosition:(CommonTableViewCellPosition)position
{
    if (self.position != position) {
        // 对于iOS6及以下版本的系统，背景模拟iOS7的风格
        if (IOS6) {
            self.backgroundView = [CommonCellBackgroundViewHelper backgroundViewForTableViewCell:self withType:[CommonCellBackgroundViewHelper CommonTableViewCellPositionToBackgroundViewType:position selected:false]];
            self.selectedBackgroundView = [CommonCellBackgroundViewHelper backgroundViewForTableViewCell:self withType:[CommonCellBackgroundViewHelper CommonTableViewCellPositionToBackgroundViewType:position selected:true]];
        }
    }
   
    self.position = position;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 对于iOS6及以下版本的系统，背景在默认、编辑时都固定不动，模拟iOS7
    if (IOS6) {
        self.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.backgroundView.backgroundColor = RGB(240, 240, 240);
        self.selectedBackgroundView.frame = self.backgroundView.frame;
        if (self.parentTableView.style == UITableViewStyleGrouped) {
            // 为了跟iOS7保持同样的X，这里将contentView缩小5（原本是10）
            self.contentView.frame = CGRectSetX(self.contentView.frame, CGRectGetMinX(self.contentView.frame) - 5);
        }
    }
}

@end
