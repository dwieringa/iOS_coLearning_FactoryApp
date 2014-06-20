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
        _picURL = [NSURL URLWithString:properties[@"pic"][@"url"]];
    }
    return self;
}

@synthesize pic = _pic;
- (UIImage *)pic
{
    if (_pic == nil) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.picURL];
        [request setValue:@"nq5kBbLQqWjW7taX9UVLoiEkyCDJ8gONbw92Fx6d" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [request setValue:@"hwz7WjcntmkHEphq0JazkvX1WoN4jcLi3IKo5UbY" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        NSLog(@"Downlading %@", request.URL);
        NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        _pic = [UIImage imageWithData:imageData];
    }
    return _pic;
}

@end
