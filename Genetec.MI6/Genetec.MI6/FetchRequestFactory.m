//
//  FetchRequestFactory.m
//  DataMobile
//
//  Created by DataMobile on 13-07-15.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import "FetchRequestFactory.h"
#import "Report.h"

@interface FetchRequestFactory()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation FetchRequestFactory

- (id)initWithManagedObjectContext:(NSManagedObjectContext*)moc
{
    if(self = [super init])
    {
        self.managedObjectContext = moc;
    }
    return self;
}


- (NSFetchRequest*)getAllObjectsFetchRequest:(NSString *)entityName
{
    NSEntityDescription *eDescription = [NSEntityDescription entityForName:entityName
                                                    inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    request.entity = eDescription;
    return request;
}

- (NSFetchRequest*)getAllNotesFetchRequestForReport:(Report*)report
{
    NSFetchRequest* request = [self getAllObjectsFetchRequest:@"Media"];
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"self.report == %@", report];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp"
                                                                   ascending:YES];
    [request setPredicate:predicate];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    return request;
}

@end
