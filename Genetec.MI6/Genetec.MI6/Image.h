//
//  Image.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Coordinate, Report;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSString * drawing_url;
@property (nonatomic, retain) NSString * img_url;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) Coordinate *coordinate;
@property (nonatomic, retain) Report *report;

@end
