//
//  NSObject+AssociatedObject.h
//  LightClass_CommonKit
//
//  Created by DLZ on 2019/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AssociatedObject)

/**
 添加strong类型属性
 */
- (void)dt_strongAssociateValue:(id)value withKey:(const void *)key;

/**
 添加copy类型属性
 */
- (void)dt_copyAssociateValue:(id)value withKey:(const void *)key;

/**
 添加weak类型属性
 */
- (void)dt_weakAssociateValue:(__autoreleasing id)value withKey:(const void *)key;

/**
 获取属性值
 */
- (id)dt_associatedValueForKey:(const void *)key;

@end

NS_ASSUME_NONNULL_END
