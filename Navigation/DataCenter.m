//
//  DataCenter.m
//  Navigation
//
//  Created by João Marcos on 16/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "DataCenter.h"

@implementation DataCenter {
    NSArray *letters;
    NSArray *images;
    NSArray *words;
}

-(void) initData {
    letters = [[NSArray alloc]initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"X", @"W", @"Y", @"Z", nil];
    words = [[NSArray alloc] initWithObjects:@"Apple", @"Battery", @"Carro", @"D", @"Eletricidade", @"Faca", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"X", @"W", @"Yellow", @"Zoo", nil];
    images = [[NSArray alloc] initWithObjects:@"Apple.png", @"Battery.png", @"Carro.png", @"D.png", @"Eletricidade.png", @"Faca.png", @"G.png", @"H.png", @"I.png", @"J.png", @"K.png", @"L.png", @"M.png", @"N.png", @"O.png", @"P.png", @"Q.png", @"R.png", @"S.png", @"T.png", @"U.png", @"V.png", @"X.png", @"W.png", @"Yellow.png", @"Zoo.png", nil];
}

-(NSString*)returnLetter:(int)i{
    NSLog(@"Classe - %@",[letters objectAtIndex:i]);
    return [letters objectAtIndex:i];
}

-(NSString*)returnWord:(int)i{
    return [words objectAtIndex:i];
}

-(UIImage*)returnImage:(int)i{
    return [UIImage imageNamed:[images objectAtIndex:i]];
}


@end
