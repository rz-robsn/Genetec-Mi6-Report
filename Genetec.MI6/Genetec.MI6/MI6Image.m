//
//  MI6Image.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6Image.h"



@implementation MI6Image



@synthesize myImage = _myImage;


- (BOOL) startCameraControllerFromViewController:(UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate,
                                                                                                UINavigationControllerDelegate>) delegate{
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    
    else
    {
        [cameraUI setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
    }
    
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
      cameraUI.allowsEditing = YES;
    
    
    [cameraUI setDelegate:delegate];
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}


-(BOOL) startCameraControllerForVedioOrPic:(UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate,
                                                                                          UINavigationControllerDelegate>) delegate {
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [cameraUI setSourceType:UIImagePickerControllerSourceTypeCamera];
    }

    
    
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
     cameraUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:
      UIImagePickerControllerSourceTypeCamera];
    
    [cameraUI setDelegate:delegate];
    [controller presentViewController:cameraUI animated:YES completion:nil];
    return YES;
}


@end
