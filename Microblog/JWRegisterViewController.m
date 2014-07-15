//
//  JWRegisterViewController.m
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWRegisterViewController.h"

#define KEYBOARD_HEIGHT 216.0

@interface JWRegisterViewController ()

// Show alert with error info.
- (void)showAlert:(NSString *)errorInfo;
// Check whether username is legal.
- (BOOL)checkUsername:(NSString *)theUsername;
// Check whether password is legal.
- (BOOL)checkPassword:(NSString *)thePassword;
// Check whether confirmed password is the same as password.
- (BOOL)checkPswdConfirm:(NSString *)thePswdConfirm password:(NSString *)thePassword;
// Check whether nickname is legal.
- (BOOL)checkNickname:(NSString *)theNickname;
// Withdraw keyboard when recognized tap gesture.
- (void)viewTapped:(UITapGestureRecognizer *)tap;

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
    
    // Set password field to secure mode.
    self.passwordField.secureTextEntry = YES;
    self.pswdConfirmField.secureTextEntry = YES;
    
    // Add tap gesture.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Show navigation bar.
    self.navigationController.navigationBarHidden = NO;
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
    // Deal with the reflection when press enter in the text field.
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self.pswdConfirmField becomeFirstResponder];
    } else if (textField == self.pswdConfirmField) {
        [self.nicknameField becomeFirstResponder];
    } else if (textField == self.nicknameField) {
        [self.nicknameField resignFirstResponder];
        [self registerUser:nil];
    }
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // Calc differ between the pos of keyboard and text field.
    CGRect frame = textField.frame;
    CGFloat offset = frame.origin.y + frame.size.height -
        (self.view.frame.size.height - KEYBOARD_HEIGHT);
    
    // Move the whole view up if offset is positive.
    if (offset > 0) {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3f];
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    // Move the whole vim back.
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}

// Show alert with error info.
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
    if ([self checkUsername:username] && [self checkPassword:password] &&
        [self checkPswdConfirm:pswdConfirm password:password] && [self checkNickname:nickname]) {
        // The input is valid.
        // Create new user and register.
        JWUser *theUser = [[JWUser alloc] init];
        theUser.username = username;
        theUser.password = password;
        theUser.nickname = nickname;
        [self.delegate registerViewController:self didRegisterUser:theUser];
    }
    
}

// Check whether username is legal.
- (BOOL)checkUsername:(NSString *)theUsername
{
    if ((theUsername == nil) || [theUsername isEqualToString:@""]) {
        [self showAlert:@"请输入用户名！"];
        return NO;
    }
    if (([theUsername length] < 6) || ([theUsername length] > 16)) {
        [self showAlert:@"请输入6-16位用户名！"];
        return NO;
    }
    return YES;
}

// Check whether password is legal.
- (BOOL)checkPassword:(NSString *)thePassword
{
    if ((thePassword == nil) || [thePassword isEqualToString:@""]) {
        [self showAlert:@"请输入密码！"];
        return NO;
    }
    if (([thePassword length] < 6) || ([thePassword length] > 16)) {
        [self showAlert:@"请输入6-16位密码！"];
        return NO;
    }
    return YES;
}

// Check whether confirmed password is the same as password.
- (BOOL)checkPswdConfirm:(NSString *)thePswdConfirm password:(NSString *)thePassword
{
    if (![thePswdConfirm isEqualToString:thePassword]) {
        [self showAlert:@"两次密码不一致！"];
        return NO;
    }
    return YES;
}

// Check whether username is legal.
- (BOOL)checkNickname:(NSString *)theNickname
{
    if ((theNickname == nil) || [theNickname isEqualToString:@""]) {
        [self showAlert:@"请输入昵称"];
        return NO;
    }
    if (([theNickname length] < 6) || ([theNickname length] > 16)) {
        [self showAlert:@"请输入6-16位昵称！"];
        return NO;
    }
    return YES;
}

// Withdraw keyboard when recognized tap gesture.
- (void)viewTapped:(UITapGestureRecognizer *)tap
{
    // Withdraw the keyboard.
    [self.nicknameField becomeFirstResponder];
    [self.nicknameField resignFirstResponder];
}

@end
