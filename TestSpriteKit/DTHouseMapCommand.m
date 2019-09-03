//
//  DTHouseMapCommand.m
//  ClassMate
//
//  Created by DLZ on 2018/9/1.
//  Copyright © 2018年 tal. All rights reserved.
//

#import "DTHouseMapCommand.h"

@implementation DTHousemapUserInfoModel

@end

@implementation DTHouseMapPhotoBgModel 

@end

@implementation DTHouseMapSkinModel

@end

@implementation DTHouseMapItemModel

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"mid" : @"id"};
}

@end

@implementation DTHouseMapGiftModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"userinfo"  : [DTHousemapUserInfoModel class]};
}

@end

@implementation DTHouseMapModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"list"  : [DTHouseMapItemModel class],
             @"skin"  : [DTHouseMapSkinModel class],
             @"bgframe"  : [DTHouseMapPhotoBgModel class],
             };
}

@end

@implementation DTHouseMapCommand_input

@end

@implementation DTHouseMapCommand_output

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"resModel" : @"res"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"resModel"  : [DTHouseMapModel class],
             };
}
@end

@implementation DTHouseMapCommand


@end
