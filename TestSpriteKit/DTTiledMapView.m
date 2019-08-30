//
//  DTTiledMapView.m
//  ClassMate
//
//  Created by DLZ on 2018/8/29.
//  Copyright © 2018年 tal. All rights reserved.
//

#import "DTTiledMapView.h"

@interface DTTiledLayer : CATiledLayer
@end

@implementation DTTiledLayer

+ (CFTimeInterval)fadeDuration{
    return 0.02;
}

@end

@implementation DTTiledMapView

+ (Class)layerClass{
    return [DTTiledLayer class];
}

- (CATiledLayer *)tiledLayer{
    return (DTTiledLayer *)self.layer;
}

- (void)setTileSize:(CGSize)tileSize{
    _tileSize = tileSize;
    self.tiledLayer.tileSize = tileSize;
}

- (void)reload{
    [self.tiledLayer setNeedsDisplay];
}

- (void)drawLayer:(CATiledLayer *)layer inContext:(CGContextRef)ctx{
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    NSInteger tileScale = CGContextGetCTM(ctx).a;
    CGRect scaleRect = CGRectApplyAffineTransform(bounds, CGAffineTransformMakeScale(tileScale, tileScale));
    NSInteger col = (NSInteger) round((CGRectGetMinX(scaleRect) / self.tileSize.width));
    NSInteger row = (NSInteger) round((CGRectGetMinY(scaleRect) / self.tileSize.height));
    
    UIImage *image = [self.delegate tiledView:self imageForRow:row column:col];
    if (image != nil){
        UIGraphicsPushContext(ctx);
        [image drawInRect:bounds];
        UIGraphicsPopContext();
    }
}

@end
