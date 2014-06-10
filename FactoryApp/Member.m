//
//  Member.m
//  SleepyPeople
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 David Wieringa. All rights reserved.
//

#import "Member.h"

@implementation Member

- (id)initWithDictionary:(NSDictionary *)properties {
    self = [super init];
    if (self) {
        _objectId = properties[@"objectId"];
        _ama = properties[@"AMA"];
        _bio = properties[@"BIO"];
        _email = properties[@"EMAIL"];
        _fb = properties[@"FB"];
        _name = properties[@"NAME"];
        _twitter = properties[@"TWITTER"];
        _pic = properties[@"pic"];
    }
    return self;
}

@end
