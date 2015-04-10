//
//  Letter.h
//  Navigation
//
//  Created by João Marcos on 23/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>

@interface Letter : RLMObject


@property NSString *letter;
@property NSString *word;
@property NSString *image;
@property NSString *date;
@property int i;

@end
