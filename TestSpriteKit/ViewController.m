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
#import "DTHouseMapCommand.h"

#import <SDWebImage.h>

static const CGFloat KDEFAULT_MAP_IMAGE_HEIGHT = 3888.0;



@interface ViewController ()<SpriteNodeDelegate>

@property (nonatomic, strong) GameScene *scene;
@property (nonatomic, strong) SpriteNode *boxNode;

@property (nonatomic) CFTimeInterval time;

/**
 记录当前活动之后的缩放比例
 */
@property (nonatomic) CGFloat lastScale;


@property(nonatomic, strong)NSMutableDictionary *mapDic;

@property(nonatomic, strong)NSArray<DTHouseMapPhotoBgModel *> *pframeList;


@end

@implementation ViewController


- (NSMutableDictionary *)mapDic {
    if (!_mapDic) {
        _mapDic = [NSMutableDictionary dictionary];
    }
    return _mapDic;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.time = CACurrentMediaTime();
    
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
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [skView addGestureRecognizer:pinch];
    
    self.lastScale = 1.0;
    
    [self loadData];
    
}

- (void)loadData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BulidJson" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    DTHouseMapCommand_output *output = [DTHouseMapCommand_output modelWithJSON:jsonStr];
    DTHouseMapModel *model = output.resModel;
    self.pframeList = output.resModel.bgframe;
    NSArray *modelList = [[self class] sortedArray:model.list];
    [self analyseMapList:modelList];
    
    NSArray *sprites = self.mapDic[@"1"];

    int i = 0;
    for(DTHouseMapItemModel *model in sprites) {
        model.showonpic = model.onpic;
        CGPoint position = [self getMapPinPositionWithSort:model.sort];
        model.contentPosition = position;
        i++;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:model.onpic] completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            SKSpriteNode *spriteNode = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:image]];
            spriteNode.position = model.contentPosition;
            [self.scene addChild:spriteNode];

        }];
        if (i > 30) {
            break;
        }
        
    }

    
    
}


//根据位置点获取相应的位置
-(CGPoint)getMapPinPositionWithSort:(NSInteger)sort{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HouseMap" ofType:@"plist"];
    NSArray *points = [NSArray arrayWithContentsOfFile:path];
    NSDictionary *dic = points[(sort-1)%points.count];
    NSInteger marginY = (sort-1)/points.count*KDEFAULT_MAP_IMAGE_HEIGHT/KMAP_IMAGE_SCARE;
    CGPoint position = CGPointMake([dic[@"x"] floatValue]/KMAP_IMAGE_SCARE, [dic[@"y"] floatValue]/KMAP_IMAGE_SCARE+marginY);
    return position;
}


-(void)analyseMapList:(NSArray *)list{
    NSMutableArray *buildings = [NSMutableArray new];
    NSMutableArray *sprites = [NSMutableArray new];
    NSMutableArray *grounds = [NSMutableArray new];
    NSMutableArray *packageBuildings = [NSMutableArray new];
    NSMutableArray *packageSprites = [NSMutableArray new];
    NSMutableArray *packageGrounds = [NSMutableArray new];
    
    for(DTHouseMapItemModel *subModel in list){
        if(subModel.tid == 1){
            if(subModel.state){
                [buildings addObject:subModel];
            }else{
                [packageBuildings addObject:subModel];
            }
        }else if(subModel.tid == 2){
            if(subModel.state){
                [sprites addObject:subModel];
            }else{
                [packageSprites addObject:subModel];
            }
        }else if(subModel.tid == 3){
            if(subModel.state){
                [grounds addObject:subModel];
            }else{
                [packageGrounds addObject:subModel];
            }
        }
    }
    
    [self.mapDic removeAllObjects];
    [self.mapDic setObject:buildings forKey:@"1"];
    [self.mapDic setObject:sprites forKey:@"2"];
    [self.mapDic setObject:grounds forKey:@"3"];

//    [self.packageDic removeAllObjects];
//    [self.packageDic setObject:packageBuildings forKey:@"1"];
//    [self.packageDic setObject:packageSprites forKey:@"2"];
//    [self.packageDic setObject:packageGrounds forKey:@"3"];
//    // setValue: value 可为空，key:为字符串；setObject: value不为空，key为object
//    [self.packageDic setValue:DTSafeObj(self.skin) forKey:@"4"];
}

+(NSArray *)sortedArray:(NSArray *)list{
    NSArray *sortedList = [list sortedArrayUsingComparator:^NSComparisonResult(DTHouseMapItemModel *model1, DTHouseMapItemModel *model2) {
        if(model1.ctime > model2.ctime){
            return NSOrderedAscending;
        }else if(model1.ctime == model2.ctime){
            if(model1.mid.integerValue > model2.mid.integerValue){
                return NSOrderedAscending;
            }
        }
        return NSOrderedDescending;
    }];
    return sortedList;
}


/**
 缩放手势

 @param pinch -
 */
- (void)pinchAction:(UIPinchGestureRecognizer*)pinch {
    
    switch (pinch.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
        {
            CGFloat newScale = self.lastScale / pinch.scale;
            
            newScale = MIN(newScale, 2);
            newScale = MAX(newScale, 0.5);
            
            self.scene.camera.xScale = newScale;
            self.scene.camera.yScale = newScale;
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            self.lastScale = self.scene.camera.xScale;
        }
            break;
            
        default:
            break;
    }
    
   
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    SKShapeNode *shapeNode = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.view.frame.size.width -40, 50) cornerRadius:20];
    shapeNode.fillColor = [[SKColor blackColor] colorWithAlphaComponent:0.2];
    shapeNode.position = CGPointMake(0, -self.view.frame.size.height/2 + 70);
    shapeNode.name = @"shapeNode";
    [self.scene.camera addChild:shapeNode];
    
    SpriteNode *node = [[SpriteNode alloc] initWithImageNamed:@"house_map_ground"];
    node.userInteractionEnabled = YES;
    node.superNode = self.scene.camera;
    node.size = CGSizeMake(50, 50);
    node.position = CGPointMake(0, -self.view.frame.size.height/2 + 70);
    node.delegate = self;
    [self.scene.camera addChild:node];
    
    NSLog(@"time--%f",self.time - CACurrentMediaTime());
    
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
            
            SKAction *action1 = [SKAction rotateToAngle:0.2 duration:0.05];
            SKAction *action2 = [SKAction rotateToAngle:-0.2 duration:0.05];
            [newNode runAction:[SKAction repeatActionForever:[SKAction sequence:@[action1, action2]]]];
            
            [self.boxNode removeFromParent];
            self.boxNode = nil;
            
        }
    }
    
}

@end
