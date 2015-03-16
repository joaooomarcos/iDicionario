//
//  LetraAViewController.m
//  Navigation
//
//  Created by Vinicius Miana on 2/23/14.
//  Copyright (c) 2014 Vinicius Miana. All rights reserved.
//

#import "LetraAViewController.h"
#import "LetraBViewController.h"
#import "DataCenter.h"

@implementation LetraAViewController{
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
    
    
    // Label
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, 450, 300, 80)];
    label.text = [data returnWord:i];
    label.font = [UIFont fontWithName:@"Zapfino" size:25];
    label.textColor = [UIColor blueColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    //Imagem
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 130, 280, 280)];
    image = [data returnImage:i];
    imageView.image = image;
    [self.view addSubview: imageView];
    
    
//    UIButton *botao = [UIButton buttonWithType:UIButtonTypeSystem];
//    [botao setTitle:@"???" forState:UIControlStateNormal];
//    [botao sizeToFit];
//    botao.center = self.view.center;
//    
//    [self.view addSubview:botao];
}

-(void)next:(id)sender {
    if (i == 25) i = 0;
    else i++;
    
    self.title = [data returnLetter:i];
    label.text = [data returnWord:i];
    image = [data returnImage:i];
    imageView.image = image;
//    LetraBViewController *proximo = [[LetraBViewController alloc]initWithNibName:nil bundle:NULL];
//    [self.navigationController pushViewController:proximo animated:YES];
}

-(void)back:(id)sender{
    if (i == 0) i = 25;
    else i--;
    
    self.title = [data returnLetter:i];
    label.text = [data returnWord:i];
    image = [data returnImage:i];
    imageView.image = image;
}

@end
