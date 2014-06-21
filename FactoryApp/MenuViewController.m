//
//  MenuViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/20/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "MenuViewController.h"
#import "FactoryAppDelegate.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

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

    // change Back button to hamburger
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"hamburger"]];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"hamburger"]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    FactoryAppDelegate *appDelegate = (FactoryAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (appDelegate.justLaunched) {
        [self performSegueWithIdentifier: @"MeetSegue" sender: self];
        appDelegate.justLaunched = NO;
    }
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
    
    // remove Back button text
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithTitle:@""
                                             style:UIBarButtonItemStylePlain
                                             target:nil
                                             action:nil];
}

@end
