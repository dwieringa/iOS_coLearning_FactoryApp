//
//  Member.m
//  SleepyPeople
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 David Wieringa. All rights reserved.
//

#import "Member.h"

static NSInteger const ThumbnailSize = 50;

@implementation Member

- (id)initWithDictionary:(NSDictionary *)properties {
    self = [super init];
    if (self) {
        _objectId = properties[@"objectId"];
        _ama = properties[@"AMA"];
        _bio = properties[@"BIO"];
        _email = properties[@"EMAIL"];
        _fb = properties[@"FB"];
        _firstName = properties[@"firstname"];
        _lastName = properties[@"lastname"];
        _twitter = properties[@"TWITTER"];
        _picURL = [NSURL URLWithString:properties[@"pic"][@"url"]];
        _thumbnailURL = [NSURL URLWithString:properties[@"thumbnail"][@"url"]];
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

- (NSString *)name
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

@synthesize thumbnailFromSource = _thumbnailFromSource;
- (UIImage *)thumbnailFromSource
{
    if (_thumbnailFromSource == nil) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.thumbnailURL];
        [request setValue:@"nq5kBbLQqWjW7taX9UVLoiEkyCDJ8gONbw92Fx6d" forHTTPHeaderField:@"X-Parse-Application-Id"];
        [request setValue:@"hwz7WjcntmkHEphq0JazkvX1WoN4jcLi3IKo5UbY" forHTTPHeaderField:@"X-Parse-REST-API-Key"];
        NSLog(@"Downlading thumbnail %@", request.URL);
        NSData *imageData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        _thumbnailFromSource = [UIImage imageWithData:imageData];
        
        // fall back to portrait if thumbnail unavailable
        if (_thumbnailFromSource == nil) {
            _thumbnailFromSource = self.pic;
        }

        // fall back to blank if portrait is also unavailable
        if (_thumbnailFromSource == nil) {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(ThumbnailSize, ThumbnailSize), NO, 0.0);
            UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            _thumbnailFromSource = blank;
        }
    }
    return _thumbnailFromSource;
}

- (void)setThumbnail:(UIImage *)thumbnail
{
    if (thumbnail != nil &&
        (thumbnail.size.width != ThumbnailSize || thumbnail.size.height != ThumbnailSize))
    {
        CGSize thumbnailSize = CGSizeMake(ThumbnailSize, ThumbnailSize);
        UIGraphicsBeginImageContextWithOptions(thumbnailSize, NO, 0.0f);
        [thumbnail drawInRect:CGRectMake(0, 0, thumbnailSize.width, thumbnailSize.height)];
        _thumbnail = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        _thumbnail = thumbnail;
    }
}

@end
