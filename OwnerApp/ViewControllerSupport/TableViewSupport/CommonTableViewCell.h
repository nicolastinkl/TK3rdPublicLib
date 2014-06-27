//
//  CommonTableViewCell.h
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTableView.h"

@interface CommonTableViewCell : UITableViewCell

@property(nonatomic,assign,getter = isEnabled) BOOL enabled;

@property(nonatomic, weak) UITableView *parentTableView;
@property(nonatomic, assign) CommonTableViewCellPosition position;
@property(nonatomic,assign) UIEdgeInsets borderEdgeInsets;
@property(nonatomic,assign) UIColor * separatorStyleDiy;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

- (id)initForTableView:(UITableView *)tableView withStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (id)initForTableView:(UITableView *)tableView withReuseIdentifier:(NSString *)reuseIdentifier;// 首选初始化方法

- (void)setCellUIByPosition:(CommonTableViewCellPosition)position;

@end
