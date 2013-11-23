//
//  MI6SingleReportViewController.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MI6GPSLocationDetectorDelegate.h"

@class Report;

@interface MI6SingleReportViewController : UIViewController <UIActionSheetDelegate ,
                                                            UIAlertViewDelegate,
                                                            UITableViewDelegate,
                                                            UIImagePickerControllerDelegate,
                                                            UINavigationControllerDelegate,
                                                            UIGestureRecognizerDelegate,
                                                            MI6GPSLocationDetectorDelegate>

@property (strong, nonatomic) Report* report;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;

- (IBAction)NewBarButtonItemTapped:(id)sender;
- (IBAction)titleTextFieldEditingDidEnd:(id)sender;

- (IBAction)onViewTapped:(id)sender;

@end
