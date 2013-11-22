//
//  CoreDataHelper.h
//  DataMobile
//
//  Created by Zachary Patterson on 3/19/12.
//  Copyright (c) 2012 MML-Concordia. All rights reserved.
//


#import <Foundation/Foundation.h>

@class EntityManager;

/**
 * Wrapper around the CoreData-related classes.
 */
@interface CoreDataHelper : NSObject

@property (strong, nonatomic) NSURL* storeURL;
@property (strong, nonatomic) EntityManager* entityManager;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataHelper*)instance;

/**
 *  Resets the Context
 */
- (void)resetContext;

@end
