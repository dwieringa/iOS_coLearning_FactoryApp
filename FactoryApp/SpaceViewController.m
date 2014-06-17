//
//  SpaceViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/16/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "SpaceViewController.h"

@interface SpaceViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (strong, nonatomic, readonly) NSArray *photos;

@end

@implementation SpaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

@synthesize photos = _photos;
- (NSArray *)photos
{
    if (!_photos) _photos = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"kitchen"],
                             [UIImage imageNamed:@"meeting room"],
                             [UIImage imageNamed:@"open space"],
                             [UIImage imageNamed:@"open space 2"],
                             [UIImage imageNamed:@"skype room"],
                             nil];
    return _photos;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mainImageView.image = self.photos[1];
    self.leftImageView.image = self.photos[0];
    self.rightImageView.image = self.photos[2];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
