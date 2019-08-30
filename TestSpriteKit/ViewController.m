//
//  ViewController.m
//  TestSpriteKit
//
//  Created by zk on 2019/8/27.
//  Copyright © 2019 zk. All rights reserved.
//

#import "ViewController.h"
#import <SpriteKit/SpriteKit.h>
#import "GameScene.h"
#import "SpriteNode.h"

@interface ViewController ()<SpriteNodeDelegate>

@property (nonatomic, strong) GameScene *scene;
@property (nonatomic, strong) SpriteNode *boxNode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    SKView *skView = (SKView *) self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    self.scene = [GameScene sceneWithSize:skView.frame.size];
    self.scene.backgroundColor = [SKColor cyanColor];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:self.scene];
    
    
    self.boxNode = [[SpriteNode alloc] initWithImageNamed:@"house_map_building_box"];
    self.boxNode.hidden = YES;
    self.boxNode.size = CGSizeMake(50, 50);
    self.boxNode.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.scene addChild:self.boxNode];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    SpriteNode *node = [[SpriteNode alloc] initWithImageNamed:@"house_map_ground"];
    
    //        node.anchorPoint = CGPointMake(0, 0);
    node.userInteractionEnabled = YES;
    node.superNode = self.scene.camera;
    [self.scene.camera addChild:node];
    node.size = CGSizeMake(50, 50);
    node.position = CGPointMake(-self.view.frame.size.width/2 + 100, 0);
    node.delegate = self;
    
    
//    for (int i = 0; i < 160; i++) {
//
//        NSString *imgStr = [NSString stringWithFormat:@"HouseMap.bundle/house_map_%d",i];
//        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:imgStr normalMapped:YES];
//
//        CGFloat x = 60 + i % 10 * sprite.size.width;
//        CGFloat y = i / 10 * sprite.size.height;
//        sprite.position = CGPointMake(x, y);
//        [self.scene.bgScene addChild:sprite];
//    }
    
}


- (void)beginTouchSprite:(SKNode *)node insidePoint:(CGPoint)point {
    
   
    
    self.boxNode.hidden = NO;
    
    
}

- (void)moveTouchSprite:(SKNode *)node insidePoint:(CGPoint)point {
    
}

- (void)endTouchSprite:(SKNode *)node insidePoint:(CGPoint)point {
    
    
    if (self.boxNode) {
        self.boxNode.hidden = YES;
        
        CGPoint curPoint = [node convertPoint:point toNode:self.scene];
        
        if (CGRectContainsPoint(self.boxNode.frame, curPoint)) {
            SpriteNode *newNode = [[SpriteNode alloc] initWithImageNamed:@"house_map_ground"];
            newNode.position = self.boxNode.position;
            newNode.size = CGSizeMake(50, 50);
            [self.scene addChild:newNode];
            
            [self.boxNode removeFromParent];
            self.boxNode = nil;
            
        }
    }
    
}

@end
