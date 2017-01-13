//
//  ViewController.m
//  TapChallenge
//
//  Created by Clemente Di Rosa on 13/01/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import "ViewController.h"

#define GameTimer 1
#define GameTime 10

@interface ViewController (){
    int _tapsCount;
    NSTimer *_gameTimer;
    int _timeCount;
    bool _endGame;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    _endGame = true;
    self.tapsCountLabel.minimumScaleFactor = 0.5;
    [self.tapsCountLabel setAdjustsFontSizeToFitWidth:true];
    
    [self initializeGame];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"didReceiveMemoryWarning");
    // Dispose of any resources that can be recreated.
}

-(void)initializeGame{
    _tapsCount = 0;
    _timeCount = GameTime;
    [self.tapsCountLabel setText:@"Tap to play"];
    [self.timerLabel setText:[NSString stringWithFormat:@"Tempo : %i sec", _timeCount]];
   
}

#pragma mark - Actions

-(IBAction)buttonPressed:(id)sender{
    if (_endGame) {
        [self initializeGame];
//        [self.tapButton setTitle:@"Press to start" forState:nil];
        
    
    }
    
    if(_gameTimer == nil){
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GameTimer target:self selector:@selector(timerTick) userInfo:nil repeats:true];
        _endGame = false;
//        [self.tapButton setTitle:@"Press" forState:nil];
    }
    
    _tapsCount++;
    
    NSLog(@"TapsCount --> %i", _tapsCount);
    [self.tapsCountLabel setText:[NSString stringWithFormat:@"%i", _tapsCount]];

}

-(void)timerTick{
    //stampa nome funzione
    NSLog(@"%s", __PRETTY_FUNCTION__);
    _timeCount--;
   
    [self.timerLabel setText:[NSString stringWithFormat:@"Tempo : %i sec", _timeCount]];
    
    if (_timeCount == 0) {
        [_gameTimer invalidate];
        _gameTimer = nil;
        _endGame = true;
        [self.tapsCountLabel setText:[NSString stringWithFormat:@"Tuo punteggio %i", _tapsCount]];
        
        
    
        NSString *message = [NSString stringWithFormat:@"Tuo punteggio %i", _tapsCount];
        UIAlertController *alertViewController = [UIAlertController alertControllerWithTitle:@"GAME OVER" message:message preferredStyle:UIAlertControllerStyleAlert];
       
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"okAction pressed");
        }];
        
        [alertViewController addAction:okAction];
        
        [self presentViewController:alertViewController animated:true completion:nil];
        

    }
    
}

@end
