//
//  MainViewController.m
//  warmup2
//
//  Created by Gavin Chu on 9/27/14.
//  Copyright (c) 2014 cs169. All rights reserved.
//

#import "MainViewController.h"
#import "LogoutViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

NSString * const DEFAULT = @"Please enter your credentials below";
NSString * const ERR_BAD_CREDENTIALS = @"Invalid username and password combination. Please try again.";
NSString * const ERR_BAD_USERNAME = @"The user name should be non-empty and at most 128 characters long. Please try again.";
NSString * const ERR_BAD_PASSWORD = @"The password should be at most 128 characters long. Please try again.";
NSString * const ERR_USER_EXISTS = @"This username already exists. Please try again.";
NSString * const SERVER_ERROR = @"Server unavailable! Please try again later.";

NSMutableData *_responseData;
int loginCount;
NSDictionary *errorDict;
NSInteger errorCode;

+ (void)initialize
{
    errorDict = @{
                  @"0"  : DEFAULT,
                  @"-1" : ERR_BAD_CREDENTIALS,
                  @"-3" : ERR_BAD_USERNAME,
                  @"-4" : ERR_BAD_PASSWORD,
                  @"-2" : ERR_USER_EXISTS
                  };
    errorCode = 0;
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]]];
    _messageText.text = DEFAULT;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginClicked:(UIButton *)sender {
    NSLog(@"login button clicked");
    errorCode = 0;
    // Send a synchronous request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://cs169-fn-warmup.herokuapp.com/users/login"]];
    urlRequest.HTTPMethod = @"POST";
    [urlRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = [NSString stringWithFormat: @"{\"user\":\"%@\", \"password\":\"%@\"}", _usernameText.text, _passwordText.text];
    NSLog(@"%@", stringData);
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = requestBodyData;
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (error == nil)
    {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", responseString);
        
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        
        if (!jsonResponse) {
            NSLog(@"Error parsing JSON: %@", error);
            _messageText.text = SERVER_ERROR;
        } else {
//            for(NSString *key in [jsonResponse allKeys]) {
//                NSLog(@"%@: %@", key, [jsonResponse objectForKey:key]);
//            }
            errorCode = [[jsonResponse objectForKey:@"errCode"] intValue];
            loginCount = [[jsonResponse objectForKey:@"count"] intValue];
            if (errorCode < 0) {
                _messageText.text = [errorDict objectForKey:[NSString stringWithFormat: @"%zd", errorCode]];
            } else {
                [self performSegueWithIdentifier:@"success" sender:self];
            }
        }
    } else {
        _messageText.text = SERVER_ERROR;
    }
}

- (IBAction)addUserClicked:(UIButton *)sender {
    NSLog(@"add button clicked");
    errorCode = 0;
    
    // Send a synchronous request
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://cs169-fn-warmup.herokuapp.com/users/add"]];
    urlRequest.HTTPMethod = @"POST";
    [urlRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    // Convert your data and set your request's HTTPBody property
    NSString *stringData = [NSString stringWithFormat: @"{\"user\":\"%@\", \"password\":\"%@\"}", _usernameText.text, _passwordText.text];
    NSLog(@"%@", stringData);
    NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = requestBodyData;
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    if (error == nil) {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", responseString);
        
        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &error];
        
        if (!jsonResponse) {
            NSLog(@"Error parsing JSON: %@", error);
            _messageText.text = SERVER_ERROR;
        } else {
//            for(NSString *key in [jsonResponse allKeys]) {
//                NSLog(@"%@: %@", key, [jsonResponse objectForKey:key]);
//            }
            errorCode = [[jsonResponse objectForKey:@"errCode"] intValue];
            loginCount = [[jsonResponse objectForKey:@"count"] intValue];
            if (errorCode < 0) {
                _messageText.text = [errorDict objectForKey:[NSString stringWithFormat: @"%zd", errorCode]];
            } else {
                [self performSegueWithIdentifier:@"success" sender:self];
            }
        }
    } else {
        _messageText.text = SERVER_ERROR;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"success"]) {
        NSLog(@"preparingForSegue");
        self.username = self.usernameText.text;
        self.count = loginCount;
        
        LogoutViewController *vc = [segue destinationViewController];
        vc.t1 = [NSString stringWithFormat:@"Welcome %@", self.username];
        vc.t2 = [NSString stringWithFormat:@"You have logged in %zd times.", self.count];
    } else {
        return;
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
