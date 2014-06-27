//
//  MDLeftSideCell.m
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDLeftSideCell.h"
#import "TKUtilsMacro.h"

@implementation MDLeftSideCell

- (void)awakeFromNib
{
    self.backgroundView = [[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
    self.backgroundView.backgroundColor = HEXCOLOR(0x2b292f);
    
    self.selectedBackgroundView = [[UIView alloc] init]; // 需要赋值一个UIView，设置backgroundColor才有作用
    self.selectedBackgroundView.backgroundColor =  HEXCOLOR(0x343338);//RGB(232, 232, 232);
    
    // Initialization code
    //if (!cell) {
//    cell = [[CommonTableViewCell alloc] initForTableView:tableView withReuseIdentifier:FirstCellId];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

//- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated               // animate between regular and
//{    
//    if (highlighted) {
//        self.contentView.backgroundColor = HEXCOLOR(0x344448);
//    }else{
//        self.contentView.backgroundColor = HEXCOLOR(0x2b292f);
//    }
//}

@end
