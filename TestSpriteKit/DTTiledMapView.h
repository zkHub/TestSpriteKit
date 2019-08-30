//
//  DTTiledMapView.h
//  ClassMate
//
//  Created by DLZ on 2018/8/29.
//  Copyright © 2018年 tal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DTTiledMapView;

@protocol TiledMapImageDelegate <NSObject>
@required
- (UIImage *)tiledView:(DTTiledMapView *)tiledView imageForRow:(NSInteger)row column:(NSInteger)column;
@end

@interface DTTiledMapView : UIView
@property (nonatomic, weak) id<TiledMapImageDelegate> delegate;
@property (nonatomic, assign) CGSize tileSize;

/**
 重载地图贴图
 */
- (void)reload;
@end
