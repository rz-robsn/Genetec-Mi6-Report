//
//  MI6LocationToAddressHelper.h
//  Genetec.MI6
//
//  Created by MoAir on 11/23/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MI6LocationToAddressDelegate.h"

@interface MI6LocationToAddressHelper : NSObject <NSURLConnectionDelegate>

@property (strong, nonatomic) CLLocation* coordinate;
@property (weak, nonatomic) id<MI6LocationToAddressDelegate> delegate;

-(void)convertToAddress;

@end
