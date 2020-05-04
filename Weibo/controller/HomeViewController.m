//
//  HomeViewController.m
//  Weibo
//
//  Created by Suramire on 2020/4/26.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "HomeViewController.h"
#import "NetWork.h"
#import "HomeItem.h"
#import "HomeTableViewCell.h"
@interface HomeViewController ()

@property NSMutableArray *dataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //预估高度（必须要有）
//    self.tableView.estimatedRowHeight = 100;
    // 设置cell自适应高度
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"access_token"];
//    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"uid"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *access_token = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
    NSLog(@"token=%@",access_token);
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if(access_token != nil){
        [[NetWork new] get:[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/user_timeline.json?access_token=%@&uid=%@",access_token,uid] withBlock:^(BOOL isOK, NSDictionary * _Nonnull json) {
            if(isOK){
                NSDictionary *statuses = [json objectForKey:@"statuses"];
                NSMutableArray *array = [NSMutableArray array];
                for (id key in statuses){
                    HomeItem *homeItem =[[HomeItem new] dataFromJson:key];
                    [array addObject:homeItem];
                }
                self.dataArray = array.mutableCopy;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
            }
        }];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.dataArray.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 350.f;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeCell" forIndexPath:indexPath];
    HomeItem *homeItem = [self.dataArray objectAtIndex:indexPath.row];
    cell.homeItem = homeItem;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[homeItem.user objectForKey:@"profile_image_url"]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgHead.image = image;
        });
    });
    cell.labelName.text = [homeItem.user objectForKey:@"name"];
    cell.labelTime.text = homeItem.created_at;
    cell.labelSource.text = homeItem.source;
    cell.textContent.text = homeItem.text;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
