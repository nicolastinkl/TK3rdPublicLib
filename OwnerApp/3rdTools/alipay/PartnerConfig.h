//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088311868782039"
//收款支付宝账号
#define SellerID  @"liaojy@sudiyi.net"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAL8lcOW8NKC0XOhhxzmy5GyhtQtpQWqsE/6+A067VeLLObDKQrC1qMt/7oOMD1KW1Mv0/b3b0UzlxrGDamcJod6VQyZoln8txkhklMFfKX3lM/FOYcXz5wS7GRU4AjiLJaLBWsP3UOrCzNM+bvgv6rMJgIUpyhtyHkrdVAQSBDc5AgMBAAECgYBG0v2o8fpiDVJbfFdQRruikKw/ZSmq98WU3xzkoD8rgHeIzPi29yhq9qUOsue+h0qjo8wc/ATqRD1B6tqTARurdFuEspNakYafAe2waVVd4aRg7Vxh9Ju908+UkKQ+DNqmzvoMkVz2Z1CaBdEbC6kKVd3q8IBsmNPr0OmjyII4AQJBAOogQgJuSNlFP5QyZcCmEN7RsH53NyccXeolCBpfWE0WE0NTE/bblY13az1nnW5/dm9/8PkiZ5fmqlH7GlCFXDkCQQDRATVym2gyWviNSQrHuc0ThE88ouM2c0Whh45PWyNy7Fz3er2z12ksMX7Vl8aTHa/s5OWNMSnMMMSPCvoIG7MBAkA5okk9mfJ68c4N6D4eJ4M9prbg2u4LxbLkwcr12wS8rTN+vkPK4BE3qu8ORaR+oAgCuKcUXUDNJu5EkiDPM5UZAkEAyMlQf3ms8DNU9OZm5NkqmsVRGf+iKH01N6jynmn/9Df+WAIinNMkxsAGCUx2CH9Ms1hy7uF8Nh3jt0fkTEXQAQJBAJLVRSUf6FCxL/MYxd1Ls8us7FU+bzRhXkR6m3lurUyRItkrtbv2kdpegBHxWCTRddf0l0Fpbvh21ShzQ/NKGns="


//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
