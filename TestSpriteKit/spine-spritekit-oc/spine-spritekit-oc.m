//
//  spine-spritekit-oc.m
//  TestSpriteKit
//
//  Created by zk on 2019/10/17.
//  Copyright © 2019 zk. All rights reserved.
//

#import "spine-spritekit-oc.h"
#import <spine/extension.h>
#import <SpriteKit/SpriteKit.h>


void _spAtlasPage_createTexture (spAtlasPage* self, const char* path) {
    UIImage *image = [UIImage imageWithContentsOfFile:@(path)];
    SKTexture *texture = [SKTexture textureWithImage:image];
    self->rendererObject = (__bridge void *)(texture);
    self->width = image.size.width;
    self->height = image.size.height;
}


void _spAtlasPage_disposeTexture (spAtlasPage* self) {
    self->rendererObject = 0;
}


char* _spUtil_readFile (const char* path, int* length) {
    return _spReadFile(path, length);
}
