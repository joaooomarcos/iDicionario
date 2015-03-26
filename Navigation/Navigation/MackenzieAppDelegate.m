//
//  MackenzieAppDelegate.m
//  Navigation
//
//  Created by João Marcos on 2/21/14.
//  Copyright (c) 2014 João Marcos. All rights reserved.
//

#import "MackenzieAppDelegate.h"
#import "ViewController.h"
#import "TableView.h"
#import "SearchViewController.h"

@implementation MackenzieAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Criando as Views
    ViewController *viewController = [[ViewController alloc]initWithNibName:nil bundle:nil];
    TableView *tbv = [[TableView alloc]init];
    SearchViewController *searchVC = [[SearchViewController alloc]init];
    
    // Criando a TabBarController
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    // Criando a Navigation Controller
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:viewController];
    
    // Cor da NC
    self.navigationController.navigationBar.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    // Adicionando as Views na TabBar
    [tabBarController addChildViewController:self.navigationController];
    [tabBarController addChildViewController:tbv];
    [tabBarController addChildViewController:searchVC];

    // Setando o Título do item da TabBar
    [viewController setTitle: @"Letters"];
    [searchVC setTitle:@"Search"];
    
    tabBarController.tabBar.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0];
    tabBarController.view.tintColor = [UIColor colorWithRed:0.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarController;
    
    // Colocando os icones e nomes dos itens da TabBar
    viewController.tabBarItem.image = [UIImage imageNamed:@"iconnav.png"];
    tbv.tabBarItem.title = @"List";
    tbv.tabBarItem.image = [UIImage imageNamed:@"iconlist.png"];
    searchVC.tabBarItem.image = [UIImage imageNamed:@"iconSearch.png"];
    
    // Cor de fundo da view
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
