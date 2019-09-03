//
//  DTBaseCommand.h
//  StudyAndProgress
//
//  Created by VickyCao on 12/2/15.
//  Copyright © 2015 VickyCao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YYKit.h"

@interface DTBaseCommand_input : NSObject

@property (nonatomic, strong) NSString *_t;


@end

@interface DTBaseCommand_output : NSObject

@property (strong,nonatomic) NSNumber               *errcode;  //状态码
@property (strong,nonatomic) NSString               *errmsg;   //错误消息
@property (strong,nonatomic) NSString               *version;  //版本号
@property (strong,nonatomic) NSNumber               *state;    //主键

@property (strong,nonatomic) NSDictionary           *res;

@end

@interface DTBaseCommand : NSObject

typedef void (^Complete) (DTBaseCommand_output *finishCommand, BOOL isFailed);

@property (strong,nonatomic) NSString               *baseUrl;
@property (strong,nonatomic) NSString               *path;
@property (strong,nonatomic) NSDate                 *startDate;
@property (strong,nonatomic) DTBaseCommand_input    *input;
@property (strong,nonatomic) DTBaseCommand_output   *output;
@property (strong,nonatomic) NSDictionary           *form;



@end
