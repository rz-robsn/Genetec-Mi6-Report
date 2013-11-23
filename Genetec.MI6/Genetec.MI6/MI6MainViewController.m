//
//  MI6MainViewController.m
//  Genetec.MI6
//
//  Created by MoAir on 11/22/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6MainViewController.h"
#import "MI6SingleReportViewController.h"
#import "EntityManager.h"
#import "Report.h"
#import "CoreDataHelper.h"
#import "MI6ReportsDataSource.h"
#import "MI6Image.h"
#import "Media.h"
#import "MI6GPSLocationDetector.h"

@interface MI6MainViewController ()

@property (strong,nonatomic) NSDate* date;
@property (strong,nonatomic) NSMutableArray* filteredArray;
@property (strong,nonatomic) MI6ReportsDataSource* datasource;
@property (strong, nonatomic) MI6GPSLocationDetector* detector;


@end

@implementation MI6MainViewController

Report* reportWithImage;
@synthesize filteredArray;
@synthesize datasource;
@synthesize detector;

int sendByActionSheet; // when press new note set this to 1;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSDateFormatter *inFormat = [[NSDateFormatter alloc] init];
    [inFormat setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDate *now = [[NSDate alloc] init];
    
    NSString *dateString = [inFormat stringFromDate:now];
    
    NSDate *parsed = [inFormat dateFromString:dateString];
    
    datasource = [[MI6ReportsDataSource alloc] init];
    self.tableView.dataSource = datasource;
    
    self.detector = [[MI6GPSLocationDetector alloc] init];
    self.detector.delegate = self;
    
    
    self.searchBar.delegate = self;
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.datasource.arrayOfReportTitle count]];
    
    UIBarButtonItem *changeCategory = [[UIBarButtonItem alloc] initWithTitle:@"Map"
                                                                       style:UIBarButtonItemStyleBordered
                                                                      target:self
                                                                      action:@selector(mapBarButtonItemTapped:)];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [datasource update];
    [self.tableView reloadData];
}

-(void)mapBarButtonItemTapped
{

}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}
- (IBAction)addReport:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"New Report", @"Take Photo", nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"New Report" ]) {
        sendByActionSheet = 1;
        [self performSegueWithIdentifier:@"SingleReportSegue" sender:self];
        
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo" ]) {
        [[ [MI6Image alloc] init ] startCameraControllerFromViewController:self usingDelegate:self];
    }
}

//// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *imageL = [info objectForKey:UIImagePickerControllerOriginalImage];
    
 
    [self dismissViewControllerAnimated:YES completion:nil];
    // Request to save the image to camera roll
  //  NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(imageL)];
    
    
    // Transform the image to NSData
    NSData *savedImageData = UIImagePNGRepresentation(imageL);
    reportWithImage = [[[CoreDataHelper instance] entityManager] createNewReport];
    Media* media = [[[CoreDataHelper instance] entityManager] createNewMedia];
    media.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
    media.data = savedImageData;
    media.type = [NSNumber numberWithInt:MEDIA_TYPE_IMAGE];
    [reportWithImage addMedias:[NSSet setWithObject:media]];
    
    detector.media = media;
    detector.report = reportWithImage;
    [detector startFetchingCurrentLocation];
    sendByActionSheet = 1;
    [self performSegueWithIdentifier:@"SingleReportSegue" sender:self];
    
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [filteredArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString* report;
    
    report = [filteredArray objectAtIndex:indexPath.row];
    cell.textLabel.text = report;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"SingleReportSegue" sender:self];
}



#pragma mark Content Filtering


-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredArray removeAllObjects];
    
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self.title contains[c] %@",searchText];
    NSArray* filteredReports = [NSMutableArray arrayWithArray:[self.datasource.arrayOfReportTitle filteredArrayUsingPredicate:predicate]];
    
    for (Report* report in filteredReports) {
        [filteredArray addObject:report.title];
    }
}


#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {

    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:

     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
   if([[segue identifier] isEqualToString:@"SingleReportSegue"])
    {
        MI6SingleReportViewController* destVc = (MI6SingleReportViewController*)segue.destinationViewController;
        
        if(sendByActionSheet == 1)
        {
            Report* report = [[[CoreDataHelper instance] entityManager] createNewReport];
            detector.report = report;
            [detector startFetchingCurrentLocation];
            
            [destVc setReport:report];
            sendByActionSheet = 0;
        }
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            [destVc setReport:[self.datasource.arrayOfReportTitle objectAtIndex:indexPath.row]];
        }
        
    }
}

#pragma mark - MI6GPSLocationDetectorDelegate

-(void)LocationDetector:(MI6GPSLocationDetector *)locationDetector didFindCurrentLocation:(CLLocation *)location
{
    locationDetector.report.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    locationDetector.report.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    
    if (locationDetector.media != nil)
    {
        locationDetector.media.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
        locationDetector.media.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
    }
}

-(void)LocationDetector:(MI6GPSLocationDetector *)locationDetector didFailToFindCurrentLocationWithError:(NSError *)error
{
    
}



@end






