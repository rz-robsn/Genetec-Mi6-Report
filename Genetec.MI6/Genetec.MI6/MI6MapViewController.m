//
//  MI6MapViewController.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6MapViewController.h"
#import "Media.h"
#import "Report.h"

@interface MI6MapViewController ()

@end

@implementation MI6MapViewController

@synthesize report;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    for (Media* media in report.medias)
    {
        if(media.latitude != nil && [media.latitude intValue] != 0
           && media.longitude != nil && [media.longitude intValue] != 0)
        {
            [self.mapView addAnnotation:media];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	
    if (annotation == mapView.userLocation)
    {
        //returning nil means 'use built in location view'
		return nil;
	}
    
    MKAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Some"];
    
    if (annotationView == nil)
    {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Some"];
    }
    
    
    annotationView.annotation = annotation;
    annotationView.canShowCallout = YES;
    
    return annotationView;
    
    
}


@end
