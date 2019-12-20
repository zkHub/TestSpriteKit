//
//  CALayer+DTSerialAnimation.m
//  LightClass_CommonKit
//
//  Created by DLZ on 2019/7/29.
//

#import "CALayer+DTSerialAnimation.h"
#import "NSObject+AssociatedObject.h"

@implementation CALayer (DTSerialAnimation)
@dynamic animations, currentAnimationIndex, complete;

//- (void)dealloc {
//    [self.animations removeAllObjects];
//}

- (CALayer *)dt_addSerialAnimation:(nonnull CAAnimation *(^)(void))animationBlock {
    if (animationBlock) {
        if (!self.animations) {
            self.animations = [NSMutableArray new];
        }
        CAAnimation *animation = animationBlock();
        animation.delegate = self;
        [self.animations addObject:animation];
    }
    return self;
}

- (CALayer *)dt_startSerialAnimation {
    [self removeAllAnimations];
    self.currentAnimationIndex = 0;
    
    CAAnimation *animation = [self.animations objectAtIndex:self.currentAnimationIndex];
    if (animation) {
        [self addAnimation:animation forKey:nil];
    }
    
    return self;
}

- (CALayer *)dt_serialAnimationComplete:(void (^)(void))complete {
    self.complete = complete;
    return self;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.currentAnimationIndex ++;
    if (self.currentAnimationIndex >= self.animations.count) {
        [self.animations removeAllObjects];
        [self removeAllAnimations];
        
        if (self.complete) {
            self.complete();
        }
        
        return;
    }
    
    CAAnimation *animation = [self.animations objectAtIndex:self.currentAnimationIndex];
    if (animation) {
        [self addAnimation:animation forKey:nil];
    }
}

#pragma mark - getters and setters

- (NSMutableArray *)animations {
    return [self dt_associatedValueForKey:_cmd];
}

- (void)setAnimations:(NSMutableArray *)animations {
    [self dt_strongAssociateValue:animations withKey:@selector(animations)];
}

- (NSInteger)currentAnimationIndex {
    return [[self dt_associatedValueForKey:_cmd] integerValue];
}

- (void)setCurrentAnimationIndex:(NSInteger)currentAnimationIndex {
    [self dt_strongAssociateValue:@(currentAnimationIndex) withKey:@selector(currentAnimationIndex)];
}

- (void(^)(void))complete {
    return [self dt_associatedValueForKey:_cmd];
}

- (void)setComplete:(void (^)(void))complete {
    [self dt_copyAssociateValue:complete withKey:@selector(complete)];
}

@end
