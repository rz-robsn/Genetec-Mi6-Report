//
//  Media.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "Media.h"
#import "Report.h"


@implementation Media

@dynamic drawing_data;
@dynamic latitude;
@dynamic longitude;
@dynamic text;
@dynamic timestamp;
@dynamic type;
@dynamic data;
@dynamic report;

# pragma mark - MKAnnotation

- (CLLocationCoordinate2D)coordinate
{
    return CLLocationCoordinate2DMake([self.latitude doubleValue], [self.longitude doubleValue]);
}

- (NSString *)title {
	return [self.timestamp description];
}

- (NSString *)subtitle {
	return ([self.type intValue] == MEDIA_TYPE_VIDEO) ? @"" : self.text;
}


@end
