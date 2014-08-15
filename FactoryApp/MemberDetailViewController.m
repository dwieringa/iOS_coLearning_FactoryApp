//
//  MemberDetailViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "WebViewController.h"

@interface MemberDetailViewController () {
    NSURL *twitterAppURL;
    NSURL *twitterWebURL;
    NSURL *facebookAppURL;
    NSURL *facebookWebURL;
}

@property IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *askMeAbout;
@property (weak, nonatomic) IBOutlet UILabel *aboutMember;
@property (weak, nonatomic) IBOutlet UIView *socialLinkView;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;

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

    // fill in member bio
    if (![self.person.bio isEqual: @""] && [self.aboutMember respondsToSelector:@selector(setAttributedText:)])
    {    // fill about text in attributed fashion
        
        NSMutableString *aboutText = [NSMutableString stringWithFormat:@"About %@: ", self.person.firstName];
        NSRange rangeOfBold = NSMakeRange(0, aboutText.length);
        [aboutText appendString:self.person.bio];

        UIFont *regularFont = [UIFont fontWithName:@"HelveticaNeue" size:14];
        UIFont *boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:regularFont, NSFontAttributeName, nil];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:aboutText attributes:attrs];
        
        [attributedText setAttributes:[NSDictionary dictionaryWithObjectsAndKeys: boldFont, NSFontAttributeName, nil] range:rangeOfBold];
        
        [self.aboutMember setAttributedText:attributedText];
    } else {
        self.aboutMember.text = self.person.bio;
        [self.aboutMember sizeToFit];
    }
    
    twitterAppURL = [NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@",self.person.twitter]];
    twitterWebURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://twitter.com/%@",self.person.twitter]];
    facebookAppURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@",self.person.facebook]];
    facebookWebURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://facebook.com/%@",self.person.facebook]];
    
    // dynamically layout social link buttons based on which services the member advertises
    [self.socialLinkView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    NSDictionary *nameMap = @{@"facebook": self.facebookButton,
                              @"twitter": self.twitterButton,
                              @"email": self.emailButton};
    NSMutableString *horizontalVFL = [NSMutableString stringWithFormat:@"H:|->=0-"];
    // H:|->=0-[twitter(50)]-8-[facebook(50)]-8-[email(50)]->=0-|
    // H:|->=0-[twitter(50)]-8-[email(50)]->=0-|
    // H:|->=0-[email(50)]->=0-|

    BOOL hasButtons = NO;
    if (![self.person.twitter isEqualToString:@""]) {
        [self.socialLinkView addSubview:self.twitterButton];
        [horizontalVFL appendString:@"[twitter(50)]"];
        [self.socialLinkView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:|[twitter(50)]|"
                                             options:0 metrics:nil views:nameMap]];
        hasButtons = YES;
    }
    
    if (![self.person.facebook isEqualToString:@""]) {
        [self.socialLinkView addSubview:self.facebookButton];
        if (hasButtons) { [horizontalVFL appendString:@"-8-"]; }
        [horizontalVFL appendString:@"[facebook(50)]"];
        [self.socialLinkView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:|[facebook(50)]|"
                                             options:0 metrics:nil views:nameMap]];
        hasButtons = YES;
    }
    
    if (![self.person.email isEqualToString:@""]) {
        [self.socialLinkView addSubview:self.emailButton];
        if (hasButtons) { [horizontalVFL appendString:@"-8-"]; }
        [horizontalVFL appendString:@"[email(50)]"];
        [self.socialLinkView addConstraints:[NSLayoutConstraint
                                             constraintsWithVisualFormat:@"V:|[email(50)]|"
                                             options:0 metrics:nil views:nameMap]];
        hasButtons = YES;
    }
    [horizontalVFL appendString:@"->=0-|"];
    [self.socialLinkView addConstraints:[NSLayoutConstraint
                                         constraintsWithVisualFormat:horizontalVFL
                                         options:0 metrics:nil views:nameMap]];
}

- (IBAction)twitterButtonPressed:(id)sender {
    if ([[UIApplication sharedApplication] canOpenURL:twitterAppURL]) {
        [[UIApplication sharedApplication] openURL:twitterAppURL];
    } else {
        [self performSegueWithIdentifier: @"showTwitterSegue" sender: self];
    }
}

- (IBAction)facebookButtonPressed:(id)sender
{
    if ([[UIApplication sharedApplication] canOpenURL:facebookAppURL]) {
        NSLog(@"Launching Facebook app");
        [[UIApplication sharedApplication] openURL:facebookAppURL];
    } else {
        NSLog(@"Launching Facebook webview");
        [self performSegueWithIdentifier: @"showFacebookSegue" sender: self];
    }
}

- (IBAction)emailButtonPressed:(id)sender
{
    
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;
        [mailCont setToRecipients:[NSArray arrayWithObject:self.person.email]];
        [mailCont setSubject:@"Hello!"];
        [mailCont setMessageBody:@"\n\nSent from FactoryApp" isHTML:NO];
        [self presentViewController:mailCont animated:YES completion:nil];
    }
    
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

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    //handle any error
    [controller dismissViewControllerAnimated:YES completion:nil];
}

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
}


@end
