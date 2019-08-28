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
#import <SDWebImage/UIImage+Transform.h>
#import <SDWebImage/UIImageView+WebCache.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self testUIImageViewWebCache];
    
   
    
}

- (void)testUIImageViewWebCache{
    
    //https://sdwebimage.github.io/Categories/UIImageView(WebCache).html
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.frame = self.view.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    
    imageView.sd_imageProgress = [[NSProgress alloc]initWithParent:nil userInfo:nil];
    imageView.sd_imageIndicator = [SDWebImageActivityIndicator grayLargeIndicator];
    imageView.sd_imageIndicator = [SDWebImageProgressIndicator defaultIndicator];
    imageView.sd_imageTransition = [SDWebImageTransition curlUpTransition];
    
    NSString *url1 = @"http://img4.cache.netease.com/photo/0001/2010-04-17/64EFS71V05RQ0001.jpg";
    NSString *url2 = @"https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif";
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"placeHolder.jpeg"] options:SDWebImageRefreshCached context:nil progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        NSLog(@"receivedSize%ld,expectedSize%ld",(long)receivedSize,(long)expectedSize);
        
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        NSLog(@"image%@,error%@,cacheType%ld",image,error,(long)cacheType);
        
    }];
    

    
}

- (void)testUIImageTransform{
    
    //https://sdwebimage.github.io/Categories/UIImage(Transform).html
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor greenColor];
    imageView.frame = CGRectMake(0, 0, 200, 200);
    imageView.center = self.view.center;
    [self.view addSubview:imageView];
    /*图像几何
    -sd_resizedImageWithSize:scaleMode:
    -sd_croppedImageWithRect:
    -sd_roundedCornerImageWithRadius:corners:borderWidth:borderColor:
    -sd_rotatedImageWithAngle:fitSize:
    -sd_flippedImageWithHorizontal:vertical:
    
    UIImage *image = [UIImage imageNamed:@"dog.jpg"];
    
    //返回从此图像调整大小的新图像。您可以指定比图像大小更大或更小的尺寸。将使用缩放模式更改图像内容。
    //image = [image sd_resizedImageWithSize:CGSizeMake(100, 300) scaleMode:SDImageScaleModeAspectFill];
    
    //返回从此图像裁剪的新图像。
    image = [image sd_croppedImageWithRect:CGRectMake(0, 0, 300, 300)];
    
    //使用给定的角半径和角来舍入新图像。
    image = [image sd_roundedCornerImageWithRadius:200 corners:UIRectCornerAllCorners borderWidth:5 borderColor:[UIColor yellowColor]];
    
    //返回一个新的旋转图像（相对于中心）。逆时针旋转弧度.⟲
    //是：新图像的大小扩展到适合所有内容。否：图像的大小不会改变，内容可能会被剪裁。
    image = [image sd_rotatedImageWithAngle:0.5 fitSize:YES];
    
    //返回新的水平（垂直）翻转图像。
    image = [image sd_flippedImageWithHorizontal:NO vertical:YES];
    
    imageView.image = image;
     
    */
    
    /*
     图像混合
    -sd_tintedImageWithColor:
    -sd_colorAtPoint:
    -sd_colorsWithRect:
     */
    //UIImage *image = [UIImage imageNamed:@"dog.jpg"];
    
    //返回具有给定颜色的着色图像。这实际上使用当前图像和色调颜色的alpha混合。
    //image = [image sd_tintedImageWithColor:[UIColor colorWithWhite:0 alpha:0.8]];
    //imageView.image = image;
    
    
    //返回指定位置的像素颜色
//    UIColor *color = [image sd_colorAtPoint:CGPointMake(300, 300)];
    
    //返回指定矩形的像素颜色数组
    //NSArray *colors = [image sd_colorsWithRect:CGRectMake(100, 200, 300, 200)];
    //imageView.backgroundColor = colors.firstObject;
    
    

    
    /*
     图像效果
     -sd_blurredImageWithRadius:
     -sd_filteredImageWithFilter:
     */
    UIImage *image = [UIImage imageNamed:@"dog.jpg"];
    
    //返回应用模糊效果的新图像。
    //模糊半径为0表示没有模糊效果。
//    image = [image sd_blurredImageWithRadius:40];
    
    //返回应用CIFilter的新图像。使用CIFilter实现滤镜效果
    //https://blog.csdn.net/u011369424/article/details/52862560
    //1、先想办法弄到一个图像（CIImage*）
    CIImage* oldImg = [[CIImage alloc] initWithImage:image];
    //2、创建一个CIFilter*对象
    CIFilter* filter = [CIFilter filterWithName:@"CICircularWrap"];
    //如果用下面这个方法初始化，3、4、5部都可以省略
    //CIFilter* filter = [CIFilter filterWithName:@"CICircularWrap" keysAndValues:@"inputImage",oldImg, nil];
    //3、设置默认参数
    [filter setDefaults];
    //4、设置要处理的图像
    [filter setValue:oldImg forKey:@"inputImage"];
    
    image = [image sd_filteredImageWithFilter:filter];
    
    imageView.image = image;
    
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
