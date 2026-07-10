//
//  AppDelegate_iPad.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "Aq16ViewController.h"
#import "Aq3264ViewController.h"
#import "AqOneViewController.h"


@implementation AppDelegate_iPad

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
	
    
	// Create the TabBarController
	tabBarController = [[UITabBarController alloc] init];
	
	// Create the Three View controllers
	UIViewController *vc1Aq16 = [[Aq16ViewController alloc] init];
	UIViewController *vc2Aq3264 = [[Aq3264ViewController alloc] init];
	UIViewController *vc3AqOne = [[AqOneViewController alloc] init];
  
	
	// Make an array containing the tree view controllers
	NSArray *viewControllers = @[vc1Aq16, vc2Aq3264, vc3AqOne];
	
	
	
	// Attach them to the tab bar controller
	[tabBarController setViewControllers:viewControllers];
  
	
	
	// Put the tabBarController's view on the window
	[window addSubview:[tabBarController view]];
	
	//show the window
    [window makeKeyAndVisible];
   
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}




@end
