//
//  FetchRequestFactory.m
//  DataMobile
//
//  Created by DataMobile on 13-07-15.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import "FetchRequestFactory.h"

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

@end
