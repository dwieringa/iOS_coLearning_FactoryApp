//
//  AboutViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/23/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "AboutViewController.h"
@import MapKit;

@interface AboutViewController ()

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)twitterButtonPressed:(UIButton *)sender {
}

- (IBAction)facebookButtonPressed:(id)sender {
}

- (IBAction)emailUsPressed:(id)sender {
}

- (IBAction)callUsPressed:(id)sender {
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
