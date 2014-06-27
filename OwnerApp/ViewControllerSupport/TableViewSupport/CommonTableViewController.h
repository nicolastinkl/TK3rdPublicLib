//
//  CommonTableViewController.h
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonTableView.h"

@interface CommonTableViewController : CommonViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CommonTableView *tableView;

- (id)initWithStyle:(UITableViewStyle)style; // 默认的init方法
- (id)init; // 等同于[self initWithStyle:UITableViewStylePlain]

// 子类继承
- (void)initTableview;

@end
