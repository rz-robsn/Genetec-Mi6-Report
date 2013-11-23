//
//  MI6PrintViewController.m
//  Genetec.MI6
//
//  Created by MoAir on 11/23/2013.
//  Copyright (c) 2013 Zachary Patterson. All rights reserved.
//

#import "MI6PrintViewController.h"
#import "Media.h"
#import "Report.h"
@interface MI6PrintViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) Media* media;

@property (strong, nonatomic) NSArray* medias;
@end

@implementation MI6PrintViewController


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
    [self addSubviews];
}




- (void) addSubviews{
    self.medias = [self.report.medias allObjects];
    UIImageView* imageView;
    UILabel* label;
    int imagesWidth = 0;
    CGFloat xOriginLabel;
    CGFloat yOriginLabel;
    int countX = 0;
    int countY = 0;
    CGFloat heightLabel = (self.scrollView.bounds.size.height / 6);
    for (int i = 0; i < [self.medias count]; ++i) {
        
        self.media = [self.medias objectAtIndex:i];
        if ( [self.media.type intValue] == MEDIA_TYPE_IMAGE) {
             imageView = [[UIImageView alloc] initWithImage:(UIImage*)self.media];
           imagesWidth += imageView.bounds.size.width;
            [self.scrollView addSubview:imageView];
        }else if ([self.media.type intValue ] == MEDIA_TYPE_NOTE){
            xOriginLabel = countX * self.view.bounds.size.width;
            yOriginLabel = countY * heightLabel;
            NSLog(@"%f", yOriginLabel);
            label = [[UILabel alloc] initWithFrame:CGRectMake(xOriginLabel,yOriginLabel, self.scrollView.bounds.size.width,60)];// change the size later
            label.numberOfLines = 10;
            [label setFont:[UIFont fontWithName:@"Arial" size:18]];
            [label setAdjustsFontSizeToFitWidth:YES];
            //[label setAutoresizingMask:UIViewContentModeScaleToFill];
            //[label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
            
           // CGRect newFrame = label.frame;
          //  newFrame.size.height = expectedLabelSize.height;
          //  label.frame = newFrame;
            label.text = self.media.text;
           
            [label setText:[NSString stringWithFormat:@"%@ : %@", self.media.timestamp.description, self.media.text]];
            NSLog(@"%@",label.text);
            [self.scrollView addSubview:label];
            ++countY;
        }
        
        
        
        
    }
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width ,self.scrollView.bounds.size.height + imagesWidth );

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
