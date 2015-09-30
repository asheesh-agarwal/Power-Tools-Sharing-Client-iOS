//
//  LoginViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 9/23/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "LoginViewController.h"
#import "Communicator.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property Communicator *communicator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.communicator = [Communicator new];
}

- (IBAction)loginButtonPressed:(id)sender {
    BOOL validationStatus = [self validateInput];
    
    if(validationStatus){
        [self loginUser];
    }
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"LoginToSettings" sender:self];
}

- (BOOL) validateInput {
    
    if (self.emailIdTextField.text == NULL || [self.emailIdTextField.text length] == 0){
        [self showError:@"Enter your email Id which you provided during registration"];
        
        return false;
        
    } else if (self.passwordTextField.text == NULL || [self.passwordTextField.text length] == 0){
        [self showError:@"Enter your password which you provided during registration"];
        
        return false;
        
    } 
    
    return true;
}

- (void)showError:(NSString*)errorMsg {
    NSString *msgTitle = @"Error Message";
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:msgTitle message:errorMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    
    [error show];
}

- (void) loginUser {
    NSDictionary *requestData = @{@"emailId":self.emailIdTextField.text, @"password":self.passwordTextField.text};
    
    [self.communicator communicateData:requestData ForURL:@"http://10.128.2.245:8080/loginUser" completion:^(NSDictionary *responseData){
        
        NSLog(@"Login Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleLoginResponse:responseData];
            
        });
    }];
}

- (void) handleLoginResponse: (NSDictionary *) response {
    if([response count] > 0){
        [[NSUserDefaults standardUserDefaults] setObject:response forKey:@"UserDetails"];
    }
    
    // Display success message and then take user to Settings page.
    
    [self performSegueWithIdentifier:@"LoginToSettings" sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([[segue identifier] isEqualToString:@"LoginToSettings"]){
        UITabBarController *tabBarCont = [segue destinationViewController];
        [tabBarCont setSelectedIndex:2];
    }
}


@end
