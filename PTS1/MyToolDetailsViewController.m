//
//  MyToolDetailsViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/20/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "MyToolDetailsViewController.h"

@interface MyToolDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *toolNameTextLabel;
@property (weak, nonatomic) IBOutlet UIImageView *toolImageView;
@property (weak, nonatomic) IBOutlet UILabel *toolStatusTextLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeToolStatusButton;

@end

@implementation MyToolDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toolNameTextLabel.text = [self.toolDetails valueForKey:@"toolname"];
    
    NSString* toolStatus = @"Available";
    self.toolStatusTextLabel.text = toolStatus;
    self.toolStatusTextLabel.textColor = [UIColor blueColor];
    
    self.toolImageView.image = [self getImageFromTempDirWithName: [self.toolDetails valueForKey:@"toolimagename"]];
    
    if([toolStatus isEqualToString:@"Available"])
        [self.changeToolStatusButton setTitle:@"Mark as Unavailable" forState:UIControlStateNormal];
    else
        [self.changeToolStatusButton setTitle:@"Mark as Available" forState:UIControlStateNormal];
}

- (UIImage*) getImageFromTempDirWithName: (NSString* ) imageName {
    NSURL *tmpDirURL = [NSURL fileURLWithPath:NSTemporaryDirectory() isDirectory:YES];
    NSURL *fileURL = [[tmpDirURL URLByAppendingPathComponent:imageName] URLByAppendingPathExtension:@"jpg"];
    
    UIImage* image = [UIImage imageWithContentsOfFile:[fileURL path]];
        
    return image;
}

- (IBAction)changeToolStatus:(id)sender {
}

- (IBAction)deleteTool:(id)sender {
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
