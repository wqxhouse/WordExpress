//
//  Utils.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+ (NSArray *)convertSymStringToArray:(NSString *)str
{
    NSMutableString *trimmedStr = [str mutableCopy];
    [trimmedStr replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [str length])];
    NSArray *arr = [trimmedStr componentsSeparatedByString:@","];
    return arr;
}

+ (NSString *)convertNumToCharStr: (NSUInteger)number
{
    char ch = (char)(number + 65);
    NSString *str = [NSString stringWithFormat:@"%c", ch];
    return str;
}
@end
