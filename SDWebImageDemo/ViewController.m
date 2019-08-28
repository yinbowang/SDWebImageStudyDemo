//
//  ViewController.m
//  SDWebImageDemo
//
//  Created by wyb on 2019/8/19.
//  Copyright © 2019 世纪佳缘. All rights reserved.
//

#import "ViewController.h"
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIImage+Transform.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testUIImageTransform];
    
   
    
}

- (void)testUIImageTransform{
    
}

- (void)testUIImageViewWebCache{

    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic33.nipic.com/20131007/13639685_123501617185_2.jpg"] placeholderImage:[UIImage imageNamed:@"placeHolder.jpeg"]];
    
    
    
}

- (void)testSDWebImageFLPlugin{
    FLAnimatedImageView *animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:self.view.frame];
    animatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animatedImageView];
    [animatedImageView sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif"]];
}

- (void)testUIImageGIF{
    
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
