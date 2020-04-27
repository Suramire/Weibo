//
//  NetWork.h
//  app0
//
//  Created by Suramire on 2020/4/14.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^MyBlock)(BOOL isOK,NSDictionary *json);

@interface NetWork : NSObject

-(void) get:(NSString *) url withBlock:(MyBlock) myBlock;

-(void) get:(NSString *)url;

//-(void) post:(NSString *)url withParam:(NSDictionary *)param;

-(void) post:(NSString *)url withParamString:(NSString *)param withBlock:(MyBlock)block;

@end

NS_ASSUME_NONNULL_END
