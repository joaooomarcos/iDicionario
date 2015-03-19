//
//  TabBarController.m
//  Navigation
//
//  Created by João Marcos on 19/03/15.
//  Copyright (c) 2015 João Marcos. All rights reserved.
//

#import "TabBarController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Setando preferencias de cor da TabBar
    [[UITabBar appearance]setTintColor:[UIColor colorWithRed:0.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0]];
    [[UITabBar appearance]setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
