//
//  UITableView+NoMoreData.m
//  OwnerApp
//
//  Created by tinkl on 8/6/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "UITableView+NoMoreData.h"
#import "MDUINoMoreView.h"
#import "UIView+Additon.h"

@implementation UITableView (NoMoreData)

-(void) showNoMoreData
{
    
    if (![self.tableFooterView subviewWithTag:10]) {
        
        MDUINoMoreView * errorView = [[NSBundle mainBundle] loadNibNamed:@"MDUINoMoreView" owner:self options:nil][0];
        errorView.tag = 10;
        
        self.tableFooterView  = errorView;
    }
}


@end
