//
//  CALayer+DTSerialAnimation.h
//  LightClass_CommonKit
//
//  Created by DLZ on 2019/7/29.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 顺序动画
 */
@interface CALayer (DTSerialAnimation)<CAAnimationDelegate>
@property (nonatomic, strong) NSMutableArray *animations;
@property (nonatomic, assign) NSInteger currentAnimationIndex;
@property (nonatomic, copy) void (^complete)(void);

/**
 添加动画

 @param animationBlock 创建动画block
 @return 当前layer
 */
- (CALayer *)dt_addSerialAnimation:(nonnull CAAnimation *(^)(void))animationBlock;

/**
 开始执行顺序动画

 @return 当前layer
 */
- (CALayer *)dt_startSerialAnimation;

/**
 顺序动画全部执行完成

 @param complete 完成回调
 @return 当前layer
 */
- (CALayer *)dt_serialAnimationComplete:(void (^)(void))complete;

@end

NS_ASSUME_NONNULL_END
