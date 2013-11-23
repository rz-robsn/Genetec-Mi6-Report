//
//  MI6LocationToAddressDelegate.h
//  Genetec.MI6
//
//  Created by MoAir on 11/23/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MI6LocationToAddressHelper;

@protocol MI6LocationToAddressDelegate <NSObject>

-(void)locationToAddressHelper:(MI6LocationToAddressHelper*)helper didFinishWithAddress:(NSString*) address;
-(void)locationToAddressHelperdidFailToGetAddress:(MI6LocationToAddressHelper*)helper;


@end
