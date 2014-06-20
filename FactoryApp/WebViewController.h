//
//  WebViewController.h
//  FactoryApp
//
//  Created by David Wieringa on 6/19/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSURL *url;
@end
