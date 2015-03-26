//
//  SearchViewController.m
//  Navigation
//
//  Created by João Marcos on 20/03/15.
//  Copyright (c) 2015 Vinicius Miana. All rights reserved.
//

#import "SearchViewController.h"
#import "DataCenter.h"
#import "Letter.h"

@interface SearchViewController (){
    UISearchBar *search;
    DataCenter *data;
    NSArray *results;
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [DataCenter instance];
    results = [[NSArray alloc]initWithArray:[data returnAll]];
    
    search = [[UISearchBar alloc] initWithFrame:CGRectMake(20, 50, self.view.bounds.size.width-40, 30)];
    search.delegate = self;
    [search becomeFirstResponder];
    [self.view addSubview:search];
    
    self.view.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:228.0/255.0 blue:255.0/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    for (int i = 0; i < results.count; i++) {
        Letter *let = [results objectAtIndex:i];
        if ([let.word isEqualToString:search.text]) {
            [searchBar resignFirstResponder];
            [self.tabBarController setSelectedIndex:0];
            return;
        }
    }

    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"position"];
    [shake setDuration:0.08];
    [shake setRepeatCount:4];
    [shake setAutoreverses:YES];
    [shake setFromValue:[NSValue valueWithCGPoint: CGPointMake(searchBar.center.x - 5,searchBar.center.y)]];
    [shake setToValue:[NSValue valueWithCGPoint: CGPointMake(searchBar.center.x + 5, searchBar.center.y)]];
    
    [search.layer addAnimation:shake forKey:@"shake"];
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
