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
#import "MI6Image.h"
#import <AssetsLibrary/AssetsLibrary.h>
@interface MI6MainViewController ()

@property (strong,nonatomic) NSArray* arrayOfReportTitle;
@property (strong,nonatomic) NSArray* dateOfReport;
@property (strong,nonatomic) NSDate* date;
@property (strong,nonatomic) NSMutableArray* filteredArray;
@property (strong, nonatomic) UIImage* image;

@end

@implementation MI6MainViewController

@synthesize filteredArray;

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

    //self.date = [NSDate date]
    
    //self.arrayOfReportTitle = [NSArray arrayWithObjects:@"ab",@"bc",@"cd",@"de",@"fg", nil];
    self.arrayOfReportTitle = [[[EntityManager alloc]init]getAllReports];
   // self.dateOfReport = [NSArray arrayWithObjects:parsed.description,parsed.description,parsed.description,parsed.description,parsed.description, nil];
    
    self.searchBar.delegate = self;
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.arrayOfReportTitle count]];
    [self.tableView reloadData];
    
       [self.tableView reloadData];
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

#pragma mark - Table view data source

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
        MI6Image* imageTaken = [ [MI6Image alloc] init ];
        
        if ( [ imageTaken startCameraControllerFromViewController:self usingDelegate:self]){
        }
          
        
    }
    
}

//// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    UIImage *imageL = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    self.image = imageL;
    NSLog(@"%@" ,[self.image description]);
    [self dismissViewControllerAnimated:YES completion:nil];
    // Request to save the image to camera roll

    
   // UIImageWriteToSavedPhotosAlbum (self.image, nil, nil , nil);
   // [self performSegueWithIdentifier:@"SingleReportSegue" sender:self];
    
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredArray count];
    } else {
        return [self.arrayOfReportTitle count];
    }
   
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
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
       
       
        report = [filteredArray objectAtIndex:indexPath.row];
    } else {
        Report* re=  (Report*)[self.arrayOfReportTitle objectAtIndex:indexPath.row];
        report = [re title];
    }
   // NSLog(@"cell");
    cell.textLabel.text = report;
   // cell.textLabel.backgroundColor = [UIColor clearColor];
   // self.date = [NSDate date];
   // cell.detailTextLabel.text = [self.dateOfReport objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
//NSLog(@"cell doen");
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
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",searchText];
    filteredArray = [NSMutableArray arrayWithArray:[self.arrayOfReportTitle filteredArrayUsingPredicate:predicate]];
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
        if(sendByActionSheet == 1){
             [ segue.destinationViewController setReport:nil];
             sendByActionSheet = 0;
        }else{
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            NSLog(@"%d", indexPath.row);
            [ segue.destinationViewController setReport:[self.arrayOfReportTitle objectAtIndex:indexPath.row]];
            

        }
        
    }
}



@end






