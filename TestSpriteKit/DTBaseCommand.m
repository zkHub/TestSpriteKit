//
//  DTBaseCommand.m
//  StudyAndProgress
//
//  Created by VickyCao on 12/2/15.
//  Copyright © 2015 VickyCao. All rights reserved.
//

#import "DTBaseCommand.h"

@implementation DTBaseCommand_input

- (NSDictionary *)toDictionary {
    return [self modelToJSONObject];
}

@end


@implementation DTBaseCommand_output

@end

@implementation DTBaseCommand

- (instancetype)init {
    self = [super init];
    if (self) {


        self.startDate = [NSDate date];
        NSString *className = [self className];
        NSString *inputClassName = [NSString stringWithFormat:@"%@_input", className];
        NSString *outputClassName = [NSString stringWithFormat:@"%@_output", className];
        Class inputClass = NSClassFromString(inputClassName);
        if (inputClass) {
            self.input = [inputClass new];
        } else {
            self.input = [DTBaseCommand_input new];
        }
        Class outputClass = NSClassFromString(outputClassName);
        if (outputClass) {
            self.output = [outputClass new];
        } else {
            self.output = [DTBaseCommand_output new];
        }
    }
    return self;
}

- (NSDictionary *)form {
    if (!_form) {
        return [self.input toDictionary];
    }
    return _form;
}



@end
