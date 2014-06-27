//
//  CommonViewController.m
//  iOS7UITableView
//
//  Created by zhoonchen on 14-1-6.
//  Copyright (c) 2014年 zhoon. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonUI.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (id)init
{
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(extendedLayoutIncludesOpaqueBars)]) {
            self.extendedLayoutIncludesOpaqueBars = YES;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorMake(240, 240, 240);
    [self initNavigationItems];
	[self initSubviews];
}

- (void)initSubviews
{
}

- (void)initNavigationItems
{
    self.navigationItem.title = @"Title";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
