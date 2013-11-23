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

@interface MI6SingleReportViewController ()
@property (strong,nonatomic) UITextView *textView;
@property (strong,nonatomic) MI6NotesDataSource *datasource;
@end

@implementation MI6SingleReportViewController

@synthesize textView;
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
    
    if (report == nil)
    {
        report = [[[CoreDataHelper instance] entityManager] createNewReport];
    }
    
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

- (IBAction)titleTextFieldEditingDidEnd:(id)sender {
}

#pragma mark - UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"New Note" ]) {
         textView = [[UITextView alloc]initWithFrame:CGRectMake(12, 50, 260, 50)];
        
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Add Note"
                                                          message:@""
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"Save",nil];
        message.alertViewStyle = UIAlertViewStylePlainTextInput;
        [message addSubview:textView];
        
        [message show];
        
    }else if ([[actionSheet buttonTitleAtIndex:buttonIndex] isEqualToString:@"Take Photo" ]) {
        
        
        
        
    }

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
        [[[CoreDataHelper instance] entityManager] saveContext];
        [[self tableView] reloadData];
    }
    
    
}

@end
