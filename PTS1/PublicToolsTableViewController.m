//
//  PublicToolsTableViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/18/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "PublicToolsTableViewController.h"
#import "Communicator.h"
#import "PublicToolDetailsViewController.h"

@interface PublicToolsTableViewController ()
@property Communicator* communicator;

@property NSArray* publicTools;

@property NSString *host;

@end

@implementation PublicToolsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.host = @"http://ec2-54-173-239-217.compute-1.amazonaws.com:8080/getPublicTools";
    
    //self.publicTools = @[@"Work In Progress"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //[self getPublicToolsForUser:@"-1"];
}

- (void) getPublicToolsForUser: (NSString*) userId {
    
    NSDictionary *requestData = @{@"userId":userId};
    
    [self.communicator communicateData:requestData ForURL:self.host completion:^(NSDictionary *responseData){
        
        self.publicTools = [responseData objectForKey:@"powerTools"];
        
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.publicTools count] > 0){
        
        self.tableView.backgroundView = nil;
        
        return 1;
        
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 10, self.view.bounds.size.height)];
        
        messageLabel.text = @"No tools are available currently near you, try refreshing the page";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;

        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
        
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if ([self.publicTools count] > 0) {
        return [self.publicTools count];
    }
    
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"publicTools"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"publicTools"];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    
    if([self.publicTools count] > 0){
        cell.textLabel.text = [self.publicTools objectAtIndex:indexPath.row];
        
        cell.detailTextLabel.text = @"Available";
        cell.detailTextLabel.textColor = [UIColor blueColor];
    }
    
    //NSDictionary* powerTool = [self.publicTools objectAtIndex:indexPath.row];
    
    //cell.textLabel.text = [powerTool valueForKey:@"toolName"];
    
    //cell.imageView.image = ;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"PublicToolDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PublicToolDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PublicToolDetailsViewController* detailViewController = segue.destinationViewController;
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


@end
