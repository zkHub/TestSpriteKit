//
//  DTHomelandViewController.m
//  TestSpriteKit
//
//  Created by zk on 2019/9/4.
//  Copyright © 2019 zk. All rights reserved.
//

#import "DTHomelandViewController.h"
#import <SpriteKit/SpriteKit.h>


@interface DTHomelandViewController ()


/**
 SpriteKit主视图
 */
@property (nonatomic, strong) SKView *skView;

@end

@implementation DTHomelandViewController

#pragma mark - LifeCyle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.skView];
    
    
}

 - (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
 }
 
 - (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
 }

- (void)dealloc {
    
}
//MARK: - Configure UI

//MARK: - Http Request
//- (void)sendRequestWithCompeletBlock:(void (^)(void))block;
//- (void)parseJsonObjct:(DTBaseCommand_output *)finishCommand isFailed:(BOOL)isFailed;

//MARK: - Delegate

//MARK: - Block Methods

//MARK: - Button Methods

//MARK: - Custom Methods

//MARK: - Getter & Setter

- (SKView *)skView {
    if (!_skView) {
        _skView = [[SKView alloc] initWithFrame:self.view.bounds];
    }
    return _skView;
}


@end
