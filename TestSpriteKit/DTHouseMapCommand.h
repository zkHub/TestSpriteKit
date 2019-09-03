//
//  DTHouseMapCommand.h
//  ClassMate
//
//  Created by DLZ on 2018/9/1.
//  Copyright © 2018年 tal. All rights reserved.
//

#import "DTBaseCommand.h"

/*
 [id] => 建造编号
 [propid] => 道具ID
 [tid]    => 类型 1:建筑 2:精灵 3:土地
 [pointx] => x轴
 [pointy] => y轴
 [state]  => 状态，0背包，1建造
 [sort]   => 排序
 [icon]   => 图片地址
 [name] => 名称
 [ctime] =>创建时间
 */

#define KMAP_DEFAULT_SCARE  ((YYScreenScale() == 3.f) ? 1.0f : 1.8f)
#define KMAP_IMAGE_SCARE    (YYScreenScale()*KMAP_DEFAULT_SCARE)

typedef NS_ENUM(NSUInteger, HouseMapPinType) {
    HouseMapPinNormal = 0,
    HouseMapPinRemove,//移除按钮
    HouseMapPinAnimated//动画(不可点击)
};


@interface DTHousemapUserInfoModel : NSObject
@property(nonatomic, copy)NSString *onpic;
@property(nonatomic, copy)NSString *uname;
@end

@interface DTHouseMapPhotoBgModel : NSObject
@property(nonatomic, copy)NSString *centerx;
@property(nonatomic, copy)NSString *centery;
@property(nonatomic, copy)NSString *w;
@property(nonatomic, copy)NSString *h;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *onpic;
@property(nonatomic, copy)NSString *rotate;
@property(nonatomic, copy)NSString *bgcolor;

/**
 内框左上角点
 */
@property(nonatomic, copy)NSString *opx;
@property(nonatomic, copy)NSString *opy;

@end

@interface DTHouseMapSkinModel : NSObject
@property(nonatomic, copy)NSString *name;//名称
@property(nonatomic, copy)NSString *sid;
@property(nonatomic, copy)NSString *thumbpic;//icon图片
@property(nonatomic, copy)NSString *groundpic;//地桩图
@property(nonatomic, copy)NSString *bgcolor;//背景地图颜色
@property(nonatomic, copy)NSString *aios;
@property(nonatomic, copy)NSString *aandroid;
@end

@interface DTHouseMapItemModel : NSObject
@property(nonatomic, copy)NSString *mid;
@property(nonatomic, copy)NSString *propid;
@property(nonatomic, copy)NSString *onpic;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *prosperity;

@property(nonatomic, assign)NSInteger tid;
@property(nonatomic, assign)CGFloat pointx;
@property(nonatomic, assign)CGFloat pointy;
@property(nonatomic, assign)NSInteger sort;
@property(nonatomic, assign)NSInteger quality;/**< 品质是不是稀有1普通2稀有3限定 3.1版本更新 */
@property(nonatomic, assign)BOOL state;
@property(nonatomic, assign)long ctime;
@property(nonatomic, assign)CGPoint offect;
@property(nonatomic, assign)CGPoint contentPosition;
@property(nonatomic, strong)id obj;
@property(nonatomic, assign)NSInteger scare;//显示比例(最小显示1倍)
@property(nonatomic, assign)HouseMapPinType type;//类型

@property(nonatomic, assign)BOOL isCanOpen;//是否可以点击出现更换
@property(nonatomic, copy)NSString *sid;//皮肤id
@property(nonatomic, assign)BOOL isSkin;//是否是皮肤（自己添加）
@property(nonatomic, assign)BOOL isDefaultSkin;//是否是默认皮肤（自己添加）
@property(nonatomic, assign)BOOL isDown;//是否已经下载（自己添加）
@property(nonatomic, copy)NSString *downLoadUrl;//下载地址（自己添加）
@property(nonatomic, copy)NSString *locationUrl;//本地地址（自己添加）
@property(nonatomic, copy)NSString *showonpic;//修改后的地桩地址（自己添加）

@end

/**
 res[town]数组字段说明
 [achieve] => 成就数
 [isfirst]  => 是否为第一次进入家园 0: 否 1: 是
 [is_zan] =>是否已点赞
 [zan] =>被点赞数
 [prosperity] =>家园繁荣度
 [userinfo] =>用户名称以及头像
 [nlikes] =>
 */
@interface DTHouseMapGiftModel : NSObject
@property(nonatomic, copy)NSString *achieve;
@property(nonatomic, assign)BOOL isfirst;
@property(nonatomic, copy)NSString *islike;
@property(nonatomic, copy)NSString *likes;
@property(nonatomic, copy)NSString *qrcode;
@property(nonatomic, copy)NSString *nlikes;
@property(nonatomic, copy)NSString *prosperity;
@property(nonatomic, strong)DTHousemapUserInfoModel *userinfo;

/**
 town[send] => 第一次进入赠送的建筑
 [tid] => 类型 1:建筑 2:精灵 3:土地
 [name] => 名称
 [icon]  => 图片地址(未穿装备的图)
 [onpic]  => 图片地址（穿装备后的图）
 [bg_frame]  => 图框
[selected_skin_id]  => 选中的皮肤ID
 */
@property(nonatomic, strong)DTHouseMapItemModel *send;
@end

@interface DTHouseMapModel : NSObject
@property(nonatomic, strong)NSArray<DTHouseMapItemModel *> *list;
@property(nonatomic, strong)NSArray<DTHouseMapSkinModel *> *skin;
@property(nonatomic, strong)DTHouseMapGiftModel *town;
@property(nonatomic, strong)NSArray <DTHouseMapPhotoBgModel *>*bgframe;
@property(nonatomic, copy)NSString *ssid;

@end

@interface DTHouseMapCommand_input : DTBaseCommand_input
@property(nonatomic, assign)NSInteger psize;
@property(nonatomic, assign)NSInteger skip;
@property(nonatomic, assign)NSInteger utime;
@property(nonatomic, copy)NSString *uid;
@end

@interface DTHouseMapCommand_output : DTBaseCommand_output
@property (nonatomic,strong)DTHouseMapModel *resModel;
@end

@interface DTHouseMapCommand : DTBaseCommand

@end
