//
//  WordDetailViewController.h
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"

@interface WordDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) Word *word;
@end
