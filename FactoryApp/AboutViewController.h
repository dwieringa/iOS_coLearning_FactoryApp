//
//  AboutViewController.h
//  FactoryApp
//
//  Created by David Wieringa on 6/23/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController  : UIViewController<MFMailComposeViewControllerDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuButton;

@end
