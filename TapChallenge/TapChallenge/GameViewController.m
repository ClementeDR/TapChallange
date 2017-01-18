//
//  ViewController.m
//  TapChallenge
//
//  Created by Clemente Di Rosa on 13/01/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import "GameViewController.h"
#import "ScoreTableViewController.h"

#define GameTimer 1
#define GameTime 30
#define TapsCount "_tapsCount"
#define FirstLog @"FirstLog"
#define Defaults [NSUserDefaults standardUserDefaults]
#define Results @"UserScore"

// per creare la doc si usano 3 "/" ->>> "///"

@interface GameViewController (){
    int _tapsCount;
    NSTimer *_gameTimer;
    int _timeCount;
    bool _endGame;
    UILabel *_newLavel;
    
}

@end

@implementation GameViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"viewDidLoad");
    // Do any additional setup after loading the view, typically from a nib.
    _endGame = true;
    self.tapsCountLabel.minimumScaleFactor = 0.5;
    [self.tapsCountLabel setAdjustsFontSizeToFitWidth:true];
    [self initializeGame];
    
    self.title = @"Tap Challenge";
    

     
    UIBarButtonItem *scoreButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(scoreButtonPressed)];

    
    self.navigationItem.rightBarButtonItem = scoreButtonItem;
    
    
    //creare objView da codice
//     _newLavel = [[UILabel alloc] initWithFrame:CGRectMake(10,100,100,40)];
//
//    [_newLavel setText:@"new laber"];
//    
//    [_newLavel setBackgroundColor:[UIColor greenColor]];
//    [_newLavel setTextColor:[UIColor blackColor]];
//    [_newLavel setFont:[UIFont boldSystemFontOfSize:16]];
//    
//    
//    [self.view addSubview:_newLavel];

}

- (void) viewDidAppear:(BOOL)animated{
    
    [self showLastResult:[self risultato]];

    [self resumeGame];
    
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsPath = [paths objectAtIndex:0];
//    NSLog(@"%@", documentsPath);

}

-(void)viewWillDisappear:(BOOL)animated{
    [self pauseGame];
}

-(void)pauseGame{
    if(_gameTimer != nil){
        [_gameTimer invalidate];
        _gameTimer = nil;
    }
}

-(void)resumeGame{
    if(_timeCount != 0 && _tapsCount > 0){
       _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GameTimer target:self selector:@selector(timerTick) userInfo:nil repeats:true];
    }
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

-(void)scoreButtonPressed{
   // UIViewController *viewController = [[UIViewController alloc] init];
    
   //  viewController.title = @"nuovo";
    
    
    //prendo da storyboard il VC ScoreTableViewController
    ScoreTableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ScoreTableViewController"];
    
    NSArray *resultsArray = [self risultato];
    [tableViewController setScoresArray:resultsArray];
    
    
    //instauro il collegamento tra GVC e SVC
    tableViewController.delegate = self;
    
    
    //pusho nello stack del navigationViewController
    [self.navigationController pushViewController:tableViewController animated:true];
}

-(IBAction)buttonPressed:(id)sender{
    if (_endGame) {
        [self initializeGame];
      //  [self.tapButton setTitle:@"Press to start" forState:UIControlStateNormal];
    }
    
    if(_gameTimer == nil){
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GameTimer target:self selector:@selector(timerTick) userInfo:nil repeats:true];
        _endGame = false;
      //  [self.tapButton setTitle:@"Press" forState:UIControlStateNormal];
    }
    
    _tapsCount++;
    
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
       
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"RETRY" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self salvaRisultato];
            [self initializeGame];
            NSLog(@"okAction pressed");
        }];
        
        [alertViewController addAction:okAction];
        
        [self presentViewController:alertViewController animated:true completion:nil];
        

    }
    
}


//tap gesture recognizer
-(IBAction)tapGestureRecognizerDidRecognizeTap:(id)sender{
    NSLog(@"tapGestureRecognizerDidRecognizeTap");
    if (_endGame) {
        [self initializeGame];
        //  [self.tapButton setTitle:@"Press to start" forState:UIControlStateNormal];
    }
    
    if(_gameTimer == nil){
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:GameTimer target:self selector:@selector(timerTick) userInfo:nil repeats:true];
        _endGame = false;
        //  [self.tapButton setTitle:@"Press" forState:UIControlStateNormal];
    }
    
    _tapsCount++;
    
    [self.tapsCountLabel setText:[NSString stringWithFormat:@"%i", _tapsCount]];

}

#pragma mark - UI
- (void)showLastResult:(NSArray *)result{
    NSString *messageLastResult;
    if (![self firstAppear]){
        messageLastResult = @"Primo avvio";
        [Defaults setBool:true forKey:FirstLog];
        [Defaults synchronize];
    } else{
        if (result.count > 0) {
            NSNumber *number = result.firstObject;
             messageLastResult = [NSString stringWithFormat:@"Ultimo risultato %i", number.intValue];
        } else {
            messageLastResult = @"Non hai mai completato il gioco";
        }
    }
        
    UIAlertController *alertViewControllerLastResult = [UIAlertController alertControllerWithTitle:@"Hello" message:messageLastResult preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okActionLast = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       // [self initializeGame];
    }];
    
    [alertViewControllerLastResult addAction:okActionLast];
    
    [self presentViewController:alertViewControllerLastResult animated:true completion:nil];
}

#pragma mark - Persistenza

- (NSArray *)risultato{
    NSArray *array = [Defaults objectForKey:Results];
    
    if (array == nil) {
        array = @[];
    }
    
    return array;
}

-(bool)firstAppear{
    return [[NSUserDefaults standardUserDefaults] boolForKey:FirstLog];
}

- (void)salvaRisultato{
    NSMutableArray *array = [[Defaults objectForKey:Results] mutableCopy];
    if (array == nil) {
        //array = [[NSMutableArray alloc] init].mutableCopy;
        
        // anche per swift new way
        array = @[].mutableCopy;
        
    }
    
    // old
    // NSNumber *number = [NSNumber numberWithInt:_tapsCount];
    
    // new way
    [array addObject:@(_tapsCount)];
    NSLog(@"MIO ARRAY %@", array);
    
    NSArray *array2beSaved = [array sortedArrayUsingComparator:^NSComparisonResult(NSNumber  *obj1, NSNumber  *obj2) {
        int value1 = obj1.intValue;
        int value2 = obj2.intValue;
        
        if (value1 == value2) {
            return NSOrderedSame;
        } else {
            if (value1 > value2) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }
    }];
    
    NSLog(@"MIO ARRAY ORDINATO %@", array2beSaved);

    
    [Defaults setObject:array2beSaved forKey:Results];
    [Defaults synchronize];
    
}

#pragma mark - ScoreTableViewDelegate
-(NSArray *)ScoreTableViewFetchResults{
    return [self risultato];
}

@end
