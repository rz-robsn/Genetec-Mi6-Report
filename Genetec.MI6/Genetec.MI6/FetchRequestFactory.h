//
//  FetchRequestFactory.h
//  DataMobile
//
//  Created by DataMobile on 13-07-15.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Report;

/**
 * The role of this class is to create custom NSFetchRequest objects
 * to be used to manage the entities specifed in the DataMobile Core Data Model
 */
@interface FetchRequestFactory : NSObject

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)moc;

/**
 Returns the fetch request to use to get all Objects instances of type *entityName*.
 
 @param entityName the Entity Name
 @returns the fetch request object
 */
- (NSFetchRequest*)getAllObjectsFetchRequest:(NSString *)entityName;

- (NSFetchRequest*)getAllNotesFetchRequestForReport:(Report*)report;


@end
