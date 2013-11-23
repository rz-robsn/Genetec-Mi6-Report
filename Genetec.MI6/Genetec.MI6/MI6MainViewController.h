//
//  MI6MainViewController.h
//  Genetec.MI6
//
//  Created by MoAir on 11/22/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MI6GPSLocationDetectorDelegate.h"

@interface MI6MainViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate,
UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MI6GPSLocationDetectorDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

-(void)mapBarButtonItemTapped;

@end
