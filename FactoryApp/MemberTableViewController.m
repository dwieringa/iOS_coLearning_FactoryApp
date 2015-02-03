//
//  MemberTableViewController.m
//  FactoryApp
//
//  Created by David Wieringa on 6/10/14.
//  Copyright (c) 2014 Userwise Solutions. All rights reserved.
//

#import "MemberTableViewController.h"
#import "MemberDetailViewController.h"
#import "Member.h"
#import "MemberDatastore.h"
#import "SWRevealViewController.h"
#import "Tracker.h"

static NSInteger const RowHeight = 60;

@interface MemberTableViewController ()
@end

@implementation MemberTableViewController
{
    NSArray *recipes;
    NSArray *searchResults;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
        return [MemberDatastore.sharedInstance count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Member *member = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        member = [searchResults objectAtIndex:indexPath.row];
    } else {
        member = [MemberDatastore.sharedInstance recordAtIndex:indexPath.row];
    }
    cell.textLabel.text = member.name;
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    cell.textLabel.textColor = [UIColor colorWithRed:236.0/255.0 green:172.0/255.0 blue:0 alpha:1];

    if(indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1] /*#f4f5f6*/;
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    // if the image hasn't been downloaded yet, do so in a background thread and update the table when complete
    if (member.thumbnail == nil) {

        //create a blank placeholder
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(50, 50), NO, 0.0);
        UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.imageView.image = blank;
        
        // initiate the download in the background
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        __weak UIViewController *weakSelf = self;
        dispatch_async(queue, ^{
            member.thumbnail = member.thumbnailFromSource; // the download happens here

            // update the TableViewCell in the main thread if the user hasn't scrolled off the screen
            dispatch_sync(dispatch_get_main_queue(), ^{
                if ([weakSelf isViewLoaded]) {
                    // only update the table if the viewcontroller still exists and is being shown on the screen
                    if ([[tableView cellForRowAtIndexPath:indexPath].textLabel.text isEqualToString:[NSString stringWithFormat:@"%@ %@",member.firstName, member.lastName]]) {
                        // only update the cell if it is still holding the same person (cells get recycled as the user scrolls)
                        [tableView beginUpdates];
                        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                        [tableView endUpdates];
                    }
                }
            });
        });
    }
    else
    {
        cell.imageView.image = member.thumbnail;
        cell.imageView.layer.cornerRadius = cell.imageView.image.size.width / 2.0;
        cell.imageView.clipsToBounds = YES;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RowHeight;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    [[Tracker sharedTracker] trackButtonTapWithName:@"Search Run"];

    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    searchResults = [MemberDatastore.sharedInstance.members filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showMemberDetailsSegue"]) {
        // Get the new view controller using [segue destinationViewController].
        MemberDetailViewController *vc = segue.destinationViewController;

        // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = nil;
        Member *person = nil;

        if (self.searchDisplayController.active) {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            person = [searchResults objectAtIndex:indexPath.row];
        } else {
            indexPath = [self.tableView indexPathForSelectedRow];
            person = [MemberDatastore.sharedInstance recordAtIndex:indexPath.row];
        }

        vc.person = person;
    }
}

@end
