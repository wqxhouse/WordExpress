//
//  Word.h
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Meaning;
@interface Word : NSObject

@property (nonatomic, strong) NSString *word;
@property (nonatomic, strong) NSNumber *_id;
@property (nonatomic, strong) NSMutableArray *meanings;

- (NSArray *)getSim;
- (instancetype)initWithArray: (NSArray *)arr;
- (void)addMeaning: (NSArray *)arr;

@end
