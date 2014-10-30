//
//  WordDetailViewController.m
//  WordExpress
//
//  Created by Robin Wu on 10/30/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "WordDetailViewController.h"
#import "Meaning.h"

@interface WordDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation WordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wordLabel.text = self.word.word;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = false;
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
    Meaning *meaning = self.word.meanings[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"(%ld) %@", indexPath.row, meaning.ch];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.word.meanings count];
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
