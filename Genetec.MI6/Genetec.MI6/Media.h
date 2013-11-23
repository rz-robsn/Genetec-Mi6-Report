//
//  Media.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#ifndef MEDIA_TYPE_AUDIO
#define MEDIA_TYPE_AUDIO 0
#endif

#ifndef MEDIA_TYPE_VIDEO
#define MEDIA_TYPE_VIDEO 1
#endif

#ifndef MEDIA_TYPE_IMAGE
#define MEDIA_TYPE_IMAGE 2
#endif

#ifndef MEDIA_TYPE_NOTE
#define MEDIA_TYPE_NOTE 3
#endif

@class Report;

@interface Media : NSManagedObject

@property (nonatomic, retain) NSString * drawing_data;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * timestamp;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) Report *report;

@end
