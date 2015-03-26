//
//  TableView.h
//  Navigation
//
//  Created by João Marcos on 18/03/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableView : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tb;

@end
