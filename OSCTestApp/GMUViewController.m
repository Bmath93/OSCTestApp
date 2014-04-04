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

- (IBAction)beginListening:(id)sender;

- (IBAction)sendMessage1:(id)sender;

- (IBAction)sendMessage2:(id)sender;

- (void)changeMessageDisplayLabelTo: (int)recievedInt;

@property F53OSCServer *oscServer;
@property F53OSCClient *oscClient;
@property F53OSCMessage *message1;
@property F53OSCMessage *message2;

@end

@implementation GMUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.oscClient = [[F53OSCClient alloc] init];
    self.message1 = [F53OSCMessage messageWithAddressPattern:@"/path1/message1"
                                                   arguments:@[@1]];
    self.message2 = [F53OSCMessage messageWithAddressPattern:@"/path1/message2"
                                                   arguments:@[@2]];
    NSLog(@"beginning app");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginListening:(id)sender {
    self.oscServer = [[F53OSCServer alloc] init];
    [self.oscServer setPort:3000];
    [self.oscServer setDelegate:self];
    BOOL success = [self.oscServer startListening];
    if (success){NSLog(@"success");}
    else{NSLog(@"failure");};
}

- (IBAction)sendMessage1:(id)sender {
    //[self changeMessageDisplayLabelTo:1];
    NSLog(@"message1 sent");
    [self.oscClient sendPacket:self.message1 toHost:@"localhost" onPort:3000];
}

- (IBAction)sendMessage2:(id)sender {
    //[self changeMessageDisplayLabelTo:2];
    NSLog(@"message2 sent");
    [self.oscClient sendPacket:self.message2 toHost:@"localhost" onPort:3000];
}

- (void)takeMessage:(F53OSCMessage *)message {
    NSLog(@"in takeMessage:message");
    NSString *addressPattern = message.addressPattern;
    NSArray *arguments = message.arguments;
    
    if ([addressPattern isEqualToString:@"/path1/message1"]){
        NSLog(@"intercepted message1");
        //[self changeMessageDisplayLabelTo:(int)[arguments objectAtIndex:0]];
    }
    else if ([addressPattern isEqualToString:@"/path1/message2"]){
        NSLog(@"intercepted message2");
        //[self changeMessageDisplayLabelTo:(int)[arguments objectAtIndex:0]];
    }
}

- (void)changeMessageDisplayLabelTo:(int)recievedInt{
    NSString *newTextString = [NSString stringWithFormat:@"%i",recievedInt];
    [self.messageDisplayLabel setText:newTextString];
}

@end
