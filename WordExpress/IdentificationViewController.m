//
//  IdentificationViewController.m
//  WordExpress
//
//  Created by Robin Wu on 10/20/14.
//  Copyright (c) 2014 WSH. All rights reserved.
//

#import "IdentificationViewController.h"
#import "TestEntry.h"
#import "WordRepository.h"

@interface IdentificationViewController ()
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *ALabel;
@property (weak, nonatomic) IBOutlet UILabel *BLabel;
@property (weak, nonatomic) IBOutlet UILabel *CLabel;
@property (weak, nonatomic) IBOutlet UILabel *DLabel;
@property (weak, nonatomic) IBOutlet UILabel *ELabel;
@property (nonatomic, strong) NSMutableDictionary *highlight_info;
@property (nonatomic, strong) TestEntry *entry;
@property (nonatomic, strong) NSMutableArray *userAnswer;

@end

@implementation IdentificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _userAnswer = [[NSMutableArray alloc] init];
    _highlight_info = [[NSMutableDictionary alloc] init];
    [_highlight_info setObject:[NSNumber numberWithBool:false] forKey:[NSNumber numberWithInteger:self.ALabel.tag]];
    [_highlight_info setObject:[NSNumber numberWithBool:false] forKey:[NSNumber numberWithInteger:self.BLabel.tag]];
    [_highlight_info setObject:[NSNumber numberWithBool:false] forKey:[NSNumber numberWithInteger:self.CLabel.tag]];
    [_highlight_info setObject:[NSNumber numberWithBool:false] forKey:[NSNumber numberWithInteger:self.DLabel.tag]];
    [_highlight_info setObject:[NSNumber numberWithBool:false] forKey:[NSNumber numberWithInteger:self.ELabel.tag]];
    
    _ALabel.layer.masksToBounds = true;
    _BLabel.layer.masksToBounds = true;
    _CLabel.layer.masksToBounds = true;
    _DLabel.layer.masksToBounds = true;
    _ELabel.layer.masksToBounds = true;
    
    _ALabel.layer.cornerRadius = 16;
    _BLabel.layer.cornerRadius = 16;
    _CLabel.layer.cornerRadius = 16;
    _DLabel.layer.cornerRadius = 16;
    _ELabel.layer.cornerRadius = 16;
    
    // Do any additional setup after loading the view.
    [self gen_data];
    [self loadUI];
}

- (IBAction)next_clicked:(UIBarButtonItem *)sender
{
    [_userAnswer removeAllObjects];
    [_highlight_info removeAllObjects];
    [self clearUI];
    [self gen_data];
    [self loadUI];
}

- (void) clearUI
{
    _ALabel.userInteractionEnabled = true;
    _BLabel.userInteractionEnabled = true;
    _CLabel.userInteractionEnabled = true;
    _DLabel.userInteractionEnabled = true;
    _ELabel.userInteractionEnabled = true;
    [_ALabel setFont: [UIFont systemFontOfSize:_ALabel.font.pointSize]];
    [_BLabel setFont: [UIFont systemFontOfSize:_ALabel.font.pointSize]];
    [_CLabel setFont: [UIFont systemFontOfSize:_ALabel.font.pointSize]];
    [_DLabel setFont: [UIFont systemFontOfSize:_ALabel.font.pointSize]];
    [_ELabel setFont: [UIFont systemFontOfSize:_ALabel.font.pointSize]];
    [_ALabel setBackgroundColor:[UIColor clearColor]];
    [_BLabel setBackgroundColor:[UIColor clearColor]];
    [_CLabel setBackgroundColor:[UIColor clearColor]];
    [_DLabel setBackgroundColor:[UIColor clearColor]];
    [_ELabel setBackgroundColor:[UIColor clearColor]];
    
}

- (void)gen_data
{
    _entry = [_repo gen_ans_ch:[_repo randomWords:1 word:nil][0]];
    _wordLabel.text = self.entry.word;
}

- (void)loadUI
{
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         _ALabel.text = [@"   A. " stringByAppendingString:self.entry.choices[0]];
         _BLabel.text = [@"   B. " stringByAppendingString:self.entry.choices[1]];
         _CLabel.text = [@"   C. " stringByAppendingString:self.entry.choices[2]];
         _DLabel.text = [@"   D. " stringByAppendingString:self.entry.choices[3]];
         _ELabel.text = [@"   E. " stringByAppendingString:self.entry.choices[4]];
     }
                    completion: ^(BOOL isFinished)
     {
     }];
    
}

- (IBAction)checkBtnClicked:(id)sender
{
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [self checkAnswer];
     } completion:nil];
    self.ALabel.userInteractionEnabled = false;
    self.BLabel.userInteractionEnabled = false;
    self.CLabel.userInteractionEnabled = false;
    self.DLabel.userInteractionEnabled = false;
    self.ELabel.userInteractionEnabled = false;
}

- (void)checkAnswer
{
    
    for(int i = 0; i < [self.entry.answers count]; i++)
    {
        NSNumber *tagNum = [NSNumber numberWithInteger: [self.entry.answers[i] intValue] + 100];
        UILabel *label = (UILabel *)[self.view viewWithTag:[tagNum intValue]];
        [label setBackgroundColor:[UIColor colorWithRed:0.529 green:0.900 blue:0.439 alpha:0.8]];
        [label setFont:[UIFont systemFontOfSize:label.font.pointSize]];
    }
    
    for(int i = 0; i < [self.userAnswer count]; i++)
    {
        NSNumber *tagNum = [NSNumber numberWithInteger: [self.userAnswer[i] intValue] + 100];
        UILabel *label = (UILabel *)[self.view viewWithTag:[tagNum intValue]];
        if(![self.entry.answers containsObject:self.userAnswer[i]])
        {
            [label setBackgroundColor:[UIColor colorWithRed:0.92 green:0.60 blue:0.60 alpha:0.7]];
            [label setFont:[UIFont systemFontOfSize:label.font.pointSize]];
        }
        else
        {
            [label setBackgroundColor:[UIColor colorWithRed:0.529 green:0.988 blue:0.439 alpha:0.8]];
            [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
        }
    }
}

-(void)boldFontForLabel:(UILabel *)label
{
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [label setFont:[UIFont boldSystemFontOfSize:label.font.pointSize]];
         [label setBackgroundColor: [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:0.7]];
     } completion:nil];
    [_highlight_info setObject:[NSNumber numberWithBool:true] forKey:[NSNumber numberWithInteger:label.tag]];
    
}

- (void)unboldFontForLabel: (UILabel *)label
{
    [UIView transitionWithView: self.view
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
        [label setFont:[UIFont systemFontOfSize:label.font.pointSize]];
        [label setBackgroundColor:[UIColor clearColor]];
     } completion:nil];
    [_highlight_info setObject:[NSNumber numberWithBool:false] forKey:[NSNumber numberWithInteger:label.tag]];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if([touch.view isKindOfClass:[UILabel class]])
    {
        UILabel *label = (UILabel *)touch.view;
        if([[_highlight_info objectForKey:[NSNumber numberWithInteger:label.tag]] isEqualToNumber:[NSNumber numberWithBool:false]])
        {
            [self boldFontForLabel: label];
            [self.userAnswer addObject:@(label.tag - 100)];
        }
        else
        {
            [self unboldFontForLabel: label];
            [self.userAnswer removeObject:@(label.tag - 100)];
        }
    }
    
    switch (touch.view.tag) {
        case 100:
            break;
        case 101:
            break;
        case 102:
            break;
        case 103:
            break;
        case 104:
        default:
            break;
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
