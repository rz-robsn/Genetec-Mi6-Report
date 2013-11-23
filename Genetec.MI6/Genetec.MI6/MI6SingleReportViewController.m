//
//  MI6SingleReportViewController.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6SingleReportViewController.h"
#import "Media.h"
#import "Report.h"
#import "CoreDataHelper.h"
#import "EntityManager.h"
#import "MI6NotesDataSource.h"
#import "MI6Image.h"

@interface MI6SingleReportViewController ()

@property (strong,nonatomic) MI6NotesDataSource *datasource;

@end

@implementation MI6SingleReportViewController

@synthesize report;

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
    
    self.tapRecognizer.cancelsTouchesInView = NO;
    
    _datasource = [[MI6NotesDataSource alloc] initWithReport:report];
    self.tableView.dataSource = _datasource;
    
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
    // Handle a still image capture
    if ([mediaType isEqualToString:@"public.image"]){
           NSLog(@"%@",mediaType);
        UIImage *imageL = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *savedImageData = UIImagePNGRepresentation(imageL);
//        Media* media = [[[CoreDataHelper instance] entityManager] createNewMedia];
//        media.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
//        media.data = savedImageData;
//        media.type = [NSNumber numberWithInt:MEDIA_TYPE_IMAGE];
//        [report addMedias:[NSSet setWithObject:media]];
        
    }else if([mediaType isEqualToString:@"public.movie"]){
        NSString *moviePath =  [[info objectForKey:UIImagePickerControllerMediaURL] path];
        NSURL *videoUrl =[info objectForKey:UIImagePickerControllerMediaURL];
        NSData *savedVideo = [NSData dataWithContentsOfFile:moviePath];
//        Media* media = [[[CoreDataHelper instance] entityManager] createNewMedia];
//        media.timestamp = [NSDate dateWithTimeIntervalSinceNow:0];
//        media.data = savedVideo;
//        media.type = [NSNumber numberWithInt:MEDIA_TYPE_VIDEO];
//        [report addMedias:[NSSet setWithObject:media]];
    }
    
 
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

@end
