//
//  Tracker.m
//  FactoryApp
//
//  Created by Dave Wieringa on 2/3/15.
//  Copyright (c) 2015 Userwise Solutions. All rights reserved.
//

#import "Tracker.h"
#import <GoogleAnalytics-iOS-SDK/GAI.h>
#import <GoogleAnalytics-iOS-SDK/GAIFields.h>
#import <GoogleAnalytics-iOS-SDK/GAIDictionaryBuilder.h>

@implementation Tracker

- (void)setupWithTrackingID:(NSString *)trackingID
{
    [GAI sharedInstance].trackUncaughtExceptions = NO;
    [GAI sharedInstance].dispatchInterval = 30.0f;
    [[GAI sharedInstance] trackerWithTrackingId:trackingID];
    [[GAI sharedInstance].logger setLogLevel:kGAILogLevelWarning];
}

- (void)trackScreenViewWithName:(NSString *)name
{
    // May return nil if a tracker has not already been initialized with a
    // property ID.
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:name];
    
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)trackButtonTapWithName:(NSString *)name
{
    GAIDictionaryBuilder *eventInfo = [GAIDictionaryBuilder createEventWithCategory:@"interactions"
                                                                             action:@"button_tap"
                                                                              label:name
                                                                              value:nil];
    [[GAI sharedInstance].defaultTracker send:[eventInfo build]];
}

+ (Tracker *)sharedTracker
{
    static Tracker *tracker;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tracker = [[Tracker alloc] init];
    });
    return tracker;
}

@end
