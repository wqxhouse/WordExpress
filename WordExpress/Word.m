//
//  Word.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "Word.h"
#import "Utils.h"
#import "Meaning.h"

static int highest_id = 0;

@implementation Word

- (instancetype)initWithArray: (NSArray *)arr;
{
    self = [super init];
    if(self)
    {
        _meanings = [[NSMutableArray alloc] init];
        __id = [NSNumber numberWithInt: highest_id++];
        
        _word = arr[0];
        Meaning *m = [[Meaning alloc] init];
        m.ch = arr[1];
        
        if([arr[2] isEqualToString:@""])
        {
            m.sym_arr = [[NSArray alloc] init];
        }
        else
        {
            m.sym_arr = [Utils convertSymStringToArray:arr[2]];
        }
        
        [self.meanings addObject:m];
    }
    return self;
}

- (void)addMeaning: (NSArray *)arr
{
    Meaning *m = [[Meaning alloc] init];
    m.ch = arr[1];
    
    if([arr[2] isEqualToString:@""])
    {
        m.sym_arr = [[NSArray alloc] init];
    }
    else
    {
        m.sym_arr = [Utils convertSymStringToArray:arr[2]];
    }
    
    [self.meanings addObject:m];
}


- (NSArray *)getSim
{
    NSMutableArray *mut = [[NSMutableArray alloc] init];
    
    int rnd1 = arc4random() % [self.meanings count];
    Meaning *m = self.meanings[rnd1];
   
    NSMutableArray *arr = [m.sym_arr mutableCopy];
    if(m.sym_arr.count >= 2)
    {
        // random select
        NSUInteger rndidx = arc4random() % [arr count];
        NSString *selected1 = arr[rndidx];
        [mut addObject:selected1];
        [arr removeObjectAtIndex:rndidx];
        
        rndidx = arc4random() % [arr count];
        NSString *selected2 = arr[rndidx];
        [mut addObject:selected2];
    }
    else
    {
        mut = arr;
    }
    return mut;
}

@end
