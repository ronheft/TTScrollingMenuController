//
//  TTAppDelegate.m
//  TTScrollingMenuController
//
//  Created by Ronald Heft on 7/17/12.
//  Copyright (c) 2012 Trifecta Technologies, Inc. All rights reserved.
//

#import "TTAppDelegate.h"
#import "TTScrollingMenuController.h"
#import "TTTableViewController.h"

@implementation TTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIViewController *redView = [[UIViewController alloc] init];
    redView.view.backgroundColor = [UIColor redColor];
    redView.title = @"Red View";
    
    UIViewController *tableView = [[TTTableViewController alloc] init];
    tableView.title = @"Table View";
    
    UIViewController *orangeView = [[UIViewController alloc] init];
    orangeView.view.backgroundColor = [UIColor orangeColor];
    orangeView.title = @"Orange View";
    
    TTScrollingMenuController *menuController = [TTScrollingMenuController new];
    menuController.viewControllers = [[NSArray alloc] initWithObjects:redView, tableView, orangeView, nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = menuController;
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
