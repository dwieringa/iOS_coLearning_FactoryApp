//
//  MemberDetailViewController.h
//  FactoryApp
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Member.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface MemberDetailViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic) Member *person;

@end
