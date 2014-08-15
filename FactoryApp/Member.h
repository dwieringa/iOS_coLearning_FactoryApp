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
@property (nonatomic, strong) NSString *facebook;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong) NSString *twitter;
@property (nonatomic, strong) NSURL *picURL;
@property (nonatomic, strong, readonly) UIImage *pic;
@property (nonatomic, strong) NSURL *thumbnailURL;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong, readonly) UIImage *thumbnailFromSource;

- (id)initWithDictionary:(NSDictionary *)properties;

@end
