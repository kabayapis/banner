//
//  ViewController.m
//  banner
//
//  Created by Apple on 15/7/27.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Banner.h"
@interface ViewController ()<BannerViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    //NSMutableArray * imageArray = [NSMutableArray arrayWithObjects:@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg", nil];
    
    NSMutableArray *imageArray=[[NSMutableArray alloc] initWithObjects:@"http://ww1.sinaimg.cn/large/53e0c4edjw1dy3qf6n17xj.jpg",@"http://www.ynwssn.com/file/upload/201106/30/15-54-54-98-45.jpg.middle.jpg",@"http://www.ynwssn.com/file/upload/201106/30/15-54-54-98-45.jpg.middle.jpg",@"http://www.ynwssn.com/file/upload/201106/30/15-54-54-98-45.jpg.middle.jpg", nil];
    
    Banner * banner = [[Banner alloc] createBannerWithImageArray:imageArray HeightBanner:200 ViewX:0 ViewY:100];
    banner.delegate = self;
    [self.view addSubview:banner];
    
}

#pragma mark click banner view delegate

-(void)clickBannerView:(NSInteger)index
{
    NSLog(@"index: %ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
