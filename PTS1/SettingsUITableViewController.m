//
//  SettingsUITableViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 9/22/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "SettingsUITableViewController.h"
#import "RegisterViewController.h"

@interface SettingsUITableViewController ()

@property NSMutableArray *menu;
@property NSDictionary *operationDict;

@end

@implementation SettingsUITableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.operationDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInt:1], @"Login",
                          [NSNumber numberWithInt:2], @"Register",
                          [NSNumber numberWithInt:3], @"Logout",
                          [NSNumber numberWithInt:4], @"FAQ",
                          [NSNumber numberWithInt:5], @"Help",
                          [NSNumber numberWithInt:6], @"Information", nil];
    
    NSDictionary *userDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetails"];
    
    if([userDetails objectForKey:@"userId"] != NULL){
        NSLog(@"UserId in DB: %@", [userDetails objectForKey:@"userId"]);
        
        self.menu = [[NSMutableArray alloc] initWithObjects:@"Logout", @"FAQ", @"Help", @"Information", nil];
    
    } else {
        NSLog(@"UserId not in DB");
        
        self.menu = [[NSMutableArray alloc] initWithObjects:@"Login", @"Register", @"FAQ", @"Help", @"Information", nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.menu count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Settings"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Settings"];
    }
    
    cell.textLabel.text = [self.menu objectAtIndex:indexPath.row];
    
    [self setCellImage: cell forCellAtIndex: indexPath.row];
    
    return cell;
}

- (void) setCellImage: (UITableViewCell *) cell forCellAtIndex: (NSInteger) rowIndex {
    
    NSNumber *operationNumber = [self.operationDict valueForKey:[self.menu objectAtIndex:rowIndex]];
    
    switch ([operationNumber intValue]) {
        case 1:{
            cell.imageView.image = [UIImage imageNamed:@"login.png"];
            
            break;
        }
            
        case 2:{
            cell.imageView.image = [UIImage imageNamed:@"register.png"];
            
            break;
        }
            
        case 3:{
            cell.imageView.image = [UIImage imageNamed:@"logout.png"];
         
            break;
        }
            
        case 4:{
            cell.imageView.image = [UIImage imageNamed:@"faq.png"];
            
            break;
        }
            
        case 5:{
            cell.imageView.image = [UIImage imageNamed:@"help.png"];
            
            break;
        }
            
        case 6:{
            cell.imageView.image = [UIImage imageNamed:@"information.png"];
            
            break;
        }
            
        default:
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionName;
    
    switch (section){
            
        case 0:
            sectionName = @"Settings";
            break;
            
        default:
            sectionName = @"";
            break;
    }
    
    return sectionName;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        
    NSNumber *operationNumber = [self.operationDict valueForKey:[self.menu objectAtIndex:indexPath.row]];
    
    switch ([operationNumber intValue]) {
        case 1:{
            [self performSegueWithIdentifier:@"Login" sender:self];
            
            break;
        }
            
        case 2:{
            [self performSegueWithIdentifier:@"Register" sender:self];
            
            break;
        }
                        
        case 3:{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserDetails"];
            
            [self viewDidLoad];
            [self.tableView reloadData];
            
            break;
        }
            
        case 4:{
            
            
            break;
        }
            
        case 5:{
            
            
            break;
        }
            
        case 6:{
            
            
            break;
        }
            
        default:
            break;
    }
}

- (void) setRegistrationResponse: (NSDictionary *) registrationResponse {
    NSLog(@"Registration Response: %@", registrationResponse);
    
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



#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"Servers"
                                   style:UIBarButtonItemStylePlain
                                   target:self
                                   action:NULL];
    
    UINavigationController *nc = [segue destinationViewController];
    nc.navigationItem.backBarButtonItem = backButton;
    nc.title = @"Register";
}
*/

@end
