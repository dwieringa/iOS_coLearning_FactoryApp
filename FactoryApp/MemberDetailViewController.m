//
//  MemberDetailViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "MemberDetailViewController.h"

@interface MemberDetailViewController ()
@property IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setPerson:(Member *)person {
    _person = person;
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
