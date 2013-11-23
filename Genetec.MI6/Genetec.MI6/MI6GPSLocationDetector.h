//
//  MI6GPSLocationDetector.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MI6GPSLocationDetectorDelegate.h"

@class Media, Report;

@interface MI6GPSLocationDetector : NSObject <CLLocationManagerDelegate>

@property (strong, nonatomic) Media* media;
@property (strong, nonatomic) Report* report;

@property (weak, nonatomic) id<MI6GPSLocationDetectorDelegate> delegate;

-(void)startFetchingCurrentLocation;

@end
