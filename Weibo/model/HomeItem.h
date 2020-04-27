//
//  HomeItem.h
//  Weibo
//
//  Created by Suramire on 2020/4/26.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeItem : NSObject

@property NSDictionary *user;

@property NSString *text;//文本

@property NSString *created_at;//创建时间

@property NSString *source;//来源

-(HomeItem *) dataFromJson:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
