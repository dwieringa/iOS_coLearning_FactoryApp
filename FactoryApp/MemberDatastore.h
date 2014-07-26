//
//  MemberDatastore.h
//  SleepyPeople
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 David Wieringa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"

@interface MemberDatastore : NSObject <UIAlertViewDelegate>
+ (MemberDatastore*)sharedInstance;

- (id)initWithTestData;
- (NSUInteger)count;
- (Member *)recordAtIndex:(NSUInteger)index;
@property (nonatomic, readonly)NSArray *members;

@end
