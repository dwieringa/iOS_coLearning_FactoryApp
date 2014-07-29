//
//  SpaceViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/16/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "SpaceViewController.h"
#import "SWRevealViewController.h"

static NSInteger const RequiredLengthOfSwipeGesture = 100;

@interface SpaceViewController () {
    NSInteger imageViewWidth;
    NSInteger imageViewHeight;
    NSInteger imageViewY;
    NSInteger mainImageViewX;
    NSInteger leftImageViewX;
    NSInteger rightImageViewX;
}
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (strong, nonatomic, readonly) NSArray *photos;
@property (strong, nonatomic, readonly) NSArray *descriptions;
@property (nonatomic) NSInteger selectedImageIndex;
@property (nonatomic, readonly) NSInteger leftImageIndex;
@property (nonatomic, readonly) NSInteger rightImageIndex;

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
}

- (NSInteger)leftImageIndex
{
    if (_selectedImageIndex == 0) {
        return self.photos.count-1;
    } else {
        return _selectedImageIndex-1;
    }
}

- (NSInteger)rightImageIndex
{
    if (_selectedImageIndex == self.photos.count-1) {
        return 0;
    } else {
        return _selectedImageIndex+1;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedImageIndex = 0;
    
    self.mainImageView.image = self.photos[self.selectedImageIndex];
    self.mainImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.mainImageView.layer.borderWidth = 1.5;
    self.mainImageView.frame = CGRectMake(mainImageViewX, imageViewY, imageViewWidth, imageViewHeight);

    self.leftImageView.image = self.photos[self.leftImageIndex];
    self.leftImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.leftImageView.layer.borderWidth = 1.5;
    self.leftImageView.frame = CGRectMake(leftImageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    self.rightImageView.image = self.photos[self.rightImageIndex];
    self.rightImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.rightImageView.layer.borderWidth = 1.5;
    self.rightImageView.frame = CGRectMake(rightImageViewX, imageViewY, imageViewWidth, imageViewHeight);
    
    // Change button color
    _menuButton.tintColor = [UIColor lightGrayColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

}

- (void)viewDidLayoutSubviews
{
    // init image location/size values based on autolayouts outcome
    imageViewWidth = self.mainImageView.frame.size.width;
    imageViewHeight = self.mainImageView.frame.size.height;
    imageViewY = self.mainImageView.frame.origin.y;
    mainImageViewX = self.mainImageView.frame.origin.x;
    leftImageViewX = self.leftImageView.frame.origin.x;
    rightImageViewX = self.rightImageView.frame.origin.x;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pan:(UIPanGestureRecognizer *)recognizer {
    bool swipeCompleted = NO;
    
    if (recognizer.state == UIGestureRecognizerStateChanged ||
        recognizer.state == UIGestureRecognizerStateEnded) {
        
        // move images horizontally with gesture
        NSInteger xTranslation = [recognizer translationInView:self.view].x;
        self.mainImageView.frame = CGRectMake(mainImageViewX+xTranslation, imageViewY, imageViewWidth, imageViewHeight);
        self.leftImageView.frame = CGRectMake(leftImageViewX+xTranslation, imageViewY, imageViewWidth, imageViewHeight);
        self.rightImageView.frame = CGRectMake(rightImageViewX+xTranslation, imageViewY, imageViewWidth, imageViewHeight);
        
        // determine if swipe action should be completed
        if (abs(xTranslation) > RequiredLengthOfSwipeGesture) {

            // stop the gesture since it is now compmlete
            recognizer.enabled = NO;
            recognizer.enabled = YES;
            swipeCompleted = YES;
            
            if (xTranslation > 0) {
                // detected swipe to the right
                
                // right image view is wrapping around to become the left now (with new image)
                UIImageView *newLeftImageView = self.rightImageView;
                newLeftImageView.frame = CGRectMake((leftImageViewX-(mainImageViewX-leftImageViewX))+xTranslation, imageViewY, imageViewWidth, imageViewHeight);
                self.rightImageView = self.mainImageView;
                self.mainImageView = self.leftImageView;
                self.leftImageView = newLeftImageView;
                
                // load left image view
                self.selectedImageIndex -= 1;
                newLeftImageView.image = self.photos[self.leftImageIndex];
                
            } else if (xTranslation < 0) {
                // detected swipe to the left
                
                // left image view is wrapping around to become the right now (with new image)
                UIImageView *newRightImageView = self.leftImageView;
                newRightImageView.frame = CGRectMake(rightImageViewX+(rightImageViewX-mainImageViewX)+xTranslation, imageViewY, imageViewWidth, imageViewHeight);
                self.leftImageView = self.mainImageView;
                self.mainImageView = self.rightImageView;
                self.rightImageView = newRightImageView;
                
                // load right image view
                self.selectedImageIndex += 1;
                newRightImageView.image = self.photos[self.rightImageIndex];
            }
        }
        
        if (recognizer.state == UIGestureRecognizerStateEnded || swipeCompleted) {
            // animate the 3 images into their proper positions
            [UIView animateWithDuration:.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^ {
                                 self.leftImageView.frame = CGRectMake(leftImageViewX, imageViewY, imageViewWidth, imageViewHeight);
                                 self.mainImageView.frame = CGRectMake(mainImageViewX, imageViewY, imageViewWidth, imageViewHeight);
                                 self.rightImageView.frame = CGRectMake(rightImageViewX, imageViewY, imageViewWidth, imageViewHeight);
                             }
                             completion:^(BOOL finished) {}];
        }

        if (swipeCompleted) {
            // fade old description label out
            [UIView animateWithDuration:.25
                                  delay:0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^ { self.descriptionLabel.alpha = 0; }
                             completion:^(BOOL finished) {
                                 self.descriptionLabel.text = self.descriptions[self.selectedImageIndex];
                             }];
            // fade new description label in
            [UIView animateWithDuration:.25
                                  delay:.25
                                options:UIViewAnimationOptionCurveLinear
                             animations:^ { self.descriptionLabel.alpha = 1; }
                             completion:^(BOOL finished) {}];
        }
        
    }
}

#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
