//
//  MI6GPSLocationDetectorDelegate.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MI6GPSLocationDetector;

@protocol MI6GPSLocationDetectorDelegate <NSObject>

-(void)LocationDetector:(MI6GPSLocationDetector*)locationDetector
 didFindCurrentLocation:(CLLocation*)location;

-(void)LocationDetector:(MI6GPSLocationDetector*)locationDetector
didFailToFindCurrentLocationWithError:(NSError*)error;

@end
