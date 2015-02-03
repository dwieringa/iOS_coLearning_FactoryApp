//
//  Tracker.h
//  FactoryApp
//
//  Created by Dave Wieringa on 2/3/15.
//  Copyright (c) 2015 Userwise Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tracker : NSObject

- (void)setupWithTrackingID:(NSString *)trackingID;
- (void)trackScreenViewWithName:(NSString *)name;
- (void)trackButtonTapWithName:(NSString *)name;

+ (Tracker *)sharedTracker;

@end
