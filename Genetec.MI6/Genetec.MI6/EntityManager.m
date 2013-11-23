//
//  EntityManager.m
//  DataMobile
//
//  Created by DataMobile on 13-07-15.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import "EntityManager.h"
#import "FetchRequestFactory.h"
#import "Report.h"

@interface EntityManager()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) FetchRequestFactory *fetchRequestFactory;

/**
 * Fetches the passed request, ignoring the error.
 */
- (NSArray*)fetchRequest:(NSFetchRequest*)request;

@end

@implementation EntityManager

@synthesize managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)moc
{
    if(self = [super init])
    {
        self.managedObjectContext = moc;
        self.fetchRequestFactory = [[FetchRequestFactory alloc] initWithManagedObjectContext:moc];
    }
    return self;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc != nil)
    {
        if ([moc hasChanges] && ![moc save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             */
            
            
            NSLog(@"%@", [[NSThread callStackSymbols] description]);
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)deleteAllObjects: (NSString*)entityName
{
    NSFetchRequest *fetchRequest = [self.fetchRequestFactory getAllObjectsFetchRequest:entityName];

    NSArray *items = [self fetchRequest:fetchRequest];
    
    for (NSManagedObject *managedObject in items)
    {
        [self.managedObjectContext deleteObject:managedObject];
        // object deleted
    }
    [self saveContext];
}

- (NSArray*)fetchRequest:(NSFetchRequest*)request
{
    NSError *error;
    return  [self.managedObjectContext executeFetchRequest:request
                                                     error:&error];
}

- (NSArray*)getAllReports
{
    NSError* error;
     return [self.managedObjectContext executeFetchRequest:[self.fetchRequestFactory getAllObjectsFetchRequest:@"Report"] error:&error];

    
}

- (NSArray*)getAllNotesForReport:(Report*)report
{
    NSFetchRequest* fetchRequest = [self.fetchRequestFactory getAllNotesFetchRequestForReport:report];
    return [self fetchRequest:fetchRequest];
}

- (Media*)createNewMedia
{
    return (Media*) [NSEntityDescription insertNewObjectForEntityForName:@"Media"
                                                  inManagedObjectContext:managedObjectContext];
}

- (Report*)createNewReport
{
    Report* report = (Report*)[NSEntityDescription insertNewObjectForEntityForName:@"Report"
                                                            inManagedObjectContext:managedObjectContext];
    report.createdAt = [NSDate dateWithTimeIntervalSinceNow:0];
    report.updatedAt = [NSDate dateWithTimeIntervalSinceNow:0];
    return report;
}


@end
