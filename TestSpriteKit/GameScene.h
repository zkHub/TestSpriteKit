//
//  GameScene.h
//  TestSpriteKit
//
//  Created by zk on 2019/8/28.
//  Copyright © 2019 zk. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameScene : SKScene

@property (nonatomic, strong) SKSpriteNode *bgScene;

- (void)setCameraConstraints;

@end

NS_ASSUME_NONNULL_END
