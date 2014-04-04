//
//  GMUViewController.m
//  OSCTestApp
//
//  Created by Research Assistant [PureData] on 4/4/14.
//  Copyright (c) 2014 Research Assistant [PureData]. All rights reserved.
//

#import "GMUViewController.h"

@interface GMUViewController ()

@property (weak, nonatomic) IBOutlet UILabel *messageDisplayLabel;

- (IBAction)sendMessage1:(id)sender;

- (IBAction)sendMessage2:(id)sender;

- (void)changeMessageDisplayLabelTo: (int)recievedInt;

@end

@implementation GMUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendMessage1:(id)sender {
    [self changeMessageDisplayLabelTo:1];
}

- (IBAction)sendMessage2:(id)sender {
    [self changeMessageDisplayLabelTo:2];
}

- (void)changeMessageDisplayLabelTo:(int)recievedInt{
    NSString *newTextString = [NSString stringWithFormat:@"%i",recievedInt];
    [self.messageDisplayLabel setText:newTextString];
}
@end
