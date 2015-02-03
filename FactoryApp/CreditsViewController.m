//
//  CreditsViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 8/15/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "CreditsViewController.h"
#import "SWRevealViewController.h"
#import "WebViewController.h"
#import "Tracker.h"

@interface CreditsViewController ()

@end

@implementation CreditsViewController

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

    // Change button color
    _menuButton.tintColor = [UIColor lightGrayColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _menuButton.target = self.revealViewController;
    _menuButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[Tracker sharedTracker] trackScreenViewWithName:self.title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)daveTouched:(id)sender {
    [[Tracker sharedTracker] trackButtonTapWithName:@"Developer Tapped"];

    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:[NSArray arrayWithObject:@"davew@userwise.com"]];
        [mailCont setSubject:@"Factory App Inquiry"];
        [mailCont setMessageBody:@"\n\nSent from The Factory app" isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showElevatorUpSegue"]) {
        [[Tracker sharedTracker] trackButtonTapWithName:@"ElevatorUp Tapped"];

        // Get the new view controller using [segue destinationViewController].
        WebViewController *vc = segue.destinationViewController;
        
        // Pass the needed URL to the new view controller.
        vc.url = [NSURL URLWithString:@"http://www.elevatorup.com"];
    }
}

@end
