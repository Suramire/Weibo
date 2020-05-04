//
//  NSLayoutConstraint+BSIBDesignable.h
//  App5
//
//  Created by Suramire on 2020/4/28.
//  Copyright © 2020 Suramire. All rights reserved.
//


#import <UIKit/UIKit.h>

///* iOS设备 */
//#define kDevice_Is_iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone6PlusBigMode ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen]currentMode].size) : NO)
////适配参数
//#define KsuitParam (kDevice_Is_iPhone6Plus ?1.12:(kDevice_Is_iPhone6?1.0:(iPhone6PlusBigMode ?1.01:0.85))) //以6为基准图
// 基准屏幕宽度
#define kRefereWidth 375.0
// 以屏幕宽度为固定比例关系，来计算对应的值。假设：基准屏幕宽度375，floatV=10；当前屏幕宽度为750时，那么返回的值为20
#define AdaptW(floatValue) (floatValue*[[UIScreen mainScreen] bounds].size.width/kRefereWidth)


NS_ASSUME_NONNULL_BEGIN

@interface NSLayoutConstraint (BSIBDesignable)

@property(nonatomic, assign) IBInspectable BOOL adapterScreen;

@end

NS_ASSUME_NONNULL_END
