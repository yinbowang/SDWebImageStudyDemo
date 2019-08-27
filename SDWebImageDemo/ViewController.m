//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by wyb on 2019/8/19.
//  Copyright © 2019 世纪佳缘. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/SDWebImage.h>
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self test3];
   
    
   
    
}

- (void)test3{
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.nipic.com/20131007/13639685_123501617185_2.jpg"] placeholderImage:[UIImage imageNamed:@"placeHolder.jpeg"]];
    
    
    
}

- (void)test2{
    FLAnimatedImageView *animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:self.view.frame];
    animatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animatedImageView];
    [animatedImageView sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif"]];
}

- (void)test1{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"timg.gif" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];

    UIImage *image = [UIImage sd_imageWithGIFData:data];
    imageView.image = image;
}



@end
