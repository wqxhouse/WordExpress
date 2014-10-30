//
//  WordListTabBarController.m
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "WordListTabBarController.h"
#import "SavedWordListViewController.h"
#import "AllWordListViewController.h"

@interface WordListTabBarController ()

@end

@implementation WordListTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *vcs = self.viewControllers;
    for(int i = 0; i < [vcs count]; i++)
    {
        if([vcs[i] isKindOfClass:[SavedWordListViewController class]])
        {
            SavedWordListViewController *vc = (SavedWordListViewController *)vcs[i];
            vc.repo = _repo;
        }
        else if([vcs[i] isKindOfClass:[AllWordListViewController class]])
        {
            AllWordListViewController *vc = (AllWordListViewController *)vcs[i];
            vc.repo = _repo;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
