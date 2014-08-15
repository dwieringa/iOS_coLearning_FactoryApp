//
//  MenuViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/20/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "MenuViewController.h"
#import "FactoryAppDelegate.h"
#import "SWRevealViewController.h"

@interface MenuViewController ()
@property (weak, nonatomic) IBOutlet UIButton *meetButton;
@property (weak, nonatomic) IBOutlet UIButton *spaceButton;
@property (weak, nonatomic) IBOutlet UIButton *aboutButton;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;

@end

@implementation MenuViewController

- (void)setup
{
}
- (void)awakeFromNib
{
    [self setup];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setup];
    return self;
}

- (void)viewDidLoad
{
    [[self.meetButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [[self.spaceButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [[self.joinButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [[self.aboutButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
        SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
        
        swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
            
            UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
            [navController setViewControllers: @[dvc] animated: NO ];
            [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
        };
        
    }
}

@end
