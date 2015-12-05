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
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *mobileNumberButton;
@property MKPointAnnotation *toolAnnotation;

@end

@implementation PublicToolDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _mapView.showsUserLocation = TRUE;
    _mapView.delegate = self;
    
    _toolAnnotation = [[MKPointAnnotation alloc] init];
    
    [self configureToolDetails];
}

- (IBAction)mobileNumberButtonPressed:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt://" stringByAppendingString:[self.toolDetails valueForKey:@"mobilenumber"]]]];
}

- (void) configureToolDetails {
    self.toolNameLabel.text = [self.toolDetails valueForKey:@"toolname"];
    self.toolImageView.image = [self getImageFromTempDirWithName: [self.toolDetails valueForKey:@"toolimagename"]];
    
    [self.mobileNumberButton setTitle:[self.toolDetails valueForKey:@"mobilenumber"] forState:UIControlStateNormal];
    
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
    
    double latitude = [[self.toolDetails valueForKey:@"latitude"] doubleValue];
    double longitude = [[self.toolDetails valueForKey:@"longitude"] doubleValue];
    
    // Centering map around the tool location coordinates
    CLLocation *toolLocation = [[CLLocation new] initWithLatitude:latitude longitude:longitude];
    [self centerMapOnLocation:toolLocation];

    // Setting up the annotation properties
    CLLocationCoordinate2D pinCoordinate = CLLocationCoordinate2DMake(latitude, longitude);
    _toolAnnotation.coordinate = pinCoordinate;
    _toolAnnotation.title = [[@"Tool \"" stringByAppendingString:self.toolNameLabel.text] stringByAppendingString:@"\""];
    
    [_mapView addAnnotation:_toolAnnotation];
    
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

- (void) centerMapOnLocation: (CLLocation*) location {
    CLLocationDistance regionRadius = 1000;
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0);
    
    [_mapView setRegion:coordinateRegion animated:YES];
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"%@", @"Region changed");
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    NSLog(@"%@", @"user location changed");
    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation
{
    // If the annotation is the user location, just return nil.
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    // Handle any custom annotations.
    if ([annotation isKindOfClass:[MKPointAnnotation class]])
    {
        // Try to dequeue an existing pin view first.
        MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MKPinAnnotationView"];
        
        if (!pinView) {
            // If an existing pin view was not available, create one.
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
                                                      reuseIdentifier:@"MKPinAnnotationView"];
            pinView.pinColor = MKPinAnnotationColorRed;
            pinView.animatesDrop = YES;
            pinView.canShowCallout = YES;
            
            // If appropriate, customize the callout by adding accessory views (code not shown).
        } else
            pinView.annotation = annotation;
        
        return pinView;
    }
    
    return nil;
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
