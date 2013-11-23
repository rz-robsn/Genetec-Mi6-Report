//
//  MI6GPSLocationDetector.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6GPSLocationDetector.h"

@interface MI6GPSLocationDetector ()

@property (strong, nonatomic) CLLocationManager* manager;
@property (strong, nonatomic) CLLocation* latestLocation;
@property (strong, nonatomic) NSTimer* timer;


@end

@implementation MI6GPSLocationDetector

@synthesize manager;
@synthesize delegate;
@synthesize timer;
@synthesize media;

-(id)init
{
    if(self = [super init])
    {
        manager = [[CLLocationManager alloc] init];
    }
    return self;
}

-(void)startFetchingCurrentLocation
{
    manager.distanceFilter = kCLDistanceFilterNone;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    manager.delegate = self;
    
    [manager startUpdatingLocation];
    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer timerWithTimeInterval:20
                                    target:self
                                  selector:@selector(timerCallback)
                                  userInfo:nil
                                   repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

-(void)timerCallback
{
    if (_latestLocation == nil)
    {
        [self.delegate LocationDetector:self didFailToFindCurrentLocationWithError:nil];
    }
    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    [self.manager stopUpdatingLocation];
}

# pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _latestLocation = [locations objectAtIndex:[locations count]-1];
    [self.delegate LocationDetector:self didFindCurrentLocation:_latestLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [self.delegate LocationDetector:self didFailToFindCurrentLocationWithError:error];
}

@end
