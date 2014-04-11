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
@property (weak, nonatomic) IBOutlet UITextField *userAdress;
@property (weak, nonatomic) IBOutlet UITextField *userSendPort;
@property (weak, nonatomic) IBOutlet UITextField *userReceivePort;

- (IBAction)readyToSend:(id)sender;

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
    NSArray *arguments1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:0], nil];
    NSArray *arguments2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:1], nil];
    self.message1 = [F53OSCMessage messageWithAddressPattern:@"/path1/message1"
                                                   arguments:arguments1];
    self.message2 = [F53OSCMessage messageWithAddressPattern:@"/path1/message2"
                                                   arguments:arguments2];
    NSLog(@"beginning app");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)readyToSend:(id)sender {
}

- (IBAction)beginListening:(id)sender {
    self.oscServer = [[F53OSCServer alloc] init];
    NSString *portText = [self.userReceivePort text];
    [self.oscServer setPort:[portText integerValue]];
    [self.oscServer setDelegate:self];
    BOOL success = [self.oscServer startListening];
    if (success){NSLog(@"success");}
    else{NSLog(@"failure");};
}

- (IBAction)sendMessage1:(id)sender {
    //[self changeMessageDisplayLabelTo:1];
    NSLog(@"message1 sent");
    [self.oscClient sendPacket:self.message1 toHost:[self.userAdress text] onPort:[[self.userSendPort text] integerValue]];
}

- (IBAction)sendMessage2:(id)sender {
    //[self changeMessageDisplayLabelTo:2];
    NSLog(@"message2 sent");
    [self.oscClient sendPacket:self.message2 toHost:[self.userAdress text] onPort:[[self.userSendPort text] integerValue]];
}

- (void)takeMessage:(F53OSCMessage *)message {
    NSLog(@"in takeMessage:message");
    NSString *addressPattern = message.addressPattern;
    NSArray *arguments = message.arguments;
    NSNumber *receivedInt = [arguments objectAtIndex:0];
    NSLog(@"%i",[receivedInt intValue]);
    [self changeMessageDisplayLabelTo:[receivedInt intValue]];
    if ([addressPattern isEqualToString:@"/path1/message1"]){
        NSLog(@"intercepted message1");
    }
    else if ([addressPattern isEqualToString:@"/path1/message2"]){
        NSLog(@"intercepted message2");
    }
}

- (void)changeMessageDisplayLabelTo:(int)recievedInt{
    NSString *newTextString = [NSString stringWithFormat:@"%i",recievedInt];
    [self.messageDisplayLabel setText:newTextString];
}

@end
