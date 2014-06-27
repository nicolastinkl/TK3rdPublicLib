//
//  CommonTableViewCell.m
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import "CommonTableViewCell.h"
#import "CommonUI.h"
#import "CommonCellBackgroundViewHelper.h"

@interface CommonTableViewCell()
//@property(nonatomic, weak, readwrite) CommonTableView *parentTableView;
@end

@implementation CommonTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _enabled = YES;
        _position = -1;
        _borderEdgeInsets = UIEdgeInsetsMake(0, -1, 0, -1);
        if (IOS_VERSION < 7) {
            // 屏蔽iOS6默认的高亮时反白
            self.textLabel.highlightedTextColor = nil;
            self.detailTextLabel.highlightedTextColor = nil;
        }
        // iOS7下背景色默认白色，之前的版本背景色继承tableView，这里统一设置为白色
        // 这里其实只对iOS7有作用，因为iOS6下通过setCellUIByPosition设置了两个view，所以覆盖了这两个设置
        self.backgroundColor = UIColorWhite;
        self.selectedBackgroundView = [[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
        self.selectedBackgroundView.backgroundColor = UIColorMake(232, 232, 232);
    }
    return self;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (id)initForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [self initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.parentTableView = tableView;
        if (IOS_VERSION < 7) {
            self.parentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
    }
    return self;
}

- (id)initForTableView:(UITableView *)tableView withReuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initForTableView:tableView withStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}

- (void)setCellUIByPosition:(CommonTableViewCellPosition)position
{
    if (self.position != position) {
        // 对于iOS6及以下版本的系统，背景模拟iOS7的风格
        if (IOS_VERSION < 7) {
            self.backgroundView = [CommonCellBackgroundViewHelper backgroundViewForTableViewCell:self withType:[CommonCellBackgroundViewHelper CommonTableViewCellPositionToBackgroundViewType:position selected:false]];
            self.selectedBackgroundView = [CommonCellBackgroundViewHelper backgroundViewForTableViewCell:self withType:[CommonCellBackgroundViewHelper CommonTableViewCellPositionToBackgroundViewType:position selected:true]];
        }
    }
    self.position = position;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.textLabel setBackgroundColor:backgroundColor];
    [self.detailTextLabel setBackgroundColor:backgroundColor];
    // iOS6下backgroundView会覆盖self.backgroundColor，所以需要设置self.backgroundView.backgroundColor
    if (IOS_VERSION < 7) {
        self.backgroundView.backgroundColor = backgroundColor;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing) {
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    } else {
        self.selectedBackgroundView.backgroundColor = UIColorMake(232, 232, 232);
    }
}

- (void)setEnabled:(BOOL)enabled
{
    if (_enabled != enabled) {
        if (enabled) {
            self.userInteractionEnabled = YES;
            self.textLabel.textColor = [UIColor blackColor];
            self.detailTextLabel.textColor = UIColorGray;
        } else {
            self.userInteractionEnabled = NO;
            self.textLabel.textColor = UIColorGray;
            self.detailTextLabel.textColor = UIColorGray;
        }
        _enabled = enabled;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 对于iOS6及以下版本的系统，背景在默认、编辑时都固定不动，模拟iOS7
    if (IOS_VERSION < 7) {
        self.backgroundView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        self.selectedBackgroundView.frame = self.backgroundView.frame;
        if (self.parentTableView.style == UITableViewStyleGrouped) {
            // 为了跟iOS7保持同样的X，这里将contentView缩小5（原本是10）
            self.contentView.frame = CGRectSetX(self.contentView.frame, CGRectGetMinX(self.contentView.frame) - 5);
        }
    }
}

@end
