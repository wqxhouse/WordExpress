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
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@end

@implementation WordDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.wordLabel.text = self.word.word;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = false;
    if(self.saved)
    {
        //[self.saveButton setTitle:@"UnSave" forState:UIControlStateNormal];
        UIImage *img = [UIImage imageNamed:@"Star_full"];
        [self.saveButton setImage:img forState:UIControlStateNormal];
    }
    else
    {
        //[self.saveButton setTitle:@"Save" forState:UIControlStateNormal];
        [self.saveButton setImage:[UIImage imageNamed:@"Star_empty"] forState:UIControlStateNormal];
    }
    
    // set swipe
    UISwipeGestureRecognizer *swipeLeftGesture=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesture:)];
    [self.view addGestureRecognizer:swipeLeftGesture];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionDown;
    self.tableView.backgroundColor = [UIColor clearColor];
}

-(void)handleSwipeGesture:(UIGestureRecognizer *) sender
{
    NSUInteger touches = sender.numberOfTouches;
    if (touches == 1)
    {
        if (sender.state == UIGestureRecognizerStateEnded)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
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
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.word.meanings count];
}

- (IBAction)saveButtonClicked:(id)sender
{
    UIButton *btn = sender;
    if(self.saved)
    {
        //[btn setTitle:@"Save" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Star_empty"] forState:UIControlStateNormal];
        [self.delegate unsaveWord:self.word];
        self.saved = false;
    }
    else
    {
        //[btn setTitle:@"Unsave" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"Star_full"] forState:UIControlStateNormal];
        [self.delegate saveWord:self.word];
        self.saved = true;
    }
    
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
