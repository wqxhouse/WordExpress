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
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saved"];
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"saved"];
    }
    Word *word = self.repo.wordList[indexPath.row];
    cell.textLabel.text = word.word;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.repo.wordList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Word *word = self.repo.wordList[indexPath.row];
    [self performSegueWithIdentifier:@"savedToWordDetail" sender:word];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[WordDetailViewController class]])
    {
        WordDetailViewController *vc = segue.destinationViewController;
        vc.word = sender;
    }
}

@end
