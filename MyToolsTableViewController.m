//
//  MyToolsTableViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/13/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "MyToolsTableViewController.h"
#import "Communicator.h"
#import "MyToolDetailsViewController.h"
@import MobileCoreServices;

@interface MyToolsTableViewController ()

@property Communicator* communicator;
@property NSArray* userTools;
@property BOOL refreshButtonPressed;

@property NSString *host;

@end

@implementation MyToolsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.host = @"http://ec2-54-209-176-62.compute-1.amazonaws.com:8080/getMyTools";
    self.host = @"http://localhost:8080/getMyTools";
    
    self.refreshButtonPressed = FALSE;
    
    self.communicator = [Communicator new];
    
    [self getToolsForUser];
}

- (void) getToolsForUser {
    NSDictionary* userDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetails"];
    
    if(userDetails != nil && [userDetails count] > 0){
        NSString* userId = [userDetails objectForKey:@"userId"];

        NSDictionary *requestData = @{@"userId":userId};
        
        [self.communicator communicateData:requestData ForURL:self.host completion:^(NSDictionary *responseData){
            
            if ([responseData count] > 0) {
                NSString *status = [responseData objectForKey:@"status"];
                
                if ([status isEqualToString:@"SUCCESS"]) {
                    self.userTools = [responseData objectForKey:@"powerTools"];
                    
                    NSSortDescriptor *creationDateDescription = [[NSSortDescriptor alloc] initWithKey:@"creationdate" ascending:NO];
                    
                    NSArray *sortDescriptors = @[creationDateDescription];
                    
                    self.userTools = [self.userTools sortedArrayUsingDescriptors:sortDescriptors];
                    
                    [self performSelectorOnMainThread:@selector(updateTableViewData) withObject:nil waitUntilDone:NO];
                }
            } else {
                // Only show the error if user has explicitly asked for page refresh, otherwise do not display any error
                if (self.refreshButtonPressed) {
                    self.refreshButtonPressed = FALSE;
                    
                    [self performSelectorOnMainThread:@selector(showError:) withObject:@"Oops, we cannot connect to the server at this time, please try again" waitUntilDone:NO];
                }
            }
            
        }];
        
    } else {
        if (self.refreshButtonPressed) {
            self.refreshButtonPressed = FALSE;
            
            [self showError:@"You need to login before you can reload your tools"];
        }
    }
}

- (void) updateTableViewData {
    [self.tableView reloadData];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if([self.userTools count] > 0){
        
        self.tableView.backgroundView = nil;
        
        return 1;
        
    } else {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 10, self.view.bounds.size.height)];
        
        messageLabel.text = @"Share your first tool by tapping '+'";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        //messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        [messageLabel sizeToFit];
        
        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([self.userTools count] > 0) {
        return [self.userTools count];
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    
    switch (section){
            
        case 0:
            sectionName = @"My Tools";
            break;
            
        default:
            sectionName = @"";
            break;
    }
    
    return sectionName;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tools"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tools"];
    }
    
    
    if([self.userTools count] > 0){
        NSDictionary* powerTool = [self.userTools objectAtIndex:indexPath.row];

        cell.textLabel.text = [powerTool valueForKey:@"toolname"];
        NSString *toolStatus = [powerTool valueForKey:@"status"];
        
        if ([toolStatus isEqualToString:@"AVAILABLE"]) {
            cell.detailTextLabel.text = @"Available";
            cell.detailTextLabel.textColor = [UIColor blueColor];
            
        } else {
            cell.detailTextLabel.text = @"Unavailable";
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
                
        cell.imageView.image = [self getImageFromTempDirWithName: [powerTool valueForKey:@"toolimagename"]];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

- (UIImage*) getImageFromTempDirWithName: (NSString* ) imageName {
    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:imageName] URLByAppendingPathExtension:@"jpg"];
    
    UIImage* image = [UIImage imageWithContentsOfFile:[fileURL path]];
    
    if (image == NULL) {
        image = [UIImage imageNamed:@"question"];
    }
        
    return image;
}

- (IBAction)refreshButtonPressed:(id)sender {
    self.refreshButtonPressed = TRUE;
    
    [self getToolsForUser];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *refresh = [[NSUserDefaults standardUserDefaults] objectForKey:@"refresh_mytools"];
    
    if ([refresh isEqualToString:@"TRUE"]){
        [self getToolsForUser];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refresh_mytools"];
        
    } else
        [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"MyToolDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"MyToolDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary* powerTool = [self.userTools objectAtIndex:indexPath.row];
        
        MyToolDetailsViewController* detailViewController = segue.destinationViewController;
        detailViewController.toolDetails = powerTool;
        
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier isEqualToString:@"AddTool"]) {
        NSDictionary* userDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetails"];
        
        if (userDetails == nil) {
            [self showError:@"You need to login or register before you can add your tool"];
            
            return NO;
        }
    }
    
    return YES;
}

// This method is linked with unwind segue "BackToMyTools" in MyToolDetailsViewController
-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
    if ([segue.identifier isEqualToString:@"BackToMyTools"]) {
        
        MyToolDetailsViewController *myToolDetailsVC = segue.sourceViewController;
        
        if ([myToolDetailsVC.result isEqualToString:@"SUCCESS"]) {
            [self displayToastMessage:@"Tool deleted successfully"];
            [self getToolsForUser];
            
        } else {
            [self displayToastMessage:@"Tool cannot be deleted at this time, please try again later"];
        }
    }
}

- (void) displayToastMessage: (NSString *) message {
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    int duration = 2; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}

- (void)showError:(NSString*)errorMsg {
    NSString *msgTitle = @"Error Message";
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:msgTitle message:errorMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    
    [error show];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
