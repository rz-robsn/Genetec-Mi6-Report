//
//  DMDocumentDirectoryHelper.m
//  DataMobile
//
//  Created by DataMobile on 13-07-22.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import "MI6DocumentDirectoryHelper.h"

@implementation MI6DocumentDirectoryHelper

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
