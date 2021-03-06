//
//  FactoryAppDelegate.m
//  FactoryApp
//
//  Created by David Wieringa on 5/27/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "FactoryAppDelegate.h"
#import <HockeySDK/HockeySDK.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import "Tracker.h"

NSString * const GOOGLE_ANALYTICS_TRACKING_ID = @"UA-59295519-1";

@implementation FactoryAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"882925d36c59cb8f64014e78d8512767"];
//    [[BITHockeyManager sharedHockeyManager].authenticator setIdentificationType:BITAuthenticatorIdentificationTypeDevice];
//    [[BITHockeyManager sharedHockeyManager] startManager];
//    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];

    [Fabric with:@[CrashlyticsKit]];
    [self setupGoogleAnalytics];
    
    self.justLaunched = YES;
    
    return YES;
}

- (void)setupGoogleAnalytics
{
    [[Tracker sharedTracker] setupWithTrackingID:GOOGLE_ANALYTICS_TRACKING_ID];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
//    if( [[BITHockeyManager sharedHockeyManager].authenticator handleOpenURL:url
//                                                          sourceApplication:sourceApplication
//                                                                 annotation:annotation]) {
//        return YES;
//    }
    
    /* Your own custom URL handlers */
    
    return NO;
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
