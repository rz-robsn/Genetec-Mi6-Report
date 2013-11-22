//
//  Report.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Audio, Image, Note, Video;

@interface Report : NSManagedObject

@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedAt;
@property (nonatomic, retain) Audio *audios;
@property (nonatomic, retain) Video *videos;
@property (nonatomic, retain) Image *images;
@property (nonatomic, retain) Note *notes;

@end
