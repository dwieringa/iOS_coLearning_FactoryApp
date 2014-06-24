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

@interface MemberTableViewController () {
    MemberDatastore *datastore;
}

@end

@implementation MemberTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        datastore = [[MemberDatastore alloc] init];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // change Back button to hamburger per design TODO: move this to superclass
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"testburger"]];
    self.navigationController.navigationBar.tintColor = [UIColor grayColor];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"testburger"]];

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
    return [datastore count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memberCell" forIndexPath:indexPath];
    
    // Configure the cell...
    Member *member = [datastore recordAtIndex:indexPath.row];
    cell.textLabel.text = member.name;
    [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:20]];
    cell.textLabel.textColor = [UIColor colorWithRed:236.0/255.0 green:172.0/255.0 blue:0 alpha:1];

    cell.imageView.image = member.pic;
    cell.imageView.layer.cornerRadius = 21; //cell.imageView.frame.size.width / 2.0;
    cell.imageView.clipsToBounds = YES;
    
    if(indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:0.957 green:0.961 blue:0.965 alpha:1] /*#f4f5f6*/;
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    return cell;
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
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Member *person = [datastore recordAtIndex:indexPath.row];
        vc.person = person;
    }
}

@end
