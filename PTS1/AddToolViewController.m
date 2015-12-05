//
//  AddToolViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/18/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "AddToolViewController.h"
#import "Communicator.h"

@import MobileCoreServices;

@interface AddToolViewController ()
@property Communicator* communicator;
@property (weak, nonatomic) IBOutlet UIImageView *toolImageView;
@property (weak, nonatomic) IBOutlet UITextField *toolNameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *donebarButton;
@property CLLocationManager *locationManager;

@property NSString *userId;
@property UIImage *scaledImage;
@property NSString *imageName;
@property NSString *latitude;
@property NSString *longitude;

@property NSString *host;

@end

@implementation AddToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //self.host = @"http://ec2-54-209-176-62.compute-1.amazonaws.com:8080/addTool";
    self.host = @"http://10.0.0.4:8080/addTool";
    
    self.toolNameTextField.delegate = self;
    
    self.communicator = [Communicator new];
    
    [self addGestureToImage];
    
    [self burnTextIntoImage:@"Tap to Add Image" :_toolImageView.image];
    
    NSDictionary* userDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetails"];
    
    if(userDetails != nil && [userDetails count] > 0){
        self.userId = [userDetails objectForKey:@"userId"];
    }
    
    // Initialize Location Manager
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.distanceFilter = kCLDistanceFilterNone;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager requestWhenInUseAuthorization];
    
    _locationManager.delegate = self;
}

- (void) addGestureToImage {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped)];
    
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    
    [self.toolImageView addGestureRecognizer:tap];
}

- (void) imageTapped {
    UIActionSheet *uiActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    
    [uiActionSheet showInView:self.view];
}

- (void) burnTextIntoImage:(NSString *)text :(UIImage *)img {
    
    UIGraphicsBeginImageContext(img.size);
    
    CGRect imageRect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGRect textRect = CGRectMake(0, img.size.height/2, img.size.width, img.size.height);
    
    [img drawInRect:imageRect];
    
    [[UIColor redColor] set];           // set text color
    
    UIFont *font = [UIFont systemFontOfSize:20];     // set text font

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName, paragraphStyle, NSParagraphStyleAttributeName, [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [text drawInRect:textRect withAttributes:dictionary];       // render the text
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();   // extract the image
    
    UIGraphicsEndImageContext();     // clean  up the context.
    
    _toolImageView.image = theImage;
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            [self enableDoneBarButton];
            [self takePhoto];
            
            break;
        }
            
        case 1:{
            [self enableDoneBarButton];
            [self choosePhoto];
            
            break;
        }
    }
}

- (void) takePhoto {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
#endif
    
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void) choosePhoto {
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
#if TARGET_IPHONE_SIMULATOR
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#endif
    
    imagePickerController.editing = YES;
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

#pragma mark - Image picker delegate method
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.scaledImage = [self scaleImage:image toSize: CGSizeMake(_toolImageView.frame.size.width, _toolImageView.frame.size.height)];
    
    _toolImageView.image = self.scaledImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    self.imageName = [self getImageName];
    
    [self storeImage:self.scaledImage InTempDirWithName:self.imageName];
    
    // Scroll the screen to make text field automatically visible.
    UIScrollView *scrollView = (UIScrollView*)self.view;
    [scrollView setContentOffset:CGPointMake(0, 200) animated:YES];
    
    // Move the pointer to the text field
    [self.toolNameTextField becomeFirstResponder];
}

- (void) storeImage:(UIImage*) image InTempDirWithName: (NSString* ) imageName {
    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:imageName] URLByAppendingPathExtension:@"jpg"];
    
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];
    [imageData writeToURL:fileURL atomically:YES];
}

- (NSString*) getImageName {
    NSString *imageName = [NSString stringWithFormat:@"%s%d", "Image-", [self generateRandomNumberWithlowerBound:0 upperBound:1000000]];

    return imageName;
}

