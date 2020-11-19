//
//  ViewController.m
//  SymboImage
//
//  Created by YLCHUN on 2020/11/18.
//

#import "ViewController.h"
#import "UIImage+SymboImage.h"

// live_crab
// cooked_crab

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image1 = [UIImage symboImageNamed:@"ximi" inBundle:[NSBundle mainBundle]];
    UIImage *image2 = [UIImage symboImageNamed:@"spcart" inBundle:[NSBundle mainBundle]];

    UIImageView *imageView1 = [[UIImageView alloc] initWithImage:image1];
    imageView1.center = CGPointMake(150, 150);
    imageView1.layer.borderColor = [UIColor redColor].CGColor;
    imageView1.layer.borderWidth = 1;
    [self.view addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithImage:image2];
    imageView2.center = CGPointMake(150, 350);
    imageView2.layer.borderColor = [UIColor redColor].CGColor;
    imageView2.layer.borderWidth = 1;
    [self.view addSubview:imageView2];
    // Do any additional setup after loading the view.
}


@end
