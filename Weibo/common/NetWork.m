//
//  NetWork.m
//  app0
//
//  Created by Suramire on 2020/4/14.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork

-(void) get:(NSString *) url withBlock:(MyBlock) myBlock{
// 原生方式请求
    NSURL *myUrl = [[NSURL alloc] initWithString:url];
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:myUrl];
    NSURLSession *mySession = [NSURLSession sharedSession];
    NSURLSessionDataTask *myTask = [mySession dataTaskWithURL:myUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //JSON格式化
//        NSError *jsonError;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//        NSArray *dataArray = [[[obj valueForKey:@"attribute"] valueForKey:@"data"] valueForKey:@"list"];
//        NSMutableArray *tempArray = @[].mutableCopy;
        
        if(myBlock){
            myBlock(YES,obj);
        }
        
    }];
    [myTask resume];


};

-(void) get:(NSString *)url{
    NSURL *myUrl = [[NSURL alloc] initWithString:url];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:myUrl];
//    request.HTTPBody=
    NSURLSession *mySession = [NSURLSession sharedSession];
    NSURLSessionDataTask *myTask = [mySession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
    }];
}

//-(void) post:(NSString *)url withParam:(NSDictionary *)param{
//    NSURL *myUrl = [[NSURL alloc] initWithString:url];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:myUrl];
//    [request setHTTPMethod:@"POST"];
//    NSError *error;
//    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted  error:&error]];
//    NSURLSession *mySession = [NSURLSession sharedSession];
//    NSURLSessionDataTask *task = [mySession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"%@");
//    }];
//    [task resume];
//}

-(void) post:(NSString *)url withParamString:(NSString *)param withBlock:(MyBlock)block{
    NSURL *myUrl = [[NSURL alloc] initWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:myUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSession *mySession = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [mySession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        NSLog(@"%@",[dic objectForKey:@"access_token"]);
        if(block){
            block(YES,dic);
        }
        
    }];
    [task resume];
}

@end
