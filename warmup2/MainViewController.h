//
//  MainViewController.h
//  warmup2
//
//  Created by Gavin Chu on 9/27/14.
//  Copyright (c) 2014 cs169. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

extern NSString * const DEFAULT;
extern NSString * const ERR_BAD_CREDENTIALS;
extern NSString * const ERR_BAD_USERNAME;
extern NSString * const ERR_BAD_PASSWORD;
extern NSString * const ERR_USER_EXISTS;
extern NSString * const SERVER_ERROR;

@property (weak, nonatomic) IBOutlet UILabel *messageText;
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *addUserButton;

@property NSString *username;
@property (nonatomic, assign) NSInteger count;

@end
