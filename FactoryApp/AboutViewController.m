//
//  AboutViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/23/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "AboutViewController.h"
#import "WebViewController.h"
@import MapKit;

@interface AboutViewController () {
    NSURL *twitterAppURL;
    NSURL *twitterWebURL;
    NSURL *facebookAppURL;
    NSURL *facebookWebURL;
}

@end

@implementation AboutViewController

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

    twitterAppURL = [NSURL URLWithString:@"twitter://user?screen_name=coFactory"];
    twitterWebURL = [NSURL URLWithString:@"http://twitter.com/coFactory"];
    facebookAppURL = [NSURL URLWithString:@"fb://profile/159022818166"];
    facebookWebURL = [NSURL URLWithString:@"http://facebook.com/coFactory"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // change Back button to hamburger per design TODO: move this to superclass
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"hamburger"]];
    self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"hamburger"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twitterButtonPressed:(UIButton *)sender
{
    if ([[UIApplication sharedApplication] canOpenURL:twitterAppURL]) {
        [[UIApplication sharedApplication] openURL:twitterAppURL];
    } else {
        [self performSegueWithIdentifier: @"showTwitterSegue" sender: self];
    }

}

- (IBAction)facebookButtonPressed:(id)sender
{
    if ([[UIApplication sharedApplication] canOpenURL:facebookAppURL]) {
        [[UIApplication sharedApplication] openURL:facebookAppURL];
    } else {
        [self performSegueWithIdentifier: @"showFacebookSegue" sender: self];
    }
}

- (IBAction)emailUsPressed:(id)sender
{
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:[NSArray arrayWithObject:@"hello@workthefactory.com"]];
        [mailCont setSubject:@"Hello!"];
        [mailCont setMessageBody:@"\n\nSent from FactoryApp" isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)callUsPressed:(id)sender
{
    //TODO: check for dialing support on device
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Call The Factory" message:@"Would you like to call The Factory now or copy the number?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Call", @"Copy", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://616-379-9377"]];
    } else if (buttonIndex == 2) {
        [UIPasteboard generalPasteboard].string = @"616-379-9377";
    }
}

- (IBAction)visitUsPressed:(id)sender {
    CLLocationCoordinate2D theFactoryLocation = CLLocationCoordinate2DMake(42.963099, -85.669536);
    MKPlacemark* place = [[MKPlacemark alloc] initWithCoordinate: theFactoryLocation addressDictionary: nil];
    MKMapItem* destination = [[MKMapItem alloc] initWithPlacemark: place];
    destination.name = @"The Factory";
    destination.url = [NSURL URLWithString:@"http://www.workthefactory.com"];
    destination.phoneNumber = @"616.379.9377";
    NSArray* items = [[NSArray alloc] initWithObjects: destination, nil];
    NSDictionary* options = [[NSDictionary alloc] initWithObjectsAndKeys:
                             MKLaunchOptionsDirectionsModeDriving,
                             MKLaunchOptionsDirectionsModeKey, nil];
    [MKMapItem openMapsWithItems: items launchOptions: options];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTwitterSegue"]) {
        // Get the new view controller using [segue destinationViewController].
        WebViewController *vc = segue.destinationViewController;
        
        // Pass the needed URL to the new view controller.
        vc.url = twitterWebURL;
    } else if ([[segue identifier] isEqualToString:@"showFacebookSegue"]) {
        // Get the new view controller using [segue destinationViewController].
        WebViewController *vc = segue.destinationViewController;
        
        // Pass the needed URL to the new view controller.
        vc.url = facebookWebURL;
    }

    // restore the Navigation Bar back button to it's default state
    [self.navigationController.navigationBar setBackIndicatorImage:nil];
    self.navigationController.navigationBar.tintColor = nil;
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:nil];

}

@end
