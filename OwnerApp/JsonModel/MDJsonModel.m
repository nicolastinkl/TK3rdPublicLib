//
//  MDJsonModel.m
//  OwnerApp
//
//  Created by tinkl on 23/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "MDJsonModel.h"

@implementation MDJsonModel

@end


@implementation MDExpressModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


//+(JSONKeyMapper*)keyMapper
//{
//    return [[JSONKeyMapper alloc] initWithDictionary:@{
//                                                       @"id":@"express_id"
//                                                       }];
//}
//

@end

@implementation MDBoxHireModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}



@end


@implementation MDBoxHireHistoryModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id":@"boxhire_id",
                                                       @"end_date": @"updated_at",
                                                       @"start_date":@"create_at"
                                                       }];
}

@end

@implementation MDMyExpressModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end



@implementation MDDeviceModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end



@implementation MDLatticeModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end

@implementation MDPayTypeModel


+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}

@end


@implementation MDSendExpressListModel

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"eid"
                                                       }];
}


@end


@implementation MDOrderPay



@end


@implementation MDCourierInfo

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}


@end