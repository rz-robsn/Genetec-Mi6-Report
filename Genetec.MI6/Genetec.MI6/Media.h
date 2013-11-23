//
//  Media.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Report;

@interface Media : NSManagedObject

@property (nonatomic, retain) NSString * drawing_url;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) Report *report;

@end
