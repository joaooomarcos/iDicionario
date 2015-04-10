//
//  DataCenter.h
//  Navigation
//
//  Created by João Marcos on 16/03/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "Letter.h"

@interface DataCenter : NSObject

@property RLMRealm *rr;

@property NSArray *letters;
@property NSArray *images;
@property NSArray *words;
@property NSArray *dates;
@property int search;

-(void) initData;
-(NSString*) returnLetter:(int)i;
-(NSString*) returnWord:(int)i;
-(UIImage*) returnImage:(int)i;
-(Letter*)returnLetterWithNumber:(int)i;
-(int) countData;

+(DataCenter *)instance;
-(NSArray*) returnAll;

@end
