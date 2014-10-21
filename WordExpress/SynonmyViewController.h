//
//  SynonmyViewController.h
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WordRepository;
@interface SynonmyViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) WordRepository *repo;
@end
