//
//  AppDelegate_iPhone.m
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AppDelegate_iPhone.h"
#import "Aq16ViewController_iPhone.h"
#import "Aq3264ViewController_iPhone.h"
#import "AqOneViewController_iPhone.h"
#import "RXLViewController_iPhone.h"
#import "AqPrimeViewController_iPhone.h"


@implementation AppDelegate_iPhone

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
    // Override point for customization after application launch.
	
    
	// Create the TabBarController
	tabBarController = [[UITabBarController alloc] init];
	
	// Create the Three View controllers
	UIViewController *vc1Aq16 = [[Aq16ViewController_iPhone alloc] init];
	UIViewController *vc2Aq3264 = [[Aq3264ViewController_iPhone alloc] init];
	UIViewController *vc3AqOne = [[AqOneViewController_iPhone alloc] init];
    //UIViewController *vcRXL = [[RXLViewController_iPhone alloc]init];
    UIViewController *vcPrime = [[AqPrimeViewController_iPhone alloc]init];
	
	// Make an array containing the tree view controllers
	NSArray *viewControllers = @[vc1Aq16, vc2Aq3264, vc3AqOne, vcPrime];
	
	NSLog(@"Current view controllers %@ ", [viewControllers description]);
	
	// Attach them to the tab bar controller
	[tabBarController setViewControllers:viewControllers];
    //[[UITabBarItem appearance] setTitleTextAttributes:@{ UITextAttributeTextColor : [UIColor blackColor] }
                                            // forState:UIControlStateHighlighted];
    
    //[[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];
    
	// Put the tabBarController's view on the window
	[window addSubview:[tabBarController view]];
	
    self.window.rootViewController = tabBarController;
	
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
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
