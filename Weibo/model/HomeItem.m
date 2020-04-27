//
//  HomeItem.m
//  Weibo
//
//  Created by Suramire on 2020/4/26.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "HomeItem.h"

@implementation HomeItem

-(HomeItem *) dataFromJson:(NSDictionary *)dic{
    NSDictionary *tempDic = [dic objectForKey:@"user"];
    NSString *name = [tempDic objectForKey:@"name"];
    NSString *profile_image_url = [tempDic objectForKey:@"profile_image_url"];
    NSDictionary *newUserDic = @{@"name":name,@"profile_image_url":profile_image_url};
    self.user = newUserDic;
    self.text = [dic objectForKey:@"text"];
    self.created_at = [dic objectForKey:@"created_at"];
    self.source = [dic objectForKey:@"source"];
    return self;
}

@end
