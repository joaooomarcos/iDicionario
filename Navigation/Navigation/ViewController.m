//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "ViewController.h"
#import "DataCenter.h"

@implementation ViewController{
    DataCenter *data;
    int i;
    UILabel *label;
    UIImage *image;
    UIImageView *imageView;
    CGLayerRef *layer;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    
    i = 0;
    data = [[DataCenter alloc]init];
    
    [data initData];
    
    self.title = [data returnLetter:i];
    
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    self.navigationItem.rightBarButtonItem=next;
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem=back;
}

-(void)next:(id)sender {
    if (i == 25) i = 0;
    else i++;
    
    self.title = [data returnLetter:i];
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, -300, 0);
        label.transform = CGAffineTransformTranslate(label.transform, -300, 0);
    } completion:^(BOOL finished) {
        label.text = [data returnWord:i];
        label.frame = CGRectMake(300, 450, 300, 80);
        
        [imageView removeFromSuperview];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 100, 280, 280)];
        image = [data returnImage:i];
        imageView.image = image;
        [self.view addSubview: imageView];
        
        [UIView animateWithDuration:0.5 animations:^{
            imageView.transform = CGAffineTransformTranslate(imageView.transform, -280, 0);
            label.transform = CGAffineTransformTranslate(label.transform, -290, 0);
        }];
    }];
//    
//    [UIView animateWithDuration:2.0 animations:^{
//        //imageView.transform = CGAffineTransformMakeScale(2, 2);
//        
//    }];
}

-(void)back:(id)sender{
    if (i == 0) i = 25;
    else i--;
    
    self.title = [data returnLetter:i];
    
    [UIView animateWithDuration:0.5 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, 300, 0);
        label.transform = CGAffineTransformTranslate(label.transform, 300, 0);
    } completion:^(BOOL finished) {
        label.text = [data returnWord:i];
        label.frame = CGRectMake(-300, 450, 300, 80);
        
        [imageView removeFromSuperview];
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(-300, 100, 280, 280)];//90, 200, 140, 140)];
        image = [data returnImage:i];
        imageView.image = image;
        [self.view addSubview: imageView];
        
        [UIView animateWithDuration:0.5 animations:^{
            imageView.transform = CGAffineTransformTranslate(imageView.transform, 320, 0);
            label.transform = CGAffineTransformTranslate(label.transform, 320, 0);
        }];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 100, 280, 280)];
    image = [data returnImage:i];
    imageView.image = image;
    [self.view addSubview: imageView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(300, 450, 300, 80)];
    
    label.text = [data returnWord:i];
    label.font = [UIFont fontWithName:@"Zapfino" size:25];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    [UIView animateWithDuration:2.0 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, -280, 0);
        label.transform = CGAffineTransformTranslate(label.transform, -290, 0);
    }];
}

@end
