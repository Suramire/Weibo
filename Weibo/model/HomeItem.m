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
    self.pic_num = [[dic objectForKey:@"pic_num"] integerValue];
    NSArray *imgs = [dic objectForKey:@"pic_urls"];
    NSMutableArray *realImages = [NSMutableArray array];
    for (int i=0; i<imgs.count; i++) {
        NSDictionary *img = [imgs objectAtIndex:i];
        [realImages addObject:[NSString stringWithFormat:@"%@",[img objectForKey:@"thumbnail_pic"] ]];
    }
    self.imgArray = realImages;
    return self;
}

@end
