//
//  MI6NotesDataSource.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Report;

@interface MI6NotesDataSource : NSObject <UITableViewDataSource>

@property (strong, nonatomic) Report* report;
@property (strong, nonatomic) NSArray* notes;

- (MI6NotesDataSource*)initWithReport:(Report*)report;

- (void)update;

@end