- (int) generateRandomNumberWithlowerBound:(int) lowerBound upperBound:(int) upperBound {
    int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
    
    return rndValue;
}

- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize {
    //If scaleFactor is not touched, no scaling will occur
    CGFloat scaleFactor = 1.0;
    
    //Deciding which factor to use to scale the image (factor = targetSize / imageSize)
    if (image.size.width > targetSize.width || image.size.height > targetSize.height)
        if (!((scaleFactor = (targetSize.width / image.size.width)) > (targetSize.height / image.size.height))) //scale to fit width, or
            scaleFactor = targetSize.height / image.size.height; // scale to fit heigth.
    
    UIGraphicsBeginImageContext(targetSize);
    
    //Creating the rect where the scaled image is drawn in
    CGRect rect = CGRectMake((targetSize.width - image.size.width * scaleFactor) / 2,
                             (targetSize.height -  image.size.height * scaleFactor) / 2,
                             image.size.width * scaleFactor, image.size.height * scaleFactor);
    
    //Draw the image into the rect
    [image drawInRect:rect];
    
    //Saving the image, ending image context
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

#pragma mark - Image picker delegate method
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self disableDoneBarButton];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) enableDoneBarButton {
    [self.donebarButton setEnabled:TRUE];
}

- (void) disableDoneBarButton {
    [self.donebarButton setEnabled:FALSE];
}

- (IBAction) doneButtonpressed:(id)sender {
    if ([self.toolNameTextField.text length] == 0) {
        [self showError:@"Enter tool name and then tap Done"];
        
    } else{
        [self uploadToolOnServer];
        
        [[NSUserDefaults standardUserDefaults] setObject:@"TRUE" forKey:@"refresh_mytools"];
        
        [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void) uploadToolOnServer {
    
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(self.scaledImage, 1.0f)];
    
    NSDictionary *requestData = @{@"userId":self.userId, @"toolImageName":self.imageName, @"name":self.toolNameTextField.text, @"latitude":self.latitude, @"longitude":self.longitude};
    
    [self.communicator communicateData:requestData ForURL:self.host completion:^(NSDictionary *responseData){
        
        NSLog(@"Add Tool Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleAddToolResponse:responseData];
            
        });
    }];
}

- (void) handleAddToolResponse: (NSDictionary *) response {
    if([response count] > 0){
        
        NSString *status = [response objectForKey:@"status"];
        
        if ([status isEqualToString:@"SUCCESS"]) {
            [self displayToastMessage:@"Tool added successfully"];
            
        } else {
            NSString *errorMessage = [response objectForKey:@"errorMessage"];
            
            [self showError:errorMessage];
        }
    } else {
        [self showError:@"Oops, we cannot connect to the server at this time, please try again"];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)showError:(NSString*)errorMsg {
    NSString *msgTitle = @"Error Message";
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:msgTitle message:errorMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    
    [error show];
}

#pragma mark - CLLocationManagerDelegate

// LocationManager delegate method which will be called if location services are disabled
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location services not authorized"
                                                    message:@"This app needs you to authorize locations services to work."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Settings", nil];
    
    [alert show];
}

// LocationManager delegate method which will be called whenever the location is updated
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        _longitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        _latitude = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        NSLog(@"latitude: %@", _latitude);
        NSLog(@"longitude: %@", _longitude);
        
        [_locationManager stopUpdatingLocation];
    }
}

// LocationManager delegate method which will be called when the location service status is changed by user either by accepting or declining
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [_locationManager startUpdatingLocation];
        
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
        
    } else if (status == kCLAuthorizationStatusDenied) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location services not authorized"
                                                        message:@"This app needs you to authorize locations services to work."
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Settings", nil];
        
        [alert show];
    } else
        NSLog(@"Wrong location status");
}

// Method which is invoked whenever user makes a selection on a alert
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        
    } else if(buttonIndex == 1) {
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: UIApplicationOpenSettingsURLString]];
    }
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
