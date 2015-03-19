//
//  LetraAViewController.m
//  Navigation
//
//  Created by João Marcos on 2/23/14.
//  Copyright (c) 2014 João Marcos. All rights reserved.
//

#import "ViewController.h"
#import "DataCenter.h"
#import <AVFoundation/AVFoundation.h>

@implementation ViewController{
    DataCenter *data;
    int i;
    CGLayerRef *layer;
    UITextField *word;
    UIImage *image;
    UIImageView *imageView;
    UINavigationController *nvc;
    UIBarButtonItem *edit;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    // Zera o indice
    i = 0;
    
    
    
    
    // Dados
    data = [[DataCenter alloc]init];
    [data initData];
    
    // Seta o titulo da NavCont com o primeiro elemento
    self.navigationItem.title = [data returnLetter:i];
    
    // Cria botões para a NavCont
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back:)];
    
    // Adiciona os botões na NavCont
    self.navigationItem.rightBarButtonItem=next;
    self.navigationItem.leftBarButtonItem=back;
    
    // Cria, posiciona, adiciona uma imagem
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 100, 280, 280)];
    image = [data returnImage:i];
    imageView.image = image;
    [self.view addSubview: imageView];
    
    // Cria, edita, posiciona, dimensiona, uma label
    word = [[UITextField alloc]initWithFrame:CGRectMake(300, 400, 300, 80)];
    word.text = [data returnWord:i];
    word.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40]; //Helvetica-Bold
    word.textColor = [UIColor blackColor];
    word.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:word];
    
    // Toolbar
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height-80, self.view.bounds.size.width, 30)];
    
    edit = [[UIBarButtonItem  alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(buttonEdit:)];
    UIBarButtonItem *reset = [[UIBarButtonItem  alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:nil];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *toolbarItens = [[NSArray alloc]initWithObjects:space, edit, space, reset, space, nil];
    
    [toolbar setItems:toolbarItens];
    
    
    //UIBarButtonItem *espaco = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //NSArray *items = [[NSArray alloc] initWithObjects:resetImage, espaco, editar, nil];
    //[toolBar setItems:items];
    
    [self.view addSubview:toolbar];
    
    imageView.userInteractionEnabled = YES;
    
    // Animações
    [UIView animateWithDuration:2.0 animations:^{
        imageView.transform = CGAffineTransformMakeTranslation(-280, 0);
        word.transform = CGAffineTransformMakeTranslation(-290, 0);
        
    }];
    
    word.enabled = NO;
    
    // Cor de fundo da view
    self.view.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:228.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Fala
    AVSpeechSynthesizer *synt = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *ut = [AVSpeechUtterance speechUtteranceWithString:@"Welcome"];
    [ut setPitchMultiplier:1.15f];
    ut.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [ut setRate:0.03f];
    [synt speakUtterance:ut];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

// Botão próximo
-(void)next:(id)sender {
    // Incrementa o indice
    if (i == 25) i = 0;
    else i++;
    
    // Seta o titulo da NavCont
    self.navigationItem.title = [data returnLetter:i];
    
    // Animações
    [UIView animateWithDuration:0.2 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, -300, 0);
        word.transform = CGAffineTransformTranslate(word.transform, -300, 0);
    } completion:^(BOOL finished) {
        word.text = [data returnWord:i];
        word.frame = CGRectMake(300, 400, 300, 80);
        
        [imageView removeFromSuperview];
        
        imageView.frame = CGRectMake(300, 100, 280, 280);
        image = [data returnImage:i];
        imageView.image = image;

        [self.view addSubview: imageView];
        
        [UIView animateWithDuration:0.2 animations:^{
            imageView.transform = CGAffineTransformTranslate(imageView.transform, -282, 0);
            word.transform = CGAffineTransformTranslate(word.transform, -290, 0);
        }];
    }];
}

// Botão anterior
-(void)back:(id)sender{
    // Decrementa o indice
    if (i == 0) i = 25;
    else i--;
    
    // Seta o titulo da NavCont
    self.navigationItem.title = [data returnLetter:i];
    
    // Animações
    [UIView animateWithDuration:0.2 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, 300, 0);
        word.transform = CGAffineTransformTranslate(word.transform, 300, 0);
    } completion:^(BOOL finished) {
        word.text = [data returnWord:i];
        word.frame = CGRectMake(-300, 400, 300, 80);
        
        [imageView removeFromSuperview];
        imageView.frame = CGRectMake(-300, 100, 280, 280);
        image = [data returnImage:i];
        imageView.image = image;
        [self.view addSubview: imageView];
        
        [UIView animateWithDuration:0.2 animations:^{
            imageView.transform = CGAffineTransformTranslate(imageView.transform, 320, 0);
            word.transform = CGAffineTransformTranslate(word.transform, 310, 0);
        }];
    }];
}

// Eventos de Toque
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // Limpa as animaçoes anteriores, e posiciona novamente
    imageView.transform = CGAffineTransformIdentity;
    imageView.frame = CGRectMake(20, 100, 280, 280);
    
    // Animações
    [UIView animateWithDuration:2.0 animations:^{
        imageView.transform = CGAffineTransformMakeScale(2, 2);
    }];
    
    // Fala
    AVSpeechSynthesizer *synt = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *ut = [AVSpeechUtterance speechUtteranceWithString:[data returnWord:i]];
    [ut setPitchMultiplier:1.15f];
    ut.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [ut setRate:0.03f];
    [synt speakUtterance:ut];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    // Para todas animaçoes
    [self.view.layer removeAllAnimations];
    
    // Animações
    [UIView animateWithDuration:1.0 animations:^{
        imageView.transform = CGAffineTransformIdentity;
    }];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    imageView.transform = CGAffineTransformIdentity;

    if([touch.view isEqual:imageView]){
        touch.view.center = [touch locationInView:self.view];
    }
}

-(void) buttonEdit:(id)sender{
    if (word.enabled == YES) {
        word.enabled = NO;
        edit.title = @"Edit";
        word.backgroundColor = [UIColor clearColor];
    }
    else {
    word.enabled = YES;
    edit.title = @"Done";
    word.backgroundColor = [UIColor whiteColor];
    }
}

@end
