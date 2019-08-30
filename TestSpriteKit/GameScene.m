//
//  GameScene.m
//  TestSpriteKit
//
//  Created by zk on 2019/8/28.
//  Copyright © 2019 zk. All rights reserved.
//

#import "GameScene.h"
#import "SpriteNode.h"

@interface GameScene ()


@property (nonatomic, assign) CGPoint bPoint;


@end


@implementation GameScene



- (void)didMoveToView:(SKView *)view {
//    self.bgScene = [SKSpriteNode spriteNodeWithImageNamed:@"snow01.jpg"];
//    self.bgScene.size = CGSizeMake(1600, 1600);
//    self.bgScene.anchorPoint = CGPointZero;
//    self.bgScene.position = CGPointMake(0, 0);
//    self.bgScene.zPosition = -1;
//    [self addChild:self.bgScene];
    
    
    [self setTileMap];

    
    [self setCameraConstraints];
    
}


- (void)setTileMap {
    
    SKTileSet *tileSet = [SKTileSet tileSetNamed:@"Tile Set"];
    CGSize tileSize = CGSizeMake(108, 121);
    NSInteger row = 16;
    NSInteger columns = 10;
    SKTileGroup *ground = tileSet.tileGroups.firstObject;
    
    SKTileMapNode *tileMap = [SKTileMapNode tileMapNodeWithTileSet:tileSet columns:columns rows:row tileSize:tileSize];
//    tileMap.enableAutomapping = YES;
//    [tileMap setTileGroup:ground forColumn:columns row:row];
//    [tileMap fillWithTileGroup:ground];
    [self addChild:tileMap];
    
    for (int i = 0; i < columns; i++) {
        for (int j = 0; j < row; j++) {
            
        }
    }
    
    
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    self.bPoint = [touch locationInNode:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = touches.anyObject;
    CGPoint mPoint = [touch locationInNode:self];
    
    if (self.camera) {
        CGPoint cPoint =  self.camera.position;
        
        CGFloat x = mPoint.x - self.bPoint.x;
        CGFloat y = mPoint.y - self.bPoint.y;
        
        self.camera.position = CGPointMake(cPoint.x-x, cPoint.y-y);
    }
    
    
}


- (void)setCameraConstraints {
    
    SKCameraNode *cameraNode = [[SKCameraNode alloc] init];
//    cameraNode.position = CGPointMake(cameraNode.frame.size.width/2, cameraNode.frame.size.height/2);
    [self addChild:cameraNode];
    self.camera = cameraNode;
    
    
    CGSize scaleSize = CGSizeMake(self.size.width * self.scene.xScale, self.size.height * self.scene.yScale);
    
    
    CGRect boardContentRect = self.calculateAccumulatedFrame;
    CGFloat xInset = MIN(scaleSize.width/2, boardContentRect.size.width/2);
    CGFloat yInset = MIN(scaleSize.height/2, boardContentRect.size.height/2);

    CGRect insetContentRect = CGRectMake(boardContentRect.origin.x + xInset, boardContentRect.origin.y + yInset, boardContentRect.size.width-2*xInset, boardContentRect.size.height-2*yInset);
    
    SKRange *xRange = [SKRange rangeWithLowerLimit:CGRectGetMinX(insetContentRect) upperLimit:CGRectGetMaxX(insetContentRect)];
    SKRange *yRange = [SKRange rangeWithLowerLimit:CGRectGetMinY(insetContentRect) upperLimit:CGRectGetMaxY(insetContentRect)];
    SKConstraint *levelEdgeConstraint = [SKConstraint positionX:xRange Y:yRange];
    levelEdgeConstraint.referenceNode = self;
    self.camera.constraints = @[levelEdgeConstraint];
    
}





@end
