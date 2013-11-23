//
//  MI6ReportsDataSource.m
//  Genetec.MI6
//
//  Created by MoAir on 11/23/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6ReportsDataSource.h"
#import "CoreDataHelper.h"
#import "EntityManager.h"
#import "Report.h"

@interface MI6ReportsDataSource ()

@end

@implementation MI6ReportsDataSource

-(id)init
{
    if(self = [super init])
    {
        [self update];
    }
    return self;
}

-(void)update
{
    self.arrayOfReportTitle = [[[CoreDataHelper instance] entityManager] getAllReports];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.arrayOfReportTitle count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%li", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString* report;
    
    Report* re=  (Report*)[self.arrayOfReportTitle objectAtIndex:indexPath.row];
    report = [re title];
    cell.textLabel.text = report;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}


@end
