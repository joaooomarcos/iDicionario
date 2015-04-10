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
#import "Letter.h"

@implementation ViewController{
    DataCenter *data;
    Letter *let;
    NSArray *results;
    int i;
    CGLayerRef *layer;
    UITextField *word;
    UITextField *date;
    UIImage *image;
    UIImageView *imageView;
    UINavigationController *nvc;
    UIBarButtonItem *edit;
    UIBarButtonItem *cameraImage;
    UIBarButtonItem *addImage;
    BOOL editing;
    UIDatePicker *datePicker;
    NSDateFormatter *formatter;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    // Zera o indice
    i = 0;
    
    editing = NO;
    
    // Dados
    data = [DataCenter instance];
    results = [data returnAll];
    
    data.search = 0;
    
    let = [results objectAtIndex:i];
    // Seta o titulo da NavCont com o primeiro elemento
    self.navigationItem.title = let.letter;
    
    //Date Picker
    formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    // Cria botões para a NavCont
    UIBarButtonItem *next = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(next:)];
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(back:)];
    
    // Adiciona os botões na NavCont
    self.navigationItem.rightBarButtonItem=next;
    self.navigationItem.leftBarButtonItem=back;
    
    // Cria, posiciona, adiciona uma imagem
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(300, 90, 280, 280)];
    imageView.layer.cornerRadius = 140;
    imageView.layer.masksToBounds = YES;
    image = [UIImage imageNamed:let.image];
    imageView.image = image;
    [self.view addSubview: imageView];
    imageView.userInteractionEnabled = YES;
    
    
    // Cria, edita, posiciona, dimensiona, uma label
    word = [[UITextField alloc]initWithFrame:CGRectMake(300, 370, 300, 80)];
    word.text = let.word;
    word.font = [UIFont fontWithName:@"MarkerFelt-Wide" size:40]; //Helvetica-Bold
    word.textColor = [UIColor blackColor];
    word.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:word];
    word.enabled = NO;
    
    // Cria, edita, posiciona, dimensiona, uma label
    date = [[UITextField alloc]initWithFrame:CGRectMake(300, 420, 300, 80)];
    date.text = let.date;
    date.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:20];
    date.textColor = [UIColor grayColor];
    date.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:date];
    date.enabled = NO;
    
    
    // DatePicker
    datePicker = [[UIDatePicker alloc]initWithFrame: CGRectMake(self.view.bounds.origin.x, 10, 0, 0)];
    //datePicker.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:228.0/255.0 blue:255.0/255.0 alpha:1.0];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.hidden = YES;
    [self.view addSubview:datePicker];
    
    // Toolbar
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.size.height-80, self.view.bounds.size.width, 30)];
    
    edit = [[UIBarButtonItem  alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(buttonEdit:)];
    cameraImage = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraImage:)];
    addImage = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addImage:)];
    UIBarButtonItem *reset = [[UIBarButtonItem  alloc] initWithTitle:@"Reset" style:UIBarButtonItemStylePlain target:self action:@selector(buttonReset:)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *toolbarItens = [[NSArray alloc]initWithObjects:space, edit, space, reset, space, cameraImage, addImage, nil];
    
    [toolbar setItems:toolbarItens];
    [self.view addSubview:toolbar];
    
    cameraImage.enabled = NO;
    addImage.enabled = NO;
    
    
    
    // Animações
    [UIView animateWithDuration:2.0 animations:^{
        imageView.transform = CGAffineTransformMakeTranslation(-280, 0);
        word.transform = CGAffineTransformMakeTranslation(-290, 0);
        date.transform = CGAffineTransformMakeTranslation(-290, 0);
    }];
    
    // Gestos
    UIPanGestureRecognizer *moveImage = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
    UITapGestureRecognizer *doubleTapImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapImage:)];
    doubleTapImage.numberOfTapsRequired = 2;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration = 0.8;
    
    UIPinchGestureRecognizer *pinchImage = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchImage:)];
    
    // Adicionando os gestos na imagem
    [imageView addGestureRecognizer:moveImage];
    [imageView addGestureRecognizer:doubleTapImage];
    [imageView addGestureRecognizer:longPress];
    [imageView addGestureRecognizer:pinchImage];

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
    let = [results objectAtIndex:data.search];
    self.navigationItem.title = let.letter;
    word.text = let.word;
    date.text = let.date;
    image = [UIImage imageNamed:let.image];
    imageView.image = image;
}

// Botão próximo
-(void)next:(id)sender {
    // Incrementa o indice
    if (i == 25) i = 0;
    else{
        i++;
        data.search++;
    }
    
    let = [results objectAtIndex:i];
    
    // Seta o titulo da NavCont
    self.navigationItem.title = let.letter;
    
    // Animações
    [UIView animateWithDuration:0.2 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, -300, 0);
        word.transform = CGAffineTransformTranslate(word.transform, -300, 0);
        date.transform = CGAffineTransformTranslate(date.transform, -300, 0);
    } completion:^(BOOL finished) {
        word.text = let.word;
        word.frame = CGRectMake(300, 370, 300, 80);
        
        date.text = let.date;
        date.frame = CGRectMake(300, 420, 300, 80);
        
        [imageView removeFromSuperview];
        
        imageView.frame = CGRectMake(300, 90, 280, 280);
        image = [UIImage imageNamed:let.image];
        imageView.image = image;

        [self.view addSubview: imageView];
        
        [UIView animateWithDuration:0.2 animations:^{
            imageView.transform = CGAffineTransformTranslate(imageView.transform, -282, 0);
            word.transform = CGAffineTransformTranslate(word.transform, -290, 0);
            date.transform = CGAffineTransformTranslate(date.transform, -290, 0);
        }];
    }];
}

