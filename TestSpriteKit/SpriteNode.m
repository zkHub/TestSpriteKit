//
//  SpriteNode.m
//  TestSpriteKit
//
//  Created by zk on 2019/8/29.
//  Copyright © 2019 zk. All rights reserved.
//

#import "SpriteNode.h"


@interface SpriteNode ()


@property (nonatomic) CGPoint oldPosition;

@end


@implementation SpriteNode


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    SKAction *action = [SKAction scaleToSize:CGSizeMake(108, 120) duration:0.1];
    SKAction *action1 = [SKAction rotateToAngle:0.2 duration:0.05];
    SKAction *action2 = [SKAction rotateToAngle:-0.2 duration:0.05];
//    [self runAction:[SKAction repeatActionForever:[SKAction sequence:@[action,action1,action2,action2]]]];
    [self runAction:action];
    self.oldPosition = self.position;
    if (self.delegate && [self.delegate respondsToSelector:@selector(beginTouchSprite:insidePoint:)]) {
        [self.delegate beginTouchSprite:self insidePoint:point];
    }
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    CGPoint sPoint = [self convertPoint:point toNode:self.superNode];
    self.position = sPoint;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(moveTouchSprite:insidePoint:)]) {
        [self.delegate moveTouchSprite:self insidePoint:point];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    [self touchesEndActionWithPoint:point];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    [self touchesEndActionWithPoint:point];
}

- (void)touchesEndActionWithPoint:(CGPoint)point {
    
    SKAction *action = [SKAction scaleToSize:CGSizeMake(50, 50) duration:0.1];
    [self runAction:action];
    if (self.delegate && [self.delegate respondsToSelector:@selector(endTouchSprite:insidePoint:)]) {
        [self.delegate endTouchSprite:self insidePoint:point];
        self.position = self.oldPosition;
    }
    
    
    
//    SKAction *action1 = [SKAction rotateToAngle:0 duration:0.1];
//    [self runAction:[SKAction group:@[action,action1]] completion:^{
//
//        [self removeAllActions];
//        self.position = self.oldPosition;
//    }];
    
    
}


@end
