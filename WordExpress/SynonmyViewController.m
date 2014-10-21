//
//  SynonmyViewController.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "SynonmyViewController.h"
#import "TestEntry.h"
#import "Utils.h"
#import "SelectionTableViewCell.h"
#import "WordRepository.h"

@interface SynonmyViewController ()

@property (nonatomic, strong) NSMutableArray *user_answer;
@property (nonatomic, strong) TestEntry *entry;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SynonmyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView setSeparatorColor:[UIColor clearColor]];
    _user_answer = [[NSMutableArray alloc] init];
    
    [self loadData];
    [self updateUI];
}

- (IBAction)nextBtnClicked:(id)sender
{
    [self loadData];
    [self updateUI];
}

- (void)loadData
{
    _entry = [[TestEntry alloc] init];
    do
    {
        _entry = [_repo gen_ans_sim:[_repo randomWords:1 word:nil][0]];
    } while([_entry.choices count] == 0);
    _wordLabel.text = _entry.word;
    [_user_answer removeAllObjects];
}

- (void)updateUI
{
    self.tableView.userInteractionEnabled = true;
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [self.tableView reloadData];
     } completion:nil];
}

- (void)clearCell: (SelectionTableViewCell *)cell
{
    cell.selectedStatus = false;
    [self unboldFontForCell:cell];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"word_entry"];
    if(cell == nil)
    {
        cell = [[[SelectionTableViewCell alloc] init] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"word_entry"];
    }
    NSString *letter = [@"   " stringByAppendingString:[Utils convertNumToCharStr:indexPath.row]];
    
    [self clearCell:cell];
    cell.textLabel.text = [[letter stringByAppendingString:@". "] stringByAppendingString:self.entry.choices[indexPath.row]];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    cell.textLabel.layer.masksToBounds = YES;
    cell.textLabel.layer.cornerRadius = 20;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.entry.choices count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectionTableViewCell *cell = (SelectionTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if(cell.selectedStatus == true)
    {
        cell.selectedStatus = false;
        [self unboldFontForCell:cell];
        cell.selected = false;
        [_user_answer removeObject:@(indexPath.row)];
    }
    else
    {
        cell.selectedStatus = true;
        [self boldFontForCell:cell];
        cell.selected = false;
        [_user_answer addObject:@(indexPath.row)];
    }
}
- (IBAction)checkBtnClicked:(id)sender
{
    [self checkAnswer];
    self.tableView.userInteractionEnabled = false;
}

- (void)checkAnswer
{
    for(int i = 0; i < [self.entry.answers count]; i++)
    {
        SelectionTableViewCell *cell = (SelectionTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.entry.answers[i] intValue] inSection:0]];
        [cell.textLabel setBackgroundColor:[UIColor colorWithRed:0.529 green:0.900 blue:0.439 alpha:0.8]];
        [cell.textLabel setFont:[UIFont systemFontOfSize:cell.textLabel.font.pointSize]];
    }
    
    for(int i = 0; i < [self.user_answer count]; i++)
    {
        SelectionTableViewCell *cell = (SelectionTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:[self.user_answer[i] intValue] inSection:0]];
        if(![self.entry.answers containsObject:self.user_answer[i]])
        {
            [cell.textLabel setBackgroundColor:[UIColor colorWithRed:0.92 green:0.60 blue:0.60 alpha:0.8]];
            [cell.textLabel setFont:[UIFont systemFontOfSize:cell.textLabel.font.pointSize]];
        }
        else
        {
            [cell.textLabel setBackgroundColor:[UIColor colorWithRed:0.529 green:0.988 blue:0.439 alpha:0.8]];
            [cell.textLabel setFont:[UIFont boldSystemFontOfSize:cell.textLabel.font.pointSize]];
        }
    }
}

- (void)boldFontForCell:(UITableViewCell *)cell
{
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [cell.textLabel setFont:[UIFont boldSystemFontOfSize:cell.textLabel.font.pointSize]];
         [cell.textLabel setBackgroundColor: [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:0.7]];
     } completion:nil];
    
}

- (void)unboldFontForCell: (UITableViewCell *)cell
{
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [cell.textLabel setFont:[UIFont systemFontOfSize:cell.textLabel.font.pointSize]];
         [cell.textLabel setBackgroundColor:[UIColor clearColor]];
     } completion:nil];
    
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
