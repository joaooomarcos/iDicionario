//
//  DataCenter.m
//  Navigation
//
//  Created by João Marcos on 16/03/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

#import "DataCenter.h"
#import "Letter.h"


@implementation DataCenter {
    NSArray *letters;
    NSArray *images;
    NSArray *words;
    NSArray *ind;
}
@synthesize rr;

static DataCenter *data = nil;

+(DataCenter *) instance{
    if (data == nil) {
        data = [[DataCenter alloc]init];
    }
    return data;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        rr = [RLMRealm defaultRealm];
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if([ud valueForKey:@"First"] == nil){
            [self initData];
            [ud setValue:@"Other" forKey:@"First"];
        }
    }
    return self;
}

-(void) initData {
    letters = [[NSArray alloc]initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    
    words = [[NSArray alloc] initWithObjects:@"Arrow", @"Batman", @"Captain America", @"Daredevil", @"Electro", @"Flash", @"Goku", @"Hulk", @"Iron Man", @"Joker", @"Kick-Ass", @"Loki", @"Magneto", @"Nova", @"Omega Red", @"Power Rangers", @"Quill", @"Rogue", @"Superman", @"Thor", @"Ultron", @"Vision", @"Wonder Woman", @"X-Men", @"Ymir", @"Zatanna", nil];
    
    images = [[NSArray alloc] initWithObjects:@"Arrow.png", @"Batman.png", @"CaptainAmerica.png", @"Daredevil.png", @"Electro.png", @"Flash.png", @"Goku.png", @"Hulk.png", @"IronMan.png", @"Joker.png", @"Kick-Ass.png", @"Loki.png", @"Magneto.png", @"Nova.png", @"OmegaRed.png", @"PowerRangers.png", @"Quill.png", @"Rogue.png", @"Superman.png", @"Thor.png", @"Ultron.png", @"Vision.png", @"WonderWoman.png", @"Xmen.png", @"Ymir.png", @"Zatanna.png", nil];
   // ind = [NSArray alloc] initWithObjects:<#(id), ...#>, nil
    
    for (int i = 0; i < letters.count; i++) {
        Letter *let = [[Letter alloc]init];
        let.word = [words objectAtIndex:i];
        let.letter = [letters objectAtIndex:i];
        let.image = [images objectAtIndex:i];
        
        [rr beginWriteTransaction];
        [rr addObject:let];
        [rr commitWriteTransaction];
    }
}

-(NSString*)returnLetter:(int)i{
//    NSLog(@"Classe - %@",[letters objectAtIndex:i]);
    return [letters objectAtIndex:i];
}

-(NSString*)returnWord:(int)i{
    return [words objectAtIndex:i];
}

-(UIImage*)returnImage:(int)i{
    return [UIImage imageNamed:[images objectAtIndex:i]];
}

-(int) countData{
    return (int) letters.count;
}

-(NSArray *)returnAll{
    RLMResults *results = [Letter allObjects];
    NSMutableArray *res = [[NSMutableArray alloc]init];
    for (Letter *let in results) {
        [res addObject:let];
    }
    
    return res;
}

@end
