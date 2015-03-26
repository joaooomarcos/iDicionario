//
//  DataCenter.h
//  Navigation
//
//  Created by João Marcos on 16/03/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface DataCenter : NSObject

@property RLMRealm *rr;

-(void) initData;
-(NSString*) returnLetter:(int)i;
-(NSString*) returnWord:(int)i;
-(UIImage*) returnImage:(int)i;
-(int) countData;

+(DataCenter *)instance;
-(NSArray*) returnAll;

@end
