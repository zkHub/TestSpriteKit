//
//  SpriteNode.h
//  TestSpriteKit
//
//  Created by zk on 2019/8/29.
//  Copyright © 2019 zk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SpriteNodeDelegate <NSObject>

- (void)beginTouchSprite:(SKNode*)snode insidePoint:(CGPoint)point;
- (void)moveTouchSprite:(SKNode*)snode insidePoint:(CGPoint)point;
- (void)endTouchSprite:(SKNode*)snode insidePoint:(CGPoint)point;

@end



@interface SpriteNode : SKSpriteNode
@property (nonatomic, strong) SKNode *superNode;

@property (nonatomic, weak) id<SpriteNodeDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
