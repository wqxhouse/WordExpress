//
//  WordRepository.h
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Word;
@class TestEntry;
@interface WordRepository : NSObject

@property (nonatomic, strong) NSMutableArray *wordList;
@property (nonatomic, strong) NSMutableDictionary *wordAssoc;
@property (nonatomic, strong) NSMutableArray *exWordList;
@property (nonatomic, strong) NSMutableDictionary *exWordAssoc;

- (void)gen_wordList;
- (void)gen_excelWordList;
- (Word *)getWord: (NSString *)word;
- (NSArray *)randomWords: (int) number word:(NSString *)word;
- (NSArray *)randomCh: (NSString *)word;

- (TestEntry *)gen_ans_sim: (Word *)word;
- (TestEntry *)gen_ans_ch: (NSString *)word;

@end
