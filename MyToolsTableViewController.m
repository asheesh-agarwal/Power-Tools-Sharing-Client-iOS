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

@end

@implementation MyToolsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.communicator = [Communicator new];
    
    [self getToolsForUser];
}

- (void) getToolsForUser {
    NSDictionary* userDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetails"];
    
    if(userDetails != nil && [userDetails count] > 0){
        NSString* userId = [userDetails objectForKey:@"userId"];

        NSDictionary *requestData = @{@"userId":userId};
        
        [self.communicator communicateData:requestData ForURL:@"http://localhost:8080/getTools" completion:^(NSDictionary *responseData){
            
            self.userTools = [responseData objectForKey:@"powerTools"];
            
            NSSortDescriptor *creationDateDescription = [[NSSortDescriptor alloc] initWithKey:@"creationdate" ascending:NO];
            
            NSArray *sortDescriptors = @[creationDateDescription];
            
            self.userTools = [self.userTools sortedArrayUsingDescriptors:sortDescriptors];
            
            [self.tableView reloadData];
        }];
    }
}


- (void)didReceiveMemoryWarning {
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
        
        cell.detailTextLabel.text = @"Available";
        cell.detailTextLabel.textColor = [UIColor blueColor];
        
        cell.imageView.image = [self getImageFromTempDirWithName: [powerTool valueForKey:@"toolimagename"]];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    // TODO based on the status of the tool, set the detailed text color to blue or red.
    
    return cell;
}

- (UIImage*) getImageFromTempDirWithName: (NSString* ) imageName {
    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:imageName] URLByAppendingPathExtension:@"jpg"];
    
    UIImage* image = [UIImage imageWithContentsOfFile:[fileURL path]];
        
    return image;
}

- (IBAction)refreshButtonPressed:(id)sender {
    [self getToolsForUser];
        
    //[self.tableView reloadData];
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
