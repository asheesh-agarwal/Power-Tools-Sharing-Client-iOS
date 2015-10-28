//
//  RegisterViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 9/22/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "RegisterViewController.h"
#import "Communicator.h"
#import "SettingsUITableViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *emailId;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *confirmPassword;
@property NSString *host;

@property Communicator *communicator;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.host = @"http://ec2-54-173-239-217.compute-1.amazonaws.com:8080/registerUser";
    
    self.firstName.delegate = self;
    self.lastName.delegate = self;
    self.emailId.delegate = self;
    self.password.delegate = self;
    self.confirmPassword.delegate = self;
        
    self.communicator = [Communicator new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)joinButtonPressed:(id)sender {
    BOOL validationStatus = [self validateInput];
    
    if(validationStatus){
        [self registerUser];
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"RegisterToSettings" sender:self];
}


- (void)registerUser {
    NSDictionary *requestData = @{@"firstName":self.firstName.text, @"lastName":self.lastName.text, @"emailId":self.emailId.text, @"password":self.password.text, @"confirmPassword":self.confirmPassword.text};
        
    [self.communicator communicateData:requestData ForURL:self.host completion:^(NSDictionary *responseData){
            
        NSLog(@"Reg Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleRegistrationResponse:responseData];
            
        });
    }];
}

- (void) handleRegistrationResponse: (NSDictionary *) response {
    if([response count] > 0){
        
        NSDictionary* userDetails = @{@"userId":[response objectForKey:@"userId"]};
        
        [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"UserDetails"];
        
    } else {
        [self showError:@"Oops, we cannot connect to the server at this time, please try again"];
    }
    
    // Display success message and then take user to Settings page.
    
    [self performSegueWithIdentifier:@"RegisterToSettings" sender:self];
}

- (BOOL) validateInput {
    
    if(self.firstName.text == NULL || [self.firstName.text length] == 0){
        [self showError:@"Enter your first name"];
        
        return false;
        
    } else if ((self.lastName.text == NULL || [self.lastName.text length] == 0)){
        [self showError:@"Enter your last name"];
        
        return false;
        
    } else if (self.emailId.text == NULL || [self.emailId.text length] == 0){
        [self showError:@"Enter your email Id"];
        
        return false;
        
    } else if (self.password.text == NULL || [self.password.text length] == 0){
        [self showError:@"Choose a strong password"];
        
        return false;
        
    } else if ((self.confirmPassword.text == NULL || [self.confirmPassword.text length] == 0)){
        [self showError:@"Enter your password again"];
        
        return false;
        
    } else if (![self.password.text isEqualToString:self.confirmPassword.text]){
        [self showError:@"Both the passwords should be same"];
        
        return false;
    }
    
    return true;
}

- (void)showError:(NSString*)errorMsg {
    NSString *msgTitle = @"Error Message";
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:msgTitle message:errorMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    
    [error show];
}

#pragma mark - Navigation


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"RegisterToSettings"]){
        UITabBarController *tabBarCont = [segue destinationViewController];
        [tabBarCont setSelectedIndex:2];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.firstName) {
        [textField resignFirstResponder];
        [self.lastName becomeFirstResponder];
        
    } else if (textField == self.lastName) {
        [textField resignFirstResponder];
        [self.emailId becomeFirstResponder];
        
    } else if (textField == self.emailId) {
        [textField resignFirstResponder];
        [self.password becomeFirstResponder];
        
    } else if (textField == self.password) {
        [textField resignFirstResponder];
        [self.confirmPassword becomeFirstResponder];
        
    } else if (textField == self.confirmPassword) {
        [textField resignFirstResponder];
    }
    
    return YES;
}


@end
