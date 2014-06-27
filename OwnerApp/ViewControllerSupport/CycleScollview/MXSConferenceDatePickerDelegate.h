//
//  NSObject_MXSConferenceDatePickerDelegate.h
//  RBCustomDateTimePicker
//
//  Created by tinkl on 21/5/14.
//  Copyright (c) 2014 renbing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RBCustomDatePickerView;
//Protocol to return the date
@protocol MXSConferenceDatePickerDelegate <NSObject>

@optional

- (void)conferenceDatePicker:(RBCustomDatePickerView *)datePicker saveDate:(NSDate *)date;

@end
