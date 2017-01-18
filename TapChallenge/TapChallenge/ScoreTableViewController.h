//
//  ScoreTableViewController.h
//  TapChallenge
//
//  Created by Clemente Di Rosa on 18/01/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ScoreTableViewDelegate <NSObject>
/// richiedo i risultati alla classe che conforma il mio protocollo
-(NSArray *)ScoreTableViewFetchResults;

@end

@interface ScoreTableViewController : UITableViewController


@property (nonatomic, strong) NSArray *scoresArray;

@property (nonatomic, unsafe_unretained) id <ScoreTableViewDelegate> delegate;


@end
