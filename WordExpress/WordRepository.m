//
//  WordRepository.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "WordRepository.h"
#import "Word.h"
#import <CHCSVParser/CHCSVParser.h>
#import "Utils.h"
#import "TestEntry.h"
#import "Meaning.h"

@implementation WordRepository
- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _wordList = [[NSMutableArray alloc] init];
        _wordAssoc = [[NSMutableDictionary alloc] init];
        _exWordAssoc = [[NSMutableDictionary alloc] init];
        _exWordList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)gen_wordList
{
    [_wordAssoc removeAllObjects];
    [_wordList  removeAllObjects];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"word" ofType:@"csv"];
    NSURL *url = [NSURL URLWithString:[@"file://" stringByAppendingString: filePath]];
    NSArray *words = [NSArray arrayWithContentsOfCSVURL:url];
   
    NSString *prev_word = @"";
    NSUInteger randomWordIndex = -1;
    for(int i = 0; i < words.count; i++)
    {
        NSArray *entry = words[i];
        if([entry[0] isEqualToString:@"// random"])
        {
            randomWordIndex = i;
            break;
        }
        
        if(![entry[1] isEqualToString:@""] && ![prev_word isEqualToString:entry[0]])
        {
            Word *word = [[Word alloc] initWithArray:entry];
            [self.wordList addObject:word];
            [self.wordAssoc setObject:word forKey:word.word];
        }
        else if([prev_word isEqualToString:entry[0]])
        {
            Word *last_word = [self.wordList lastObject];
            [last_word addMeaning:entry];
        }
        prev_word = entry[0];
    }
    
    for(NSUInteger i = randomWordIndex + 1; i < words.count; i++)
    {
        Word *word = [_exWordAssoc objectForKey: words[i][0]];
        if(word == nil)
        {
            continue;
        }
        else
        {
            [_wordAssoc setObject: word forKey:word.word];
            [_wordList addObject: word];
        }
    }
}

