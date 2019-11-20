//
//  TextureViewController.m
//  TestSpriteKit
//
//  Created by zk on 2019/10/10.
//  Copyright © 2019 zk. All rights reserved.
//

#import "TextureViewController.h"

#import <SpriteKit/SpriteKit.h>
#import <SDWebImage.h>

@interface TextureViewController ()

@property (nonatomic, strong) SKScene *scene;

@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic) NSInteger count;

@end

@implementation TextureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    SKView *skView = [[SKView alloc] initWithFrame:self.view.bounds];
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    [self.view addSubview:skView];

    self.scene = [SKScene sceneWithSize:skView.frame.size];
    self.scene.backgroundColor = [SKColor cyanColor];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:self.scene];


    
    

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
        [self addAnimationNode];

//    [self.queue cancelAllOperations];
//    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"start");
//        [NSThread sleepForTimeInterval:3];
//        NSLog(@"end");
//    }];
//    [self.queue addOperation:operation];
    
    
}


- (NSOperationQueue *)queue {
    if (!_queue) {
        _queue = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return _queue;
}



- (void)addAnimationNode {
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
////    NSString *basePath = @"/Users/zk/Documents/four_tree";
//    NSString *basePath = [[NSBundle mainBundle] bundlePath];
//    for (int i = 0; i < 50; i++) {
//        NSString *name = [NSString stringWithFormat:@"four_tree_%02d", i];
//        NSString *path = [basePath stringByAppendingPathComponent:name];
//        UIImage *image = [UIImage imageWithContentsOfFile:path];
//        if (image) {
//            [dict setObject:image forKey:name];
//        }
//    }
//    SKTextureAtlas *atlas = [SKTextureAtlas atlasWithDictionary:dict];
    
//    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"SpritesAtlas"];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"four_tree"];
    
//    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"a"];
    
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//    path = [path stringByAppendingPathComponent:@"four_tree.atlasc"];
//    SKTextureAtlas *atlas = [SKTextureAtlas atlasWithDictionary:@{@"four_tree":path}];

    NSInteger count = atlas.textureNames.count;
    
    NSMutableArray *textures = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        NSString *name = [NSString stringWithFormat:@"four_tree_%02d", i];
        SKTexture *t = [atlas textureNamed:name];
        //            SKTexture *t = [SKTexture textureWithImageNamed:name];
        if (t) {
            [textures addObject:t];
        }
    }
    
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:textures.firstObject];
//    SKSpriteNode *node = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"four_tree_x_00"]];
    node.position = CGPointMake(300, 500);
    [self.scene addChild:node];
    
    SKAction *animationAction = [SKAction animateWithTextures:textures timePerFrame:1];
    [node runAction:[SKAction repeatActionForever:animationAction]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
