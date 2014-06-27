//
//  CommonTableViewController.m
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import "CommonTableViewController.h"
#import "CommonUI.h"

@interface CommonTableViewController ()
@property(nonatomic, assign) UITableViewStyle style;
@end

@implementation CommonTableViewController

#pragma mark - init

- (id)init
{
    return [self initWithStyle:UITableViewStylePlain];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init])
    {
        _style = style;
    }
    return self;
}

- (void)initSubviews
{
    [super initSubviews];
    [self initTableview];
}

- (void)initTableview
{
    if (IOS_VERSION >= 7) {
        _tableView = [[CommonTableView alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))) style:self.style];
    } else {
        _tableView = [[CommonTableView alloc] initWithFrame:CGRectMakeWithSize(CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - NAVIGATIONBAR_HEIGHT - CGRectGetHeight(self.tabBarController.tabBar.frame))) style:self.style];
    }
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    if (IOS_VERSION >= 7) {
//        return 0.0f;
//    }
//    return 30;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark - 生命周期

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.tableView.style == UITableViewStylePlain) {
        self.view.backgroundColor = [UIColor whiteColor];
    } else {
        self.view.backgroundColor = UIColorMake(240, 240, 240);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