- (void)gen_excelWordList
{
    [_exWordAssoc removeAllObjects];
    [_exWordList  removeAllObjects];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"excelwords" ofType:@"csv"];
    NSURL *url = [NSURL URLWithString:[@"file://" stringByAppendingString: filePath]];
    NSArray *words = [NSArray arrayWithContentsOfCSVURL:url];
    for(int i = 0; i < [words count]; i++)
    {
        NSArray *entry = words[i];
        Word *word = [[Word alloc] init];
        word.word = entry[0];
        
        NSString *meaning_data = entry[1];
        NSArray *meanings_arr = [meaning_data componentsSeparatedByString:@";"];
        // trim strings
        for(int j = 0; j < [meanings_arr count]; j++)
        {
            NSString *meaning = meanings_arr[j];
            NSString *trimmed = [meaning stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            if([trimmed isEqualToString:@""])
            {
                continue;
            }
            
            NSMutableArray *pair = [[trimmed componentsSeparatedByString:@":"] mutableCopy];
            
            for(int z = 0; z < [pair count]; z++)
            {
                NSString *trimmed_1 = [pair[z] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                pair[z] = trimmed_1;
            }
            
            Meaning *_meaning = [[Meaning alloc] init];
            _meaning.ch = pair[0];
            
            // split synonmy
            if([pair count] > 1)
            {
                NSMutableArray *synonmyArr = [[pair[1] componentsSeparatedByString:@","] mutableCopy];
                for(int i = 0; i < [synonmyArr count]; i++)
                {
                    NSString *trimmedStr = [synonmyArr[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    synonmyArr[i] = trimmedStr;
                    _meaning.sym_arr = synonmyArr;
                }
            }
            else
            {
                _meaning.sym_arr = [[NSMutableArray alloc] init];
            }
            [word.meanings addObject:_meaning];
        }
        [_exWordAssoc setObject:word forKeyedSubscript:word.word];
        [_exWordList addObject:word];
    }
}

- (Word *)getWord: (NSString *)word
{
    return [self.wordAssoc objectForKey:word];
}

- (NSArray *)randomWords: (int)number word:(NSString *)word
{
    // TODO: corner case, wordList <= 5
    if(number == 1 && word != nil)
    {
        int rnd = arc4random() % [self.wordList count];
        return @[self.wordList[rnd]];
    }
    NSMutableSet *set = [[NSMutableSet alloc] init];
    Word *originalWord = [self.wordAssoc objectForKey: word];
    if(word != nil) // and number != 1
    {
        [set addObject:originalWord];
    }
    
    while([set count] != number+1)
    {
        int rnd = arc4random() % [self.wordList count];
        [set addObject:self.wordList[rnd]];
    }
    
    if(word != nil)
    {
        [set removeObject:originalWord];
    }
    
    return [set allObjects];
}

- (NSArray *)randomCh: (NSString *)word
{
    return [self randomWords:4 word:word];
}

// currently cannot gurantee 5 entries
- (TestEntry *)gen_ans_sim: (Word *)word
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *simArr = [word getSim];
    /*
    if([simArr count] < 2)
    {
        return [[TestEntry alloc] init]; //empty
    }*/
    
    [arr addObjectsFromArray:simArr];
    
    NSArray *randomWords = [self randomWords:3 word:word.word];
    for(int i = 0; i < [randomWords count]; i++)
    {
        Word *w = randomWords[i];
        NSArray *sym_arr = [w getSim];
        if([sym_arr count] != 0)
        {
            [arr addObject:sym_arr[0]];
        }
    }
    // get prev ans indices
    NSMutableArray *prev_ans_arr = [[NSMutableArray alloc] init];
    for(NSUInteger i = 0; i < [simArr count]; i++)
    {
        [prev_ans_arr addObject:[NSNumber numberWithUnsignedInteger:i]];
    }
    NSArray *answers = [self shuffle:arr answerIndices:prev_ans_arr];
    
    TestEntry *te = [[TestEntry alloc] init];
    te.word = word.word;
    te.choices = arr;
    te.answers = answers;
    
    return te;
}

- (NSArray *)shuffle: (NSMutableArray *)arr answerIndices:(NSArray *)answerIndices
{
    NSMutableArray *answers = [[NSMutableArray alloc] initWithArray:answerIndices];
    NSUInteger count = [arr count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform(remainingCount);
        
        //
        NSUInteger idx1 = [answers indexOfObject:[NSNumber numberWithUnsignedInteger:i]];
        NSUInteger idx2 = [answers indexOfObject:[NSNumber numberWithUnsignedInteger:exchangeIndex]];
        if(((idx1 != NSNotFound) ^ (idx2 != NSNotFound)) != 0)
        {
            if(idx1 == NSNotFound)
            {
                answers[idx2] = [NSNumber numberWithUnsignedInteger:i];
            }
            else if(idx2 == NSNotFound)
            {
                answers[idx1] = [NSNumber numberWithUnsignedInteger:exchangeIndex];
            }
        }
        //
        
        [arr exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
    return answers;
}

- (TestEntry *)gen_ans_ch: (Word *)word
{
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSArray *w_arr = [self randomWords: 4 word: word.word];
    
    // randomly choose a meaning
    int rnd_meaning = arc4random() % [word.meanings count];
    Meaning *meaning = word.meanings[rnd_meaning];
    
    [arr addObject: meaning.ch];
    
    for(int i = 0; i < [w_arr count]; i++)
    {
        Word *w = w_arr[i];
        
        // randomly choose a meaning
        int rnd_meaning2 = arc4random() % [w.meanings count];
        Meaning *meaning = w.meanings[rnd_meaning2];

        [arr addObject: meaning.ch];
    }
    
    NSArray *prev_ans = @[[NSNumber numberWithUnsignedInteger:0]];
    
    NSArray *answers = [self shuffle:arr answerIndices:prev_ans];
    TestEntry *te = [[TestEntry alloc] init];
    te.word = word.word;
    te.choices = arr;
    te.answers = answers;
    return te;
}
@end
