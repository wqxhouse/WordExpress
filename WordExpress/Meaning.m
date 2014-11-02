//
//  Meaning.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "Meaning.h"

@implementation Meaning
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        _ch = [aDecoder decodeObjectForKey:@"ch"];
        _sym_arr = [aDecoder decodeObjectForKey:@"sym_arr"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_ch forKey:@"ch"];
    [aCoder encodeObject:_sym_arr forKey:@"sym_arr"];
}
@end
