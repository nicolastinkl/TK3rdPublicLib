//
//  MDAppDelegate.h
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface MDAppDelegate : UIResponder <UIApplicationDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) NSMutableDictionary * viewcontrollersDicty;

+(BOOL) hasLogin;
@end
