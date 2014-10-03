//
//  LogoutViewController.m
//  warmup2
//
//  Created by Gavin Chu on 9/27/14.
//  Copyright (c) 2014 cs169. All rights reserved.
//

#import "LogoutViewController.h"
#import "MainViewController.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

@synthesize t1;
@synthesize t2;

- (IBAction)loadAfterLogin:(UIStoryboardSegue *)segue
{
    NSLog(@"loadAfterLogin");
    MainViewController *source = [segue sourceViewController];
    NSString *username = source.username;
    NSInteger count = source.count;
    _text1.text = [NSString stringWithFormat:@"Welcome %@", username];
    _text2.text = [NSString stringWithFormat:@"You have logged in %zd times.", count];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background2.png"]]];
    _text1.text = t1;
    _text2.text = t2;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
