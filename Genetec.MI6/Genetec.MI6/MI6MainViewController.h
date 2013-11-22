//
//  MI6MainViewController.h
//  Genetec.MI6
//
//  Created by MoAir on 11/22/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MI6MainViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@end
