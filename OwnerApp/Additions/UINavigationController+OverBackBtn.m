//
//  UINavigationController+OverBackBtn.m
//  yunqi
//
//  Created by apple on 4/22/14.
//  Copyright (c) 2014 jijia. All rights reserved.
//

#import "UINavigationController+OverBackBtn.h"

@implementation UINavigationController (OverBackBtn)

-(void) ios6backview
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        
        UIImage *buttonImage = [UIImage imageNamed:@"WebView_Backward_disable"];

        UIImage *backButtonImage = [buttonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, buttonImage.size.width - 1, 0, 0)];
        [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage  forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -backButtonImage.size.height*2) forBarMetrics:UIBarMetricsDefault];
        
        /*
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setImage:buttonImage forState:UIControlStateNormal];
        
        
        button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
        
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        UIBarButtonItem *customBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
//        self.navigationItem.leftBarButtonItem = customBarItem;
        self.navigationController.navigationItem.backBarButtonItem =customBarItem;
//        self.navigationController.navigationItem.leftBarButtonItem = customBarItem;
         */
    }
 

}


-(void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
