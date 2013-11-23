//
//  MI6NotesDataSource.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6NotesDataSource.h"
#import "CoreDataHelper.h"
#import "Report.h"
#import "EntityManager.h"
#import "Media.h"

@interface MI6NotesDataSource ()

@property (strong, nonatomic) NSArray* notes;

@end

@implementation MI6NotesDataSource

@synthesize report;
@synthesize notes;


-(MI6NotesDataSource *)initWithReport:(Report *)report
{
    if(self = [super init])
    {
        notes = (report != nil) ? [[[CoreDataHelper instance] entityManager] getAllNotesForReport:report]
                : [[NSArray alloc] init];
        self.report = report;
    }
    return self;
}

- (void)update
{
    notes = [[[CoreDataHelper instance] entityManager] getAllNotesForReport:report];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [notes count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%li", (long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
    }
    
    Media* note = (Media*)[notes objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", note.timestamp];
    cell.detailTextLabel.text = note.text;
    return cell;
}

@end
