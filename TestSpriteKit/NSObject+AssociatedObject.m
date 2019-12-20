//
//  NSObject+AssociatedObject.m
//  LightClass_CommonKit
//
//  Created by DLZ on 2019/7/2.
//

#import "NSObject+AssociatedObject.h"
#import <objc/runtime.h>
@interface DTWeakAssociatedObject : NSObject
@property (nonatomic, weak) id value;
@end

@implementation DTWeakAssociatedObject

@end

@implementation NSObject (AssociatedObject)

- (void)dt_strongAssociateValue:(id)value withKey:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dt_copyAssociateValue:(id)value withKey:(const void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)dt_weakAssociateValue:(__autoreleasing id)value withKey:(const void *)key {
    DTWeakAssociatedObject *obj = objc_getAssociatedObject(self, key);
    if (!obj) {
        obj = [DTWeakAssociatedObject new];
        [self dt_strongAssociateValue:obj withKey:key];
    }
    obj.value = value;
}

- (id)dt_associatedValueForKey:(const void *)key {
    id value = objc_getAssociatedObject(self, key);
    if (value && [value isKindOfClass:[DTWeakAssociatedObject class]]) {
        return [(DTWeakAssociatedObject *)value value];
    }
    return value;
}



@end
