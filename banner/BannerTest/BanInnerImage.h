//
//  BanInnerImage.h
//  banner
//
//  Created by Apple on 15/7/27.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BanImageStyle) {
    BanImageDefaultStyle,
    BanImageUrlImageStyle,
};

@protocol BannerImageDelegate <NSObject>
-(void)clickImageButton:(NSInteger)index;
@end

@interface BanInnerImage : UIView
@property (nonatomic ,assign) CGFloat DefaultHeight;
@property (nonatomic ,weak) id<BannerImageDelegate>delegate;
-(instancetype)createImageWithImgString:(BanImageStyle )imageStyle Image:(NSString *)imageString ImageX:(CGFloat)X ImageY:(CGFloat)Y Height:(CGFloat)height;
@end
