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



- (instancetype)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        
    }
    return self;
}


- (void)didMoveToView:(SKView *)view {

//    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Sprites"];
//    [atlas preloadWithCompletionHandler:^{
    
        CFTimeInterval bTime = CACurrentMediaTime();
        [self setTileMap];
        CFTimeInterval eTime = CACurrentMediaTime();
        NSLog(@"tileTime--%f",eTime - bTime);
        
//    }];
    
    [self setCameraConstraints];
    
}


- (void)setTileMap {
    
    CGSize tileSize = CGSizeMake(108, 121);
    int rows = 16;
    int columns = 10;
    
    NSMutableArray *definitionArr = [NSMutableArray array];
    for (int i = rows-1; i >= 0; i--) {
        for (int j = 0; j < columns; j++) {
            int index = (i*10+j)%160;
            SKTileDefinition *tileDefinition = [SKTileDefinition tileDefinitionWithTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"house_map_%d",index]] size:tileSize];
            [definitionArr addObject:tileDefinition];
        }
    }
    SKTileGroupRule *tileGroupRule = [SKTileGroupRule tileGroupRuleWithAdjacency:(SKTileAdjacencyAll) tileDefinitions:definitionArr];
    SKTileGroup *landTileGroup = [SKTileGroup tileGroupWithRules:@[tileGroupRule]];
    SKTileSet *tileSet = [SKTileSet tileSetWithTileGroups:@[landTileGroup] tileSetType:SKTileSetTypeGrid];
    SKTileMapNode *tileMap = [SKTileMapNode tileMapNodeWithTileSet:tileSet columns:columns rows:rows tileSize:tileSize];
//    [tileMap fillWithTileGroup:landTileGroup];
    
    for (int i = 0; i < definitionArr.count; i++) {
        
        SKTileDefinition *definition = definitionArr[i];
        
        int column = i % 10;
        int row = i / 10;
        
        [tileMap setTileGroup:landTileGroup andTileDefinition:definition forColumn:column row:row];

    }
    
    tileMap.position = CGPointMake(0, 0);
    tileMap.anchorPoint = CGPointMake(0, 0);
    tileMap.name = @"tileMap";
//    tileMap.enableAutomapping = YES;
    [self addChild:tileMap];
    
    SKTileMapNode *tileMap1 = [tileMap copy];
    tileMap1.position = CGPointMake(108 * 10, 0);
    tileMap1.anchorPoint = CGPointMake(0, 0);
    tileMap1.name = @"tileMap1";
    [self addChild:tileMap1];
    
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
    self.camera.zPosition = 3;
    SKTileMapNode *tileMap = (SKTileMapNode*)[self childNodeWithName:@"tileMap"];
    self.camera.position = CGPointMake(tileMap.mapSize.width/2, tileMap.mapSize.height/2);
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    
    
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





- (void)update:(NSTimeInterval)currentTime {
    
    
}



@end
