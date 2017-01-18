//
//  ViewController.h
//  TapChallenge
//
//  Created by Clemente Di Rosa on 13/01/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UILabel *tapsCountLabel;


@property (nonatomic, weak) IBOutlet UILabel *timerLabel;


@property (nonatomic, weak) IBOutlet UIButton *tapButton;


-(IBAction)buttonPressed:(id)sender;

-(IBAction)tapGestureRecognizerDidRecognizeTap:(id)sender;


@end

