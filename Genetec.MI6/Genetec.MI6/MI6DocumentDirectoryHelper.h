//
//  DMDocumentDirectoryHelper.h
//  DataMobile
//
//  Created by DataMobile on 13-07-22.
//  Copyright (c) 2013 MML-Concordia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MI6DocumentDirectoryHelper : NSObject

/**
 * Returns the URL to the application's Documents directory.
 */
+ (NSURL *)applicationDocumentsDirectory;

@end
