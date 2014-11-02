//
//  SavedWordListViewController.h
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordRepository.h"
#import "WordDetailViewController.h"

@interface SavedWordListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, WordDetailDelegate>
@property (strong, nonatomic) WordRepository *repo;
@end
