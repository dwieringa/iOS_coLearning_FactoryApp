//
//  MemberDatastore.m
//  SleepyPeople
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 David Wieringa. All rights reserved.
//

#import "MemberDatastore.h"
#import "Member.h"

@interface MemberDatastore () {
    NSMutableArray *members;
    NSURLConnection *connection;
    NSMutableData *jsonData;
}
@end

@implementation MemberDatastore

- (id)init {
    self = [super init];
    if (self) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.parse.com/1/classes/member"]];
        [request setValue:@"nq5kBbLQqWjW7taX9UVLoiEkyCDJ8gONbw92Fx6d" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [request setValue:@"hwz7WjcntmkHEphq0JazkvX1WoN4jcLi3IKo5UbY" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        
        NSData *theData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *allMembers = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:theData options:0 error:nil];
        
        members = [NSMutableArray array];
        for (NSDictionary *memberDictionary in allMembers[@"results"]) {
            [members addObject:[[Member alloc] initWithDictionary:memberDictionary]];
        }
    }
    
    return self;
}

- (id)initWithTestData {
    self = [super init];
    if (self) {
        NSDictionary *trentonDictionary = @{@"ama": @"",
                                            @"bio": @"",
                                            @"email": @"",
                                            @"fb": @"",
                                            @"name": @"Trenton Broughton",
                                            @"twitter": @"",
                                            @"pic": @""};
        NSDictionary *garrickDictionary = @{@"ama": @"",
                                            @"bio": @"",
                                            @"email": @"",
                                            @"fb": @"",
                                            @"name": @"Garrick Pohl",
                                            @"twitter": @"",
                                            @"pic": @""};
        NSDictionary *ronDictionary = @{@"ama": @"",
                                        @"bio": @"",
                                        @"email": @"",
                                        @"fb": @"",
                                        @"name": @"Ron VanSurksum",
                                        @"twitter": @"",
                                        @"pic": @""};
        members = [@[[[Member alloc] initWithDictionary:trentonDictionary],
                     [[Member alloc] initWithDictionary:garrickDictionary],
                     [[Member alloc] initWithDictionary:ronDictionary]] mutableCopy];
    }
    return self;
}

- (NSUInteger)count {
    return [members count];
}

- (Member *)recordAtIndex:(NSUInteger)index {
    return members[index];
}

@end
