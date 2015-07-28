//
//  Banner.m
//  banner
//
//  Created by Apple on 15/7/27.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "Banner.h"

#define Width_Banner  320//广告的宽度

@interface Banner ()<UIScrollViewDelegate>
{
    int page_Number;
    CGFloat height_Banner;
    UIScrollView * Banner_ScrollView;
    UIPageControl  * pageController;
    int derection;
    NSTimer * _timer;
    NSMutableArray * contentViews;
    NSMutableArray * viewsMutableArray;
}
@end

@implementation Banner

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

-(instancetype)createBannerWithImageArray:(NSMutableArray *)imgArr HeightBanner:(CGFloat)heightBanner ViewX:(float)X ViewY:(float)Y
{
    if (self==[super initWithFrame:CGRectMake(X, Y, Width_Banner, heightBanner)]) {
        //initialize code
        page_Number = 0;//set up is 1
        height_Banner = heightBanner;
        viewsMutableArray = [@[] mutableCopy];
        [self createViewsWithImageArray:imgArr];
    }
    return self;
}

-(void)createViewsWithImageArray:(NSMutableArray *)imgArray
{
    _imgArr = imgArray;
    
    int image_Number = (int)[imgArray count];
    
    Banner_ScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Width_Banner, height_Banner)];
    Banner_ScrollView.showsHorizontalScrollIndicator = NO;
    Banner_ScrollView.showsVerticalScrollIndicator = NO;
    Banner_ScrollView.directionalLockEnabled = YES;
    Banner_ScrollView.pagingEnabled = YES;
    Banner_ScrollView.delegate = self;
    Banner_ScrollView.backgroundColor = [UIColor clearColor];
    Banner_ScrollView.contentSize = CGSizeMake(Width_Banner*3, self.frame.size.height);
    Banner_ScrollView.contentOffset  = CGPointMake(0, 0);
    [self addSubview:Banner_ScrollView];
    
    pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height_Banner-50, self.frame.size.width ,50)];
    pageController.currentPage = 0;
    pageController.numberOfPages = image_Number;
    
    pageController.backgroundColor = [UIColor clearColor];
    pageController.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageController.pageIndicatorTintColor = [UIColor lightGrayColor];
    [self addSubview:pageController];
    
    //waiting for writing runloop.........
    
    for (int i =0; i<image_Number; i++) {
        NSString * string = [imgArray objectAtIndex:i];
        BanInnerImage * banner_image;
        if ([[string substringToIndex:4] isEqualToString:@"http"]) {
        
            banner_image = [[BanInnerImage alloc] createImageWithImgString:BanImageUrlImageStyle Image:string ImageX:Width_Banner*i ImageY:0 Height:height_Banner];
            banner_image.tag = i;
            banner_image.delegate  = self;
            
        }
        else
        {
            banner_image = [[BanInnerImage alloc] createImageWithImgString:BanImageDefaultStyle Image:string ImageX:Width_Banner*i ImageY:0 Height:height_Banner];
            banner_image.tag = i;
            banner_image.delegate  = self;
           
        }
        
        [viewsMutableArray addObject:banner_image];
    }
    
    [self makeTheContentViews];
    
    [self setupTimer];
       
}

#pragma mark setupTimer

-(void)setupTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changeImageView) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

#pragma mark changeImageView Action

-(void)changeImageView
{
    CGPoint offSet = CGPointMake(Banner_ScrollView.contentOffset.x+CGRectGetWidth(Banner_ScrollView.frame), 0);
    [Banner_ScrollView setContentOffset:offSet  animated:YES];
    
}

#pragma mark NextPageIndex

-(int)getValueNextPageIndexWithPageIndex:(NSInteger)currentIndex
{
    int index;
    if (currentIndex==-1) {
        index = (int)_imgArr.count-1;
        
    }
    else if (currentIndex==_imgArr.count)
    {
        index = 0;
    }
    else
    {
        index = (int)currentIndex;
    }
    return index;
}

#pragma mark makeTheContentViews

-(void)makeTheContentViews
{
    [Banner_ScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self setScrollViewContentDataSource];
    
    NSInteger count  = 0 ;
    for (UIView * subViews in contentViews) {
        
        CGRect rect = subViews.frame;
        rect.origin = CGPointMake(CGRectGetWidth(Banner_ScrollView.frame) * (count++), 0);
        
        subViews.frame = rect;
        [Banner_ScrollView addSubview:subViews];
    }
    
    [Banner_ScrollView setContentOffset:CGPointMake(Banner_ScrollView.frame.size.width, 0)];
}

#pragma mark set scrollView content data source

-(void)setScrollViewContentDataSource
{
    int previPageIndex = [self getValueNextPageIndexWithPageIndex:page_Number-1];
    int nextPageIndex = [self getValueNextPageIndexWithPageIndex:page_Number+1];
    if (contentViews==nil) {
        contentViews = [@[] mutableCopy];
    }
    [contentViews removeAllObjects];
    
    [contentViews addObject:[self getViewWithPageIndex:previPageIndex]];
    [contentViews addObject:[self getViewWithPageIndex:page_Number]];
    [contentViews addObject:[self getViewWithPageIndex:nextPageIndex]];
    
}

-(UIView *)getViewWithPageIndex:(int)pageIndex
{
    return viewsMutableArray[pageIndex];
}

#pragma mark scrollView delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageController.currentPage = [self getValueNextPageIndexWithPageIndex:page_Number];

    if (scrollView.contentOffset.x>=2*CGRectGetWidth(scrollView.frame)) {
        page_Number = [self getValueNextPageIndexWithPageIndex:page_Number+1];
        [self makeTheContentViews];
        
    }
    if (scrollView.contentOffset.x<=0)
    {
        page_Number = [self getValueNextPageIndexWithPageIndex:page_Number-1];
        [self makeTheContentViews];
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //waiting for writing......
    int number = scrollView.contentOffset.x/scrollView.frame.size.width;
    NSLog(@"number  two :%d",number);

    [scrollView setContentOffset:CGPointMake(CGRectGetWidth(Banner_ScrollView.frame), 0)];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark BannerInner delegate

-(void)clickImageButton:(NSInteger)index
{
    if ([self.delegate respondsToSelector:@selector(clickBannerView:)]) {
        [self.delegate clickBannerView:index];
    }
}

@end
