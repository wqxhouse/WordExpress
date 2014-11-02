//
//  AllWordListViewController.m
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "AllWordListViewController.h"
#import "Word.h"
#import "WordDetailViewController.h"

@interface AllWordListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *searchResults;
@end

@implementation AllWordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = backgroundView.bounds;
    UIColor *startColor = [UIColor colorWithRed: 90./255.
                                          green:200./255.
                                           blue:251./255.
                                          alpha:1.0];
    UIColor *endColor   = [UIColor colorWithRed: 82./255.
                                          green:237./255.
                                           blue:199./255.
                                          alpha:1.0];
    
    gradient.colors = @[(id)startColor.CGColor, (id)endColor.CGColor];
    [backgroundView.layer addSublayer:gradient];
    self.tableView.backgroundView = backgroundView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)mainButtonClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saved"];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saved"];
    }
    Word *word = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        word  =self.searchResults[indexPath.row];
    }
    else
    {
        word = self.repo.exWordList[indexPath.row];
    }
    cell.textLabel.text = word.word;
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    else
    {
        return [self.repo.exWordList count];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Word *word = nil;
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        word = self.searchResults[indexPath.row];
    }
    else
    {
        word = self.repo.exWordList[indexPath.row];
    }
    [self performSegueWithIdentifier:@"allToWordDetail" sender:word];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"word contains[cd] %@", searchText];
    self.searchResults = [self.repo.exWordList filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

#pragma mark - WordDetailDelegate
- (void)saveWord:(Word *)word
{
    [self.repo.wordAssoc setObject:word forKeyedSubscript:word.word];
    [self.repo.wordList addObject:word];
}

- (void)unsaveWord:(Word *)word
{
    [self.repo.wordAssoc removeObjectForKey:word.word];
    [self.repo.wordList removeObject:word];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[WordDetailViewController class]])
    {
        WordDetailViewController *vc = (WordDetailViewController *)segue.destinationViewController;
        vc.word = sender;
        Word *word = sender;
        vc.delegate = self;
        if([self.repo.wordAssoc objectForKey: word.word])
        {
            vc.saved = true;
        }
        else
        {
            vc.saved = false;
        }

    }
}

@end
