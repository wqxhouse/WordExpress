//
//  AllWordListViewController.h
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordRepository.h"

@interface AllWordListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) WordRepository *repo;
@end
