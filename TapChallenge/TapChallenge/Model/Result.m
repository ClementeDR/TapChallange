//
//  Result.m
//  TapChallenge
//
//  Created by Clemente Di Rosa on 10/02/2017.
//  Copyright © 2017 Clemente Di Rosa. All rights reserved.
//

#import "Result.h"

@implementation Result

-(id)initWithResult:(NSInteger)result andDate:(NSDate *)date{
    
    self = [super init];
    
    if (self) {
        _result = result;
        _date = date;
    }
    
    return self;
}

- (NSString *)description{
    NSString *message = [NSString stringWithFormat:@"%@ \n Punteggio : %ld \n Data: %@ ", [super description], (long)self.result ,self.date];
    
    return message;

}

-(NSString *)game{
    NSString *message = [NSString stringWithFormat:@"\n Punteggio : %ld \n Data: %@ ",(long)self.result ,self.date];
    
    return message;
}

@end
