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
    NSArray *_members;
    NSURLConnection *connection;
    NSMutableData *jsonData;
}
@end

@implementation MemberDatastore

+ (MemberDatastore*)sharedInstance
{
    static MemberDatastore *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MemberDatastore alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.parse.com/1/classes/member"]];
        [request setValue:@"nq5kBbLQqWjW7taX9UVLoiEkyCDJ8gONbw92Fx6d" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [request setValue:@"hwz7WjcntmkHEphq0JazkvX1WoN4jcLi3IKo5UbY" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        
        NSData *theData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (theData == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Problem" message:@"Member information cannot be obtained at this time." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alert show];
        } else {
            
            NSDictionary *allMembers = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:theData options:0 error:nil];
            
            NSMutableArray *memberArray = [NSMutableArray array];
            for (NSDictionary *memberDictionary in allMembers[@"results"]) {
                [memberArray addObject:[[Member alloc] initWithDictionary:memberDictionary]];
            }
            
            NSSortDescriptor *sort1 = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:YES];
            NSSortDescriptor *sort2 = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
            _members=[memberArray sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sort1, sort2, nil]];
        }
    }
    
    return self;
}

- (id)initWithTestData {
    self = [super init];
    if (self) {
        NSDictionary *trentonDictionary = @{@"AMA": @"",
                                            @"BIO": @"",
                                            @"EMAIL": @"",
                                            @"FB": @"",
                                            @"NAME": @"Trenton Broughton",
                                            @"TWITTER": @"",
                                            @"pic": @""};
        NSDictionary *garrickDictionary = @{@"AMA": @"",
                                            @"BIO": @"",
                                            @"EMAIL": @"",
                                            @"FB": @"",
                                            @"NAME": @"Garrick Pohl",
                                            @"TWITTER": @"",
                                            @"pic": @""};
        NSDictionary *ronDictionary = @{@"AMA": @"",
                                        @"BIO": @"",
                                        @"EMAIL": @"",
                                        @"FB": @"",
                                        @"NAME": @"Ron VanSurksum",
                                        @"TWITTER": @"",
                                        @"pic": @""};
        _members = [@[[[Member alloc] initWithDictionary:trentonDictionary],
                     [[Member alloc] initWithDictionary:garrickDictionary],
                     [[Member alloc] initWithDictionary:ronDictionary]] mutableCopy];
    }
    return self;
}

- (NSArray *)members
{
    return _members;
}

- (NSUInteger)count {
    return [self.members count];
}

- (Member *)recordAtIndex:(NSUInteger)index {
    return self.members[index];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        // alert acknowledged
    }
}

@end
