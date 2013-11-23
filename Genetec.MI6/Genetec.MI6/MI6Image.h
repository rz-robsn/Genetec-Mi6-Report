//
//  MI6Image.h
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MI6Image : NSObject < UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage* myImage;

-(BOOL) startCameraControllerFromViewController:(UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate,
                                                                                              UINavigationControllerDelegate>) delegate ;
@end
