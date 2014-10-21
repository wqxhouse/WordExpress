//
//  TestEntry.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "TestEntry.h"

@implementation TestEntry

- (instancetype) init
{
    self = [super init];
    if(self)
    {
        _empty = true;
    }
    return self;
}

- (void)setWord:(NSString *)word
{
    _word = word;
    _empty = false;
}

@end
