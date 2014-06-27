//
//  CommonTableView.m
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import "CommonTableView.h"
#import "CommonUI.h"

@implementation CommonTableView

- (id)initWithFrame:(CGRect)frame
{
    return [super initWithFrame:frame style:UITableViewStylePlain];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        // iOS6会根据这个颜色来画边框
        self.separatorColor = UIColorMake(200, 199, 204);
        // 不同style的列表，背景色不一样
        if (style == UITableViewStylePlain) {
            self.backgroundView = [[UIView alloc] init];
            self.backgroundView.backgroundColor = UIColorWhite;
        } else {
            self.backgroundView = [[UIView alloc] init];
            self.backgroundView.backgroundColor = UIColorMake(240, 240, 240);
        }
    }
    return self;
}

- (CommonTableViewCellPosition)getCellPositionInTableView:(UITableView *)tableView positionForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.style == UITableViewStyleGrouped) {
        NSInteger numberOfRowsInSection = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
        if (numberOfRowsInSection == 1) {
            return CommonTableViewCellPositionSingleInSection;
        }
        if (indexPath.row == 0) {
            return CommonTableViewCellPositionFirstInSection;
        }
        if (indexPath.row == numberOfRowsInSection - 1) {
            return CommonTableViewCellPositionLastInSection;
        }
        return CommonTableViewCellPositionMiddleInSection;
    } else {
        NSInteger numberOfSectionInTableView = [tableView.dataSource numberOfSectionsInTableView:tableView];
        NSInteger numberOfRowsInSection = [tableView.dataSource tableView:tableView numberOfRowsInSection:indexPath.section];
        if (indexPath.section != numberOfSectionInTableView - 1 && numberOfRowsInSection - 1 == indexPath.row) {
            return CommonTableViewCellPositionNotInLastSectionAndLastInSection;
        } else {
            return CommonTableViewCellPositionNormal;
        }
    }
    return CommonTableViewCellPositionNormal;
}

@end
