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
    Media* media = (Media*)[notes objectAtIndex:indexPath.row];
    
    if (cell == nil)
    {
        switch ([media.type intValue]) {
                
            case MEDIA_TYPE_NOTE:
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle  reuseIdentifier:CellIdentifier];
                break;
            }
                
            case MEDIA_TYPE_IMAGE:
            {    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
            }    break;
                
            case MEDIA_TYPE_AUDIO:
            {
            
            }
                break;
                
            case MEDIA_TYPE_VIDEO:
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:CellIdentifier];
            }
                break;
            default:
                break;
        }
    }
    
    switch ([media.type intValue]) {
            
        case MEDIA_TYPE_NOTE:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@", media.timestamp];
            cell.detailTextLabel.text = media.text;
        }   break;

        case MEDIA_TYPE_IMAGE:
        {   UIImage* image = [UIImage imageWithData:media.data];
            cell.imageView.image = image;
            cell.textLabel.text = [NSString stringWithFormat:@"%@", media.timestamp];
        }   break;
            
        case MEDIA_TYPE_AUDIO:
        {
        
        }
            break;
            
        case MEDIA_TYPE_VIDEO:
        {   UIImage* image = [UIImage imageWithData:media.data];
            cell.imageView.image = image;
            cell.textLabel.text = [NSString stringWithFormat:@"%@", media.timestamp];
        }   break;
            
        default:
            break;
    }
    return cell;
}

@end
