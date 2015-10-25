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

@property NSString* userId;
@property UIImage* scaledImage;
@property NSString* imageName;

@property NSString *host;

@end

@implementation AddToolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.host = @"http://10.0.0.6:8080/addTool";
    
    self.toolNameTextField.delegate = self;
    
    self.communicator = [Communicator new];
    
    [self addGestureToImage];
    
    [self burnTextIntoImage:@"Tap to Add Image" :_toolImageView.image];
    
    NSDictionary* userDetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserDetails"];
    
    if(userDetails != nil && [userDetails count] > 0){
        self.userId = [userDetails objectForKey:@"userId"];
        
    }
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
}

- (void) storeImage:(UIImage*) image InTempDirWithName: (NSString* ) imageName {
    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:imageName] URLByAppendingPathExtension:@"jpg"];
    
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(image, 1.0f)];
    [imageData writeToURL:fileURL atomically:YES];
}

- (NSString*) getImageName {
    NSString *imageName = [NSString stringWithFormat:@"%s%d", "Image_", [self generateRandomNumberWithlowerBound:0 upperBound:1000000]];

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

- (void)showError:(NSString*)errorMsg {
    NSString *msgTitle = @"Error Message";
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:msgTitle message:errorMsg delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil, nil];
    
    [error show];
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
    
    NSDictionary *requestData = @{@"userId":self.userId, @"toolImageName":self.imageName, @"name":self.toolNameTextField.text};
    
    [self.communicator communicateData:requestData ForURL:self.host completion:^(NSDictionary *responseData){
        
        NSLog(@"Add Tool Response: %@", responseData);
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self handleAddToolResponse:responseData];
            
        });
    }];
}

- (void) handleAddToolResponse: (NSDictionary *) response {
    if([response count] > 0){
        // Show toast message
    }
    
    //[self getToolsForUser: self.userId];
    
    //[self.tableView reloadData];
    // Display success message and then take user to My Tools page.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
