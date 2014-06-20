//
//  MemberDetailViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "WebViewController.h"

@interface MemberDetailViewController ()
@property IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *askMeAbout;
@property (weak, nonatomic) IBOutlet UILabel *aboutMember;

@end

@implementation MemberDetailViewController

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
    self.nameLabel.text = self.person.name;
    self.photoImageView.image = self.person.pic;
    self.askMeAbout.text = self.person.ama;
    [self.askMeAbout sizeToFit];
    self.aboutMember.text = self.person.bio;
    [self.aboutMember sizeToFit];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];   //it hides
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];    // it shows
}

- (IBAction)backButtonPressed:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPerson:(Member *)person {
    _person = person;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showTwitterSegue"]) {
        // Get the new view controller using [segue destinationViewController].
        WebViewController *vc = segue.destinationViewController;
        
        // Pass the needed URL to the new view controller.
        NSString *urlString = [NSString stringWithFormat:@"http://twitter.com/%@",self.person.twitter];
        vc.url = [NSURL URLWithString:urlString];
    } else if ([[segue identifier] isEqualToString:@"showFacebookSegue"]) {
        // Get the new view controller using [segue destinationViewController].
        WebViewController *vc = segue.destinationViewController;
        
        // Pass the needed URL to the new view controller.
        NSString *urlString = [NSString stringWithFormat:@"http://facebook.com/profile.php?id=%@",self.person.fb];
        vc.url = [NSURL URLWithString:urlString];
    }
}


@end
