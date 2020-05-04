//
//  Oauth2ViewController.m
//  Weibo
//
//  Created by Suramire on 2020/4/25.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "Oauth2ViewController.h"
#import <WebKit/WebKit.h>
#import "NetWork.h"

@interface Oauth2ViewController () <WKNavigationDelegate>

@property(nonatomic,strong,readwrite)WKWebView *webview;

@end

@implementation Oauth2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webview = [[WKWebView alloc] initWithFrame:self.view.frame];
    _webview.navigationDelegate = self;
    [self.view addSubview:_webview];
    
}

- (void)viewWillAppear:(BOOL)animated{
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=2213562669&redirect_uri=https://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:request];
}
///webview代理 拦截请求
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
//    NSLog(@"URL:%@",navigationAction.request.URL);
    
    NSString *urlString = navigationAction.request.URL.absoluteString;
    NSRange range = [urlString rangeOfString:@"code="];
    if(range.length !=0){
        //range.location+length 表示从code=之后开始截取
        NSString *codeString = [urlString substringFromIndex:range.location+range.length];
        
//        NSDictionary *paramenters = @{@"client_id":@"2213562669", @"client_secret":@"e0cba6de49a09b55b534d5a4a311c17f",
//                              @"grant_type":@"authorization_code", @"code":codeString, @"redirect_uri":@"https://www.baidu.com",
//        };
        NSString *paramString = [NSString stringWithFormat:@"client_id=2213562669&client_secret=e0cba6de49a09b55b534d5a4a311c17f&code=%@&grant_type=authorization_code&redirect_uri=https://www.baidu.com",codeString];
        
        [[NetWork new] post:@"https://api.weibo.com/oauth2/access_token" withParamString:paramString withBlock:^(BOOL isOK, NSDictionary * _Nonnull json) {
            if(isOK){
                NSLog(@"resp %@",json);
                NSString *access_token = [json objectForKey:@"access_token"];
                NSString *uid = [json objectForKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] setObject:access_token forKey:@"access_token"];
                [[NSUserDefaults standardUserDefaults] setObject:uid forKey:@"uid"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [[NetWork new] get:[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",access_token,uid] withBlock:^(BOOL isOK, NSDictionary * _Nonnull json) {
                    if(isOK){
//                        NSLog(@"resp2 %@",json);
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                        });
                    }
                }];
            }
        }];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    
    
}

@end
