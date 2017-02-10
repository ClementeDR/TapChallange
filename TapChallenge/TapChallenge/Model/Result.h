//
//  Result.h
//  TapChallenge
//
//  Created by Clemente Di Rosa on 10/02/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject

-(id)initWithResult:(NSInteger)result andDate:(NSDate *)date;

-(NSString *)game;

@property (nonatomic, readonly) NSInteger result;
@property (nonatomic, readonly) NSDate *date;


@end
