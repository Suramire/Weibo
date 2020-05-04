//
//  HomeTableViewCell.m
//  Weibo
//
//  Created by Suramire on 2020/4/26.
//  Copyright © 2020 Suramire. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HomeItem.h"
#import "ImgCollectionViewCell.h"
@interface HomeTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionFlowLayout.estimatedItemSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, 200);
    self.collectionFlowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

#pragma DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.homeItem.pic_num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImgCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"wbImgCell" forIndexPath:indexPath];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.homeItem.imgArray objectAtIndex:indexPath.row]]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imgView.image = image;
        });
    });
    
    // Configure the cell
    
    return cell;
}

#pragma ItemSize

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat witdh =  self.collectionView.frame.size.width;
    return CGSizeMake((witdh-24)/3 , (witdh-24)/3);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8.0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8.0;
}

- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;

}


@end
