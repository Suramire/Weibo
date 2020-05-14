//
//  MineViewController.m
//  Weibo
//
//  Created by Suramire on 2020/4/25.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "MineViewController.h"
#import "Oauth2ViewController.h"
#import "NetWork.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
@interface MineViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowCount;
@property (weak, nonatomic) IBOutlet UILabel *labelFollowerCount;
@property (weak, nonatomic) IBOutlet UILabel *labelWeiboCount;

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpData];
    

}

- (void)setUpPlayer{
    NSString *mediaUrl = @"http://f.video.weibocdn.com/3qJeazjdlx07D5plRt7a010412012GVu0E010.mp4?label=mp4_ld&template=640x360.25.0&trans_finger=bdef57f06ae52835a2c783ca389e8517&Expires=1588858118&ssig=k9xCtc2Jpm&KID=unistore,video";
    NSURL *url = [NSURL URLWithString:mediaUrl];
    AVPlayer *player = [[AVPlayer alloc] initWithURL:url];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:player];
    layer.frame = CGRectMake(0, 400, 200, 100);
    [self.view.layer addSublayer:layer];
    [player play];
}

- (void)setUpData{
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if(access_token == nil){
        //未进行授权登录
        Oauth2ViewController *controller = [[Oauth2ViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        //获取用户信息
        [[NetWork new] get:[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@",access_token,uid] withBlock:^(BOOL isOK, NSDictionary * _Nonnull json) {
            if(isOK){
                NSLog(@"resp2 %@",json);
                NSString *avatar_hd = [json objectForKey:@"avatar_hd"];
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatar_hd]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.labelName.text = [json objectForKey:@"name"];
                    self.imgHead.image = image;
                    self.labelFollowCount.text = [NSString stringWithFormat:@"关注数:%@",[json objectForKey:@"friends_count"]];
                    self.labelFollowerCount.text = [NSString stringWithFormat:@"粉丝数:%@",[json objectForKey:@"followers_count"]];
                    self.labelWeiboCount.text = [NSString stringWithFormat:@"微博数:%@",[json objectForKey:@"statuses_count"]];
                });
            }
        }];
        //获取用户微博
//        [[NetWork new] get:[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?access_token=%@&trim_user=1",access_token] withBlock:^(BOOL isOK, NSDictionary * _Nonnull json) {
//            if(isOK){
//                NSArray *array = [json objectForKey:@"statuses"];
//                NSLog(@"resp3 %@",[array objectAtIndex:0]);
//
//            }
//        }];
        
    }
}

-(void)removeAll{
    NSArray *subviews = [self.view subviews];
    if (subviews.count > 0) {
        for (UIView *sub in subviews) {
            [sub removeFromSuperview];
        }
    }
    
    [self viewWillDisappear:YES];
    [self viewDidDisappear:YES];
    [self viewDidLoad];
    [self viewWillAppear:YES];
    [self viewDidAppear:YES];
    [self viewWillLayoutSubviews];
}

- (IBAction)quitLogin:(id)sender {
    [self removeAll];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self setUpData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
