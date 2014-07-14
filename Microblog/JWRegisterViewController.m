//
//  JWRegisterViewController.m
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWRegisterViewController.h"

@interface JWRegisterViewController ()

@end

@implementation JWRegisterViewController {
    NSString *username;
    NSString *password;
    NSString *pswdConfirm;
    NSString *nickname;
}

@synthesize delegate;

@synthesize usernameField;
@synthesize passwordField;
@synthesize pswdConfirmField;
@synthesize nicknameField;

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
    // Do any additional setup after loading the view.
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self.pswdConfirmField becomeFirstResponder];
    } else if (textField == self.pswdConfirmField) {
        [self.nicknameField becomeFirstResponder];
    } else if (textField == self.nicknameField) {
        [self registerUser:nil];
    }
    
    return YES;
}

- (void)showAlert:(NSString *)errorInfo
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:errorInfo
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)registerUser:(id)sender
{
    // Get info from input textfield.
    username = self.usernameField.text;
    password = self.passwordField.text;
    pswdConfirm = self.pswdConfirmField.text;
    nickname = self.nicknameField.text;
    
    // Check whether input is valid.
    if ([username isEqualToString:@""]) {
        [self showAlert:@"请输入用户名！"];
    } else if ([password isEqualToString:@""]) {
        [self showAlert:@"请输入密码！"];
    } else if (![password isEqualToString:pswdConfirm]) {
        [self showAlert:@"两次密码不一致！"];
    } else if ([nickname isEqualToString:@""]) {
        [self showAlert:@"请输入昵称"];
    } else {
        // The input is valid.
        // Create new user and register.
        JWUser *theUser = [[JWUser alloc] init];
        theUser.username = username;
        theUser.password = password;
        theUser.nickname = nickname;
        [self.delegate registerViewController:self didRegisterUser:theUser];
    }
    
}

@end
