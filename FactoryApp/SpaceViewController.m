//
//  SpaceViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/16/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "SpaceViewController.h"

@interface SpaceViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.scrollView.pagingEnabled = YES;
    
    CGRect viewRect = self.scrollView.frame;
    viewRect.origin.x = 0;
    viewRect.origin.y = 0;
    CGRect contentRect = viewRect;
    contentRect.size.width *= 5;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:viewRect];
    imageView.image = [UIImage imageNamed:@"kitchen"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:imageView];
    
    viewRect.origin.x += viewRect.size.width;
    imageView = [[UIImageView alloc] initWithFrame:viewRect];
    imageView.image = [UIImage imageNamed:@"meeting room"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:imageView];
    
    viewRect.origin.x += viewRect.size.width;
    imageView = [[UIImageView alloc] initWithFrame:viewRect];
    imageView.image = [UIImage imageNamed:@"open space"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:imageView];
    
    viewRect.origin.x += viewRect.size.width;
    imageView = [[UIImageView alloc] initWithFrame:viewRect];
    imageView.image = [UIImage imageNamed:@"open space 2"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:imageView];
    
    viewRect.origin.x += viewRect.size.width;
    imageView = [[UIImageView alloc] initWithFrame:viewRect];
    imageView.image = [UIImage imageNamed:@"skype room"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:imageView];
    
    self.scrollView.contentSize = contentRect.size;
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
