//
//  BanInnerImage.m
//  banner
//
//  Created by Apple on 15/7/27.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "BanInnerImage.h"
#import "UrlImageButton.h"
@implementation BanInnerImage
-(instancetype)init
{
    if (self==[super init]) {
        //init code
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame]) {
        //init code
    }
    return self;
}

-(instancetype)createImageWithImgString:(BanImageStyle )imageStyle Image:(NSString *)imageString ImageX:(CGFloat)X ImageY:(CGFloat)Y Height:(CGFloat)height
{
    if (self == [super initWithFrame:CGRectMake(X, Y, 320, height)]) {
        //init code
        self.DefaultHeight = height;
        
        switch (imageStyle) {
            case BanImageDefaultStyle:
            {
                [self setBackgroundImageView:imageString];
            }
                break;
                
            case BanImageUrlImageStyle:
            {
                [self setImageWithURLImageString:imageString];
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}

-(void)setImageWithURLImageString:(NSString *)imageString
{
    UrlImageButton *imageView = [[UrlImageButton alloc]initWithFrame:CGRectMake(0, 0, 320, self.DefaultHeight)];
    [imageView setImageFromUrl:YES withUrl:imageString];
    imageView.adjustsImageWhenHighlighted = NO;
    [imageView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:imageView];

}

-(void)setBackgroundImageView:(NSString *)imageStr
{
    UrlImageButton *imageView = [[UrlImageButton alloc]initWithFrame:CGRectMake(0, 0, 320, self.DefaultHeight)];
    [imageView setBackgroundImage:[UIImage imageNamed:imageStr] forState:0];
    imageView.contentMode  = UIViewContentModeScaleToFill;
    imageView.adjustsImageWhenHighlighted = NO;
    [imageView addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:imageView];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark ImageView Button Action

-(void)click
{
    if ([self.delegate respondsToSelector:@selector(clickImageButton:)]) {
        [self.delegate clickImageButton:self.tag];
    }
}

@end
