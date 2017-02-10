//
//  ScoreTableViewController.h
//  TapChallenge
//
//  Created by Clemente Di Rosa on 18/01/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Result.h"


@protocol ScoreTableViewDelegate <NSObject>
/// richiedo i risultati alla classe che conforma il mio protocollo
-(NSMutableArray<Result *> *)ScoreTableViewFetchResults;

@end

@interface ScoreTableViewController : UITableViewController


@property (nonatomic, strong) NSMutableArray<Result*> *scoresArray;

@property (nonatomic, unsafe_unretained) id <ScoreTableViewDelegate> delegate;


@end
