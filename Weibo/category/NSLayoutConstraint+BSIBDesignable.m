//
//  NSLayoutConstraint+BSIBDesignable.m
//  App5
//
//  Created by Suramire on 2020/4/28.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "NSLayoutConstraint+BSIBDesignable.h"
#import <objc/runtime.h>

@implementation NSLayoutConstraint (BSIBDesignable)

//- (void)setAdapterScreen:(BOOL)adapterScreen{
//    if(adapterScreen){
//        self.constant = self.constant * KsuitParam;
//    }
//}
//
//- (BOOL)adapterScreen{
//    return YES;
//}

//定义常量 必须是C语言字符串
static char *AdapterScreenKey = "AdapterScreenKey";
 
- (BOOL)adapterScreen{
    NSNumber *number = objc_getAssociatedObject(self, AdapterScreenKey);
    return number.boolValue;
}
 
- (void)setAdapterScreen:(BOOL)adapterScreen {
    
    NSNumber *number = @(adapterScreen);
    objc_setAssociatedObject(self, AdapterScreenKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (adapterScreen){
        self.constant = AdaptW(self.constant);
    }
}


@end
