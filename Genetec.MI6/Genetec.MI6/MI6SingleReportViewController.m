//
//  MI6SingleReportViewController.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6SingleReportViewController.h"
#import "MI6DisplayMediaViewController.h"
#import "Media.h"
#import "Report.h"
#import "CoreDataHelper.h"
#import "EntityManager.h"
#import "MI6NotesDataSource.h"
#import "MI6Image.h"
#import "MI6DocumentDirectoryHelper.h"
#import "MI6GPSLocationDetector.h"
#import "MI6MapViewController.h"

@interface MI6SingleReportViewController ()

@property (strong,nonatomic) MI6NotesDataSource *datasource;
@property (strong, nonatomic) MI6GPSLocationDetector* detector;

@end

@implementation MI6SingleReportViewController

@synthesize report;
@synthesize detector;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view.
    self.titleTextField.text = report.title;
    self.detector = [[MI6GPSLocationDetector alloc] init];
    self.detector.delegate = self;
    
    self.tapRecognizer.cancelsTouchesInView = NO;
    
    _datasource = [[MI6NotesDataSource alloc] initWithReport:report];
    self.tableView.dataSource = _datasource;
    self.tableView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)NewBarButtonItemTapped:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@""
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"New Note", @"Take Photo", @"Record Video", @"Record Audio", nil];
    [actionSheet showInView:self.view];
}

- (IBAction)titleTextFieldEditingDidEnd:(id)sender
{
    if (self.titleTextField != nil)
    {
        report.title = self.titleTextField.text;
    }
}


- (IBAction)onViewTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)mapButtonItemTapped:(id)sender
{
    [self performSegueWithIdentifier:@"MapViewSegue" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"DisplayMediaSegue"])
    {
        NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
        MI6DisplayMediaViewController* destVc = (MI6DisplayMediaViewController*) [segue destinationViewController];
        destVc.media = [self.datasource.notes objectAtIndex:selectedRowIndexPath.row];
    }
    else if([[segue identifier] isEqualToString:@"MapViewSegue"])
    {
        MI6MapViewController* destVc = (MI6MapViewController*) [segue destinationViewController];
        [destVc setReport:self.report];
    }
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath *selectedRowIndexPath = [self.tableView indexPathForSelectedRow];
    Media* media = (Media*)[self.datasource.notes objectAtIndex:selectedRowIndexPath.row];
    if ([media.type intValue] == MEDIA_TYPE_VIDEO)
    {
        // Play video
        NSURL* videoUrl = [[NSURL alloc] initFileURLWithPath:media.text];
        NSData* data = [NSData dataWithContentsOfURL:videoUrl];
        MPMoviePlayerViewController *player = [[MPMoviePlayerViewController alloc] initWithContentURL:videoUrl];
        player.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [player.moviePlayer prepareToPlay];
        [self presentViewController:player animated:YES completion:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"DisplayMediaSegue" sender:nil];
    }
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"New Note" ]) {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Add Note"
                                                          message:@""
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save",nil];
        message.alertViewStyle = UIAlertViewStylePlainTextInput;
        [message show];
        
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo" ]) {
        
        
        [[ [MI6Image alloc] init ] startCameraControllerForVedioOrPic:self usingDelegate:self];
        
    }

}

//// For responding to the user accepting a newly-captured picture or movie
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    Media* media = [[[CoreDataHelper instance] entityManager] createNewMedia];
    NSDate* now = [NSDate dateWithTimeIntervalSinceNow:0];
    media.timestamp = now;

    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *imageL = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        NSData *savedImageData = UIImagePNGRepresentation(imageL);
        media.data = savedImageData;
        media.type = [NSNumber numberWithInt:MEDIA_TYPE_IMAGE];
        [report addMediasObject:media];
        
    }else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoUrl =[info objectForKey:UIImagePickerControllerMediaURL];
        NSString* destinationPath = [[[MI6DocumentDirectoryHelper applicationDocumentsDirectory] path]
                                     stringByAppendingPathComponent:[NSString stringWithFormat:@"capture-%f", [now timeIntervalSinceReferenceDate]]];
        NSFileManager* manager = [NSFileManager defaultManager];
        NSError* error;
        [manager copyItemAtPath:[videoUrl path] toPath:destinationPath error:&error];
        
        media.text = destinationPath ;
        media.type = [NSNumber numberWithInt:MEDIA_TYPE_VIDEO];
                      
        // saving thumbnail.
        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
        UIImage *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
        media.data = UIImagePNGRepresentation(thumbnail);
        player = nil;
        
        [report addMediasObject:media];
    }
    [[[CoreDataHelper instance] entityManager] saveContext];
    
    detector.media = media;
    [detector startFetchingCurrentLocation];
    [[self tableView] reloadData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
    // Request to save the image to camera roll
    //  NSData *imageData = [NSData dataWithData:UIImagePNGRepresentation(imageL)];
    
    
    // Transform the image to NSData
   // NSData *savedImageData = UIImagePNGRepresentation(imageL);
    
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *inputText = [[alertView textFieldAtIndex:0] text];
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Save" ])
    {
        Media* media = [[[CoreDataHelper instance] entityManager] createNewMedia];
        media.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
        media.text = inputText;
        media.type = [NSNumber numberWithInt:MEDIA_TYPE_NOTE];
        [report addMedias:[NSSet setWithObject:media]];
        [_datasource update];
        [[self tableView] reloadData];
    }
    
    
}

#pragma mark - MI6GPSLocationDetectorDelegate

-(void)LocationDetector:(MI6GPSLocationDetector *)locationDetector didFindCurrentLocation:(CLLocation *)location
{
    locationDetector.media.latitude = [NSNumber numberWithDouble:location.coordinate.latitude];
    locationDetector.media.longitude = [NSNumber numberWithDouble:location.coordinate.longitude];
}

-(void)LocationDetector:(MI6GPSLocationDetector *)locationDetector didFailToFindCurrentLocationWithError:(NSError *)error
{

}

@end
