//
//  MI6SingleReportViewController.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-22.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Report;

@interface MI6SingleReportViewController : UIViewController <UIActionSheetDelegate , UIAlertViewDelegate, UITableViewDelegate,
UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Report* report;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)NewBarButtonItemTapped:(id)sender;
- (IBAction)titleTextFieldEditingDidEnd:(id)sender;

@end
