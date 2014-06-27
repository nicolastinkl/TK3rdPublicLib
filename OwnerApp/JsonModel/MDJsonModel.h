//
//  MDJsonModel.h
//  OwnerApp
//
//  Created by tinkl on 23/5/14.
//  Copyright (c) 2014 ___TINKL___. All rights reserved.
//

#import "JSONModel.h"

@interface MDJsonModel : JSONModel

@end

/*!
 *  ======================
 *  增加快件model
 *  ======================
 */
@interface MDExpressModel : JSONModel

@property (nonatomic, assign) NSInteger             express_id;
@property (nonatomic, strong) NSString              *express_company;
@property (nonatomic, assign) NSInteger             status;

@property (nonatomic, strong) NSString              *open_code;
@property (nonatomic, strong) NSString              *package_name;
@property (nonatomic, strong) NSString<Optional>    *package_image;

@property (nonatomic, strong) NSString<Optional>    *recipient_name;
@property (nonatomic, strong) NSString<Optional>    *recipient_mobile;
@property (nonatomic, strong) NSString<Optional>    *recipient_addr;

@property (nonatomic, strong) NSString              *courier;
@property (nonatomic, strong) NSString<Optional>    *courier_mobile;

@property (nonatomic, strong) NSString<Optional>    *recipient_province;
@property (nonatomic, strong) NSString<Optional>    *recipient_city;
@property (nonatomic, strong) NSString<Optional>    *recipient_area;

@property (nonatomic, assign) NSInteger             lattice_id;
@property (nonatomic, strong) NSString<Optional>    *lattice_name;
@property (nonatomic, assign) NSInteger             device_id;
@property (nonatomic, strong) NSString<Optional>    *device_addr;
@property (nonatomic, assign) NSInteger             fee;
@property (nonatomic, assign) NSInteger             cell_type;

@property (nonatomic, assign) unsigned long long    send_date;

@end

/*!
 *  ======================
 *  增加租用箱格 model
 *  ======================
 参数：lattice_id,device_id,cell_type,start_date,end_date,lattice_name,device_addr
 返回：rent_id
 */
@interface MDBoxHireModel : JSONModel

@property (nonatomic, assign) NSInteger             lattice_id;
@property (nonatomic, assign) NSInteger             device_id;
@property (nonatomic, assign) NSInteger              cell_type;
@property (nonatomic, assign) unsigned long long    start_date;
@property (nonatomic, assign) unsigned long long    end_date;

@property (nonatomic, strong) NSString<Optional>    *lattice_name;
@property (nonatomic, strong) NSString<Optional>    *device_addr;
@property (nonatomic, strong) NSString<Optional>    *days;
@end

/*!
 *  ======================
 *  箱格历史 model
 *  ======================
 参数：lattice_id,device_id,cell_type,start_date,end_date,lattice_name,device_addr
 返回：rent_id
 */
@interface MDBoxHireHistoryModel : JSONModel

@property (nonatomic, assign) NSInteger             boxhire_id;
@property (nonatomic, assign) NSInteger             lattice_id;
@property (nonatomic, assign) NSInteger             device_id;
@property (nonatomic, assign) NSInteger              cell_type;
@property (nonatomic, assign) unsigned long long    create_at;
@property (nonatomic, assign) unsigned long long    updated_at;



@property (nonatomic, strong) NSString<Optional>    *lattice_name;
@property (nonatomic, strong) NSString<Optional>    *device_addr;

@property (nonatomic, assign) NSInteger             status;
@property (nonatomic, strong) NSString<Optional>    *open_code;

@end


/*!
 *  我的快件
 */
@interface MDMyExpressModel : JSONModel

@property (nonatomic, strong) NSString<Optional>    *bar_code;
@property (nonatomic, strong) NSString<Optional>    *client_tel;
@property (nonatomic, strong) NSString<Optional>    *company;
@property (nonatomic, assign) NSInteger             express_status;

@property (nonatomic, assign) unsigned long long    send_time;
@property (nonatomic, assign) NSInteger             over_days;
@property (nonatomic, strong) NSString<Optional>    *send_tel;
@property (nonatomic, strong) NSString<Optional>    *send_man;

@property (nonatomic, strong) NSString<Optional>    *lattice_name;
@property (nonatomic, strong) NSString<Optional>    *device_name;
@property (nonatomic, assign) NSInteger             storage_time;

@property (nonatomic, strong) NSString<Optional>    *tack_pin;

@end



/*!
 *  速递易柜子 地址
 */

@protocol MDDeviceModel

@end
@interface MDDeviceModel : JSONModel
/*{
 "device_id":30,
 "devce_add":"武侯小区物管中心旁"*/

@property (nonatomic, assign) NSInteger             device_id;
@property (nonatomic, strong) NSString<Optional>    *devce_add;

@end


/*!
 *  搜索 网点地址
 */
@class MDDeviceModel;
@interface MDLatticeModel : JSONModel

@property (nonatomic, assign) NSInteger             lattice_id;
@property (nonatomic, strong) NSString<Optional>    *lattice_name;

@property (nonatomic, strong) NSArray<MDDeviceModel,Optional> *devices;
@end



/*!
 *  支付类型
 order_type: 业务类型 1 => 充值, 2 => 快件超期支付, 3 => 租用, 4 => 租用超期, 5 => 存放, 6 => 存放超期, 7 => 寄件
 for_id:业务ID
 pay_type: 支付类型，1 => 余额， 2 => 支付宝， 3 => 微信
 fee:金额  分为单位
 */
@interface MDPayTypeModel : JSONModel

@property (nonatomic, assign) NSInteger             order_type;
@property (nonatomic, strong) NSString<Optional>    *for_id;
@property (nonatomic, assign) NSInteger             pay_type;
@property (nonatomic, assign) double                fee;
@property (nonatomic, strong) NSString<Optional>    *sign_str;

@end


@interface MDSendExpressListModel : MDExpressModel

@property (nonatomic, assign) NSInteger             eid;
@property (nonatomic, strong) NSString<Optional>    *deposit_open_code;
@property (nonatomic, strong) NSString<Optional>    *back_open_code;
@property (nonatomic, strong) NSString<Optional>    *bar_code;

@property (nonatomic, assign) unsigned long long    created_at;
@property (nonatomic, assign) unsigned long long    updated_at;

@end

/*!
 
 支出类型
 
 *  "order_type" => "1",
 "pay_type" => "3",
 "total_fee" => "300",
 "created_at" => "1401778340",
 */
@interface MDOrderPay : JSONModel

@property (nonatomic, assign) NSInteger             order_type;
@property (nonatomic, assign) NSInteger             pay_type;
@property (nonatomic, assign) double                total_fee;
@property (nonatomic, assign) unsigned long long    created_at;

@end


@interface MDCourierInfo : JSONModel


@property (nonatomic, strong) NSString<Optional>    *name;
@property (nonatomic, strong) NSString<Optional>    *mobile;

@end



