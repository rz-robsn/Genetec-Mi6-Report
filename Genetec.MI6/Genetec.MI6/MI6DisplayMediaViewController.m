//
//  MI6DisplayMediaViewController.m
//  Genetec.MI6
//
//  Created by DataMobile on 2013-11-23.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6DisplayMediaViewController.h"
#import "Media.h"

@interface MI6DisplayMediaViewController ()

@end

@implementation MI6DisplayMediaViewController

@synthesize media;

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
    
    switch ([media.type intValue]) {
            
        case MEDIA_TYPE_NOTE:
        {
            self.label.text = [NSString stringWithFormat:@"%@\n\nat %@", media.text, media.timestamp];
            break;
        }
            
        case MEDIA_TYPE_IMAGE:
        {
            self.imageView.image = [UIImage imageWithData:media.data];
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }    break;
            
        case MEDIA_TYPE_AUDIO:
        {
            
        }
            break;
            
        case MEDIA_TYPE_VIDEO:
        {
         
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
