//
//  PublicToolDetailsViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/18/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "PublicToolDetailsViewController.h"

@interface PublicToolDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *toolNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *toolImageView;
@property (weak, nonatomic) IBOutlet UILabel *toolStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *toolMobileNoLabel;


@end

@implementation PublicToolDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self configureToolDetails];
}

- (void) configureToolDetails {
    self.toolNameLabel.text = [self.toolDetails valueForKey:@"toolname"];
    self.toolImageView.image = [self getImageFromTempDirWithName: [self.toolDetails valueForKey:@"toolimagename"]];
    
    self.toolMobileNoLabel.text = [self.toolDetails valueForKey:@"mobilenumber"];
        
    NSString *toolStatus = [self.toolDetails valueForKey:@"status"];

    if ([toolStatus isEqualToString:@"AVAILABLE"]) {
        self.toolStatusLabel.text = @"Available";
        self.toolStatusLabel.textColor = [UIColor blueColor];
        
        [self.view setBackgroundColor:[[UIColor alloc] initWithRed:1 green:1 blue:1 alpha:1]];
        
    } else {
        self.toolStatusLabel.text = @"Unavailable";
        self.toolStatusLabel.textColor = [UIColor redColor];
        
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
