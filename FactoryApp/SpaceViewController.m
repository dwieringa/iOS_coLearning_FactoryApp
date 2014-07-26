//
//  SpaceViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/16/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "SpaceViewController.h"
#import "SWRevealViewController.h"

@interface SpaceViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (strong, nonatomic, readonly) NSArray *photos;
@property (strong, nonatomic, readonly) NSArray *descriptions;
@property (nonatomic) NSInteger selectedImageIndex;

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
                             [UIImage imageNamed:@"kitchen-clear"],
                             [UIImage imageNamed:@"meeting room-clear"],
                             [UIImage imageNamed:@"open space-clear"],
                             //[UIImage imageNamed:@"open space-blurred"],
                             [UIImage imageNamed:@"open space 2-clear"],
                             [UIImage imageNamed:@"skype room-clear"],
                             nil];
    return _photos;
}

@synthesize descriptions = _descriptions;
- (NSArray *)descriptions
{
    if (!_descriptions) _descriptions = [NSArray arrayWithObjects:
                                         [NSString stringWithFormat:@"Kitchen"],
                                         [NSString stringWithFormat:@"Meeting Room"],
                                         [NSString stringWithFormat:@"Open Space"],
                                         //[NSString stringWithFormat:@"open space-blurred"],
                                         [NSString stringWithFormat:@"Open Space 2"],
                                         [NSString stringWithFormat:@"Skype Room"],
                                         nil];
    return _descriptions;
}

- (void)setSelectedImageIndex:(NSInteger)imageIndex
{
    _selectedImageIndex = imageIndex;
    if (_selectedImageIndex < 0) _selectedImageIndex = self.photos.count-1;
    if (_selectedImageIndex >= self.photos.count) _selectedImageIndex = 0;
    
    self.mainImageView.image = self.photos[_selectedImageIndex];
    self.descriptionLabel.text = [self.descriptions[_selectedImageIndex] uppercaseString];

    // load left image view
    if (_selectedImageIndex == 0) {
        self.leftImageView.image = self.photos[self.photos.count-1];
    } else {
        self.leftImageView.image = self.photos[_selectedImageIndex-1];
    }
    
    // load right image view
    if (_selectedImageIndex == self.photos.count-1) {
        self.rightImageView.image = self.photos[0];
    } else {
        self.rightImageView.image = self.photos[_selectedImageIndex+1];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mainImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mainImageView.layer.borderWidth = 1.5;
    
    self.leftImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.leftImageView.layer.borderWidth = 1.5;
    
    self.rightImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.rightImageView.layer.borderWidth = 1.5;
    
    self.selectedImageIndex = 0;
    
    // Change button color
    _menuButton.tintColor = [UIColor lightGrayColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)leftSwipeDetected:(UISwipeGestureRecognizer *)sender
{
    self.selectedImageIndex = self.selectedImageIndex + 1;
}

- (IBAction)rightSwipeDetected:(UISwipeGestureRecognizer *)sender
{
    self.selectedImageIndex = self.selectedImageIndex - 1;
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
