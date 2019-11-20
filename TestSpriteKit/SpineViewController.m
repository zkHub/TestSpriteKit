//
//  SpineViewController.m
//  TestSpriteKit
//
//  Created by zk on 2019/11/20.
//  Copyright © 2019 zk. All rights reserved.
//

#import "SpineViewController.h"
#import "spine-spritekit-oc.h"


@interface SpineViewController ()

@end

@implementation SpineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *atlasPath = @"/Users/zk/Desktop/Resources/spineboy.atlas";
    spAtlas *atlas = spAtlas_createFromFile([atlasPath UTF8String], 0);
    spSkeletonJson *json = spSkeletonJson_create(atlas);
    json->scale = 1;
    NSString *jsonPath = @"/Users/zk/Desktop/Resources/spineboy-ess.json";
    spSkeletonData *skeletonData = spSkeletonJson_readSkeletonDataFile(json, [jsonPath UTF8String]);
    spSkeletonJson_dispose(json);
    
    spSkeleton* skeleton = spSkeleton_create(skeletonData);

    const char *animationName = NULL;
    if (skeletonData->animationsCount > 0) {
        animationName = skeletonData->animations[0]->name;
    }
    spAnimation* animation = spSkeletonData_findAnimation(skeletonData, animationName);

    spAnimationState *state = spAnimationState_create(spAnimationStateData_create(skeleton->data));
    spAnimationState_setAnimationByName(state, 0, animationName, 0);
    
    
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
