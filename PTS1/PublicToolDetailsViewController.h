//
//  PublicToolDetailsViewController.h
//  PTS1
//
//  Created by Asheesh Agarwal on 10/18/15.
//  Copyright © 2015 Asheesh Agarwal. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface PublicToolDetailsViewController : UIViewController <MKMapViewDelegate>

@property NSDictionary* toolDetails;

@end
