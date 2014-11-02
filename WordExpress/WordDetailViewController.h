//
//  WordDetailViewController.h
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"
@protocol WordDetailDelegate
@required
- (void) saveWord: (Word *)word;
- (void) unsaveWord: (Word *)word;
@end

@interface WordDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Word *word;
@property (nonatomic, assign) BOOL saved;
@property (weak, nonatomic) id<WordDetailDelegate> delegate;
@end