// Botão anterior
-(void)back:(id)sender{
    // Decrementa o indice
    if (i == 0) i = 25;
    else{
        i--;
        data.search--;
    }
    let = [results objectAtIndex:i];
    
    // Seta o titulo da NavCont
    self.navigationItem.title = let.letter;
    
    // Animações
    [UIView animateWithDuration:0.2 animations:^{
        imageView.transform = CGAffineTransformTranslate(imageView.transform, 300, 0);
        word.transform = CGAffineTransformTranslate(word.transform, 300, 0);
        date.transform = CGAffineTransformTranslate(date.transform, 300, 0);
    } completion:^(BOOL finished) {
        word.text = let.word;
        word.frame = CGRectMake(-300, 370, 300, 80);
        
        date.text = let.date;
        date.frame = CGRectMake(-300, 420, 300, 80);
        
        [imageView removeFromSuperview];
        imageView.frame = CGRectMake(-300, 90, 280, 280);
        image = [UIImage imageNamed:let.image];
        imageView.image = image;
        [self.view addSubview: imageView];
        
        [UIView animateWithDuration:0.2 animations:^{
            imageView.transform = CGAffineTransformTranslate(imageView.transform, 320, 0);
            word.transform = CGAffineTransformTranslate(word.transform, 310, 0);
            date.transform = CGAffineTransformTranslate(date.transform, 310, 0);
        }];
    }];
}

-(void)moveImage:(UIPanGestureRecognizer *)pan{
    if (editing == YES) {
        CGPoint position = [pan translationInView:self.view];
        pan.view.center = CGPointMake(pan.view.center.x + position.x, pan.view.center.y + position.y);
        [pan setTranslation:CGPointMake(0, 0) inView:[self view]];
    }
}

-(void)doubleTapImage:(UITapGestureRecognizer*)pan{
    // Fala
    AVSpeechSynthesizer *synt = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *ut = [AVSpeechUtterance speechUtteranceWithString:word.text];
    [ut setPitchMultiplier:1.15f];
    ut.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-US"];
    [ut setRate:0.03f];
    [synt speakUtterance:ut];
}

-(void) buttonEdit:(id)sender{
    if (word.enabled == YES) {
        word.enabled = NO;
        edit.title = @"Edit";
        word.backgroundColor = [UIColor clearColor];
        editing = NO;
        cameraImage.enabled = NO;
        addImage.enabled = NO;
        datePicker.hidden = YES;
        date.text = [formatter stringFromDate:datePicker.date];
        date.hidden = NO;
        
    }
    else {
        word.enabled = YES;
        edit.title = @"Done";
        word.backgroundColor = [UIColor whiteColor];
        editing = YES;
        cameraImage.enabled = YES;
        addImage.enabled = YES;
        datePicker.date = [formatter dateFromString:let.date];
        datePicker.hidden = NO;
        date.hidden = YES;
    }
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    Letter *lete = [data returnLetterWithNumber:let.i];
    lete.word = word.text;
    lete.date = [formatter stringFromDate:datePicker.date];
    [realm commitWriteTransaction];
}

-(void) buttonReset:(id)sender{
    imageView.transform = CGAffineTransformIdentity;
    imageView.frame = CGRectMake(20, 90, 280, 280);
    //word.text = [data.letters objectAtIndex:let.i];
    
}

-(void) addImage:(id)sender{
    UIImagePickerController *catch = [[UIImagePickerController alloc]init];
    catch.delegate = self;
    catch.allowsEditing = YES;
    catch.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:catch animated:YES completion:nil];
}

-(void) cameraImage:(id)sender{
    UIImagePickerController *catch = [[UIImagePickerController alloc]init];
    catch.delegate = self;
    catch.allowsEditing = YES;
    catch.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:catch animated:YES completion:nil];
}

-(void) imagePickerController:(UIImagePickerController *)catch didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *changedImage = info[UIImagePickerControllerEditedImage];
    imageView.image = changedImage;
    [catch dismissViewControllerAnimated:YES completion:nil];
}

-(void)longPress:(UILongPressGestureRecognizer*)longPress{
    if (longPress.state == UIGestureRecognizerStateBegan) {
        // Limpa as animaçoes anteriores, e posiciona novamente
        imageView.transform = CGAffineTransformIdentity;
        imageView.frame = CGRectMake(20, 90, 280, 280);
    
        // Animações
        [UIView animateWithDuration:2.0 animations:^{
            imageView.transform = CGAffineTransformMakeScale(2, 2);
        }];
    }
    
    if (longPress.state == UIGestureRecognizerStateEnded) {
        // Para todas animaçoes
        [self.view.layer removeAllAnimations];
        
        // Animações
        [UIView animateWithDuration:1.0 animations:^{
            imageView.transform = CGAffineTransformIdentity;
        }];
    }
}

-(void)pinchImage:(UIPinchGestureRecognizer*)sender{
    if ([sender scale] > 0.3 && [sender scale] < 3.0) {
        imageView.transform = CGAffineTransformIdentity;
        imageView.frame = CGRectMake(20, 90, 280, 280);
        imageView.transform = CGAffineTransformMakeScale([sender scale], [sender scale]);
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [word resignFirstResponder];
}

@end
