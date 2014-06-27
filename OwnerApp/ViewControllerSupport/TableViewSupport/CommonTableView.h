//
//  CommonTableView.h
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CommonTableViewCellPosition) {
    //group
    CommonTableViewCellPositionFirstInSection = 0,
    CommonTableViewCellPositionMiddleInSection,
    CommonTableViewCellPositionLastInSection,
    CommonTableViewCellPositionSingleInSection,
    // plain
    CommonTableViewCellPositionNormal,
    CommonTableViewCellPositionNotInLastSectionAndLastInSection
};

@interface CommonTableView : UITableView

- (CommonTableViewCellPosition)getCellPositionInTableView:(UITableView *)tableView positionForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
