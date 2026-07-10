//
//  AppDelegate_iPhone.h
//  RingDiag
//
//  Created by Stan Benoit on 6/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UITabBarController *tabBarController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@end

