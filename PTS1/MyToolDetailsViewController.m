//
//  MyToolDetailsViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/20/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "MyToolDetailsViewController.h"
#import "Communicator.h"
#import "MyToolsTableViewController.h"

@interface MyToolDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *toolNameTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *toolImageView;
@property (weak, nonatomic) IBOutlet UILabel *toolStatusTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeToolStatusButton;

@property Communicator *communicator;

@property NSString *removeToolHost;
@property NSString *updateToolStatusHost;

@end

@implementation MyToolDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.removeToolHost = @"http://10.0.0.6:8080/removeTool";
    self.updateToolStatusHost = @"http://10.0.0.6:8080/updateToolStatus";
    
    self.communicator = [Communicator new];
    
    self.toolNameTextLabel.text = [self.toolDetails valueForKey:@"toolname"];
    
    self.toolImageView.image = [self getImageFromTempDirWithName: [self.toolDetails valueForKey:@"toolimagename"]];
    
    [self updateStatusAndButtonText];
}

- (void) updateStatusAndButtonText {
    NSString *toolStatus = [self.toolDetails valueForKey:@"status"];
    
    if ([toolStatus isEqualToString:@"AVAILABLE"]) {
        self.toolStatusTextLabel.text = @"Available";
        self.toolStatusTextLabel.textColor = [UIColor blueColor];
        
        [self.changeToolStatusButton setTitle:@"Mark as Unavailable" forState:UIControlStateNormal];
        
        [self.view setBackgroundColor:[[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1]];
        
    } else {
        self.toolStatusTextLabel.text = @"Unavailable";
        self.toolStatusTextLabel.textColor = [UIColor redColor];
        
        [self.changeToolStatusButton setTitle:@"Mark as Available" forState:UIControlStateNormal];
        
        [self.view setBackgroundColor:[[UIColor alloc] initWithRed:1 green:0.8 blue:0.8 alpha:1]];
    }
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

- (IBAction) changeToolStatus:(id)sender {
    NSString *userId = [self.toolDetails valueForKey:@"userid"];
    NSString *toolId = [self.toolDetails valueForKey:@"id"];
    NSString *toolStatus = [self.toolDetails valueForKey:@"status"];
    
    if ([toolStatus isEqualToString:@"AVAILABLE"]) {
        toolStatus = @"UNAVAILABLE";
        
    } else {
        toolStatus = @"AVAILABLE";
    }
    
    NSDictionary *requestData = @{@"toolId":toolId, @"userId":userId, @"status":toolStatus};
    
    [self.communicator communicateData:requestData ForURL:self.updateToolStatusHost completion:^(NSDictionary *responseData){
        
        NSLog(@"Change Tool Status Response: %@", responseData);
        
        self.result = [responseData valueForKey:@"status"];
        
        self.toolDetails = [responseData valueForKey:@"powerTool"];
        
        [self performSelectorOnMainThread:@selector(updateScreenData) withObject:nil waitUntilDone:NO];
    }];
}

- (void) updateScreenData {
    NSString *toolStatus = [self.toolDetails valueForKey:@"status"];
    
    if ([toolStatus isEqualToString:@"AVAILABLE"]) {
        [self displayToastMessage:@"Tool marked as available"];
        
    } else{
        [self displayToastMessage:@"Tool marked as unavailable"];
    }
    
    [self updateStatusAndButtonText];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"TRUE" forKey:@"refresh_mytools"];
}

- (IBAction)deleteTool:(id)sender {
    NSString *userId = [self.toolDetails valueForKey:@"userid"];
    NSString *toolId = [self.toolDetails valueForKey:@"id"];
    
    NSDictionary *requestData = @{@"toolId":toolId, @"userId":userId};
    
    [self.communicator communicateData:requestData ForURL:self.removeToolHost completion:^(NSDictionary *responseData){
        
        NSLog(@"Delete Tool Response: %@", responseData);
        
        self.result = [responseData valueForKey:@"status"];
        
        [self performSelectorOnMainThread:@selector(updateTableViewData) withObject:nil waitUntilDone:NO];
    }];
}

- (void) updateTableViewData {
    [self performSegueWithIdentifier:@"BackToMyTools" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"BackToMyTools"]) {
        
        [self.navigationController dismissViewControllerAnimated:true completion:nil];
    }
}

- (void) displayToastMessage: (NSString *) message {
    UIAlertView *toast = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:nil, nil];
    [toast show];
    
    int duration = 1; // duration in seconds
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [toast dismissWithClickedButtonIndex:0 animated:YES];
    });
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
