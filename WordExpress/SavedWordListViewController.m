//
//  SavedWordListViewController.m
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "SavedWordListViewController.h"
#import "Word.h"
#import "WordDetailViewController.h"

@interface SavedWordListViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *searchResults;

@end

@implementation SavedWordListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"word contains[cd] %@", searchText];
    self.searchResults = [self.repo.wordList filteredArrayUsingPredicate:resultPredicate];
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
        word = self.searchResults[indexPath.row];
    }
    else
    {
        word = self.repo.wordList[indexPath.row];
    }
    cell.textLabel.text = word.word;

    return cell;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.searchResults count];
    }
    else
    {
        return [self.repo.wordList count];
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
        word = self.repo.wordList[indexPath.row];
    }
    [self performSegueWithIdentifier:@"savedToWordDetail" sender:word];
}

#pragma mark - WordDetailDelegates
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
        WordDetailViewController *vc = segue.destinationViewController;
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
