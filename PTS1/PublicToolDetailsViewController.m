//
//  PublicToolDetailsViewController.m
//  PTS1
//
//  Created by Asheesh Agarwal on 10/18/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import "PublicToolDetailsViewController.h"

@interface PublicToolDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *toolName;
@property (weak, nonatomic) IBOutlet UILabel *toolStatus;
@property (weak, nonatomic) IBOutlet UILabel *toolAddDate;

@end

@implementation PublicToolDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
