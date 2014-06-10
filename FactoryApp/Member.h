//
//  Member.h
//  SleepyPeople
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 David Wieringa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property NSString *objectId;
@property NSString *ama;
@property NSString *bio;
@property NSString *email;
@property NSString *fb;
@property NSString *name;
@property NSString *twitter;
@property UIImage *pic;

- (id)initWithDictionary:(NSDictionary *)properties;

@end
