//
//  MI6MapViewController.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MI6LocationToAddressDelegate.h"

@class Report;

@interface MI6MapViewController : UIViewController <MKMapViewDelegate, MI6LocationToAddressDelegate, MKAnnotation>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) Report* report;

@end
