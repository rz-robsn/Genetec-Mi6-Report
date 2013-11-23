//
//  EntityManager.h
//  DataMobile
//
//  Created by DataMobile on 13-07-15.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Report;

/**
 * This class manages Entities specfied in the DataMobile Core Data Model file.
 */
@interface EntityManager : NSObject

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)moc;

- (void)saveContext;

- (void)deleteAllObjects:(NSString *)entityName;

- (NSArray*)getAllReports;
- (NSArray*)getAllNotesForReport:(Report*)report;

@end
