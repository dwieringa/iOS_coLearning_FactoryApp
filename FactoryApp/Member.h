//
//  Member.h
//  SleepyPeople
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 David Wieringa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *ama;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *fb;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSURL *picURL;
@property (nonatomic, strong, readonly) UIImage *pic;
@property (nonatomic, strong) UIImage *thumbnail;

- (id)initWithDictionary:(NSDictionary *)properties;

@end
