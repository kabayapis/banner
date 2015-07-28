//
//  Banner.h
//  banner
//
//  Created by Apple on 15/7/27.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BanInnerImage.h"

@protocol BannerViewDelegate <NSObject>
-(void)clickBannerView:(NSInteger)index;

@end

@interface Banner : UIView<BannerImageDelegate>
@property (nonatomic ,weak) id<BannerViewDelegate>delegate;
@property (nonatomic ,strong) NSMutableArray * imgArr ;
@property (nonatomic ,assign) CGFloat height_banner ;
-(instancetype)createBannerWithImageArray:(NSMutableArray *)imgArr HeightBanner:(CGFloat)heightBanner ViewX:(float)X ViewY:(float)Y;
@end
