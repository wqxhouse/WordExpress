//
//  ViewController.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "ViewController.h"
#import "WordRepository.h"
#import "IdentificationViewController.h"
#import "SynonmyViewController.h"
#import "WordListTabBarController.h"

@interface ViewController ()
@property (nonatomic, strong) WordRepository *repo;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _repo = [[WordRepository alloc] init];
    
    [_repo gen_excelWordList];
    [_repo gen_wordList];
}

- (IBAction)wordListClicked: (id)sender
{
    [self performSegueWithIdentifier:@"ShowWordList" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)to_id:(id)sender
{
    [self performSegueWithIdentifier:@"identification" sender:nil];
    
}

- (IBAction)to_sy:(id)sender
{
    [self performSegueWithIdentifier:@"Synonym" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"identification"])
    {
        IdentificationViewController *vc = segue.destinationViewController;
        vc.repo = _repo;
    }
    else if([segue.identifier isEqualToString:@"Synonym"])
    {
        SynonmyViewController *vc = segue.destinationViewController;
        vc.repo = _repo;
    }
    else if([segue.identifier isEqualToString:@"ShowWordList"])
    {
        WordListTabBarController *tabVC = segue.destinationViewController;
        tabVC.repo = _repo;
    }
}

#pragma mark SettingsDelegate
- (void)changeWordSource: (NSInteger)wordSource
{
    if(wordSource == 0)
    {
        [self.repo gen_wordList];
    }
    else if(wordSource == 1)
    {
        [self.repo gen_excelWordList];
    }
}

@end
