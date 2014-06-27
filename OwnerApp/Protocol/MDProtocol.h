//
//  MDProtocol.h
//  OwnerApp
//
//  Created by tinkl on 18/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MDProtocol <NSObject>

@end

/*!
 *  Feed Center protocol
 */
@protocol MDFeedEasyCenterTableViewControllerProtocol <NSObject>

@end

/*!
 * Left side protocol
 */
@protocol MDSideDrawerViewControllerProtocol <NSObject>

@end

/*!
 *  myexpress view protocol
 */
@protocol MDMyExpressViewControllerProtocol <NSObject>

@end

/*!
 *  我的权限
 */
@protocol MDMyPermissionsViewControllerProtocol <NSObject>

@end

/*!
 *  实名认证
 */
@protocol MDRealNameAuthViewControllerProtocol <NSObject>

@end

/*!
 *  修改个人信息 change to 修改密码 by tinkl
 */
@protocol MDModifyPersonalInfoViewControllerProtocol <NSObject>

@end

/*!
 *  我的订单 = 查看明细
 */
@protocol MDMyOrderViewControllerProtocol <NSObject>

@end


/*!
 * 充值
 */
@protocol MDRechargeViewControllerProtocol <NSObject>

@end

/*!
 *  我的权限类型，
 */
@protocol MDMyPermissionsDetailViewControllerProtocol <NSObject>
-(void) configPermissionType:(NSInteger) type;
@end


