//
//  TestEntry.h
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestEntry : NSObject
@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, assign) BOOL empty;
@property (nonatomic, strong) NSArray *answers;

@end
