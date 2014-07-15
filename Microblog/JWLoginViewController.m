//
//  JWLoginViewController.m
//  Microblog
//
//  Created by Jayvic on 14-7-12.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWLoginViewController.h"
#import "JWListBlogViewController.h"
#import "JWAppDelegate.h"
#import "User.h"

#define REGISTER_SUCCESSFUL_ALERT 1
#define KEYBOARD_HEIGHT 216.0

@interface JWLoginViewController ()

// Show alert with error info.
- (void)showAlert:(NSString *)errorInfo;
// Withdraw keyboard when recognized tap gesture.
- (void)viewTapped:(UITapGestureRecognizer *)tap;

@end

@implementation JWLoginViewController {
    NSString *username;
    NSString *password;
    NSString *nickname;
}

@synthesize usernameField;
@synthesize passwordField;

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
    
    // Add tap gesture.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    // Restore the username used last time.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    username = [userDefaults objectForKey:@"username"];
    self.usernameField.text = username;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Hide navigation bar.
    self.navigationController.navigationBarHidden = YES;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Login"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        JWListBlogViewController *listBlogViewController = [[navigationController viewControllers] firstObject];
        
        // Set login user's nickname for list blog view controller.
        listBlogViewController.loginUser = nickname;
    } else if ([segue.identifier isEqualToString:@"Register"]) {
        JWRegisterViewController *registerViewController = [segue destinationViewController];
        
        // Set delegate for register view controller.
        registerViewController.delegate = self;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // Deal with the reflection when press enter in the text field.
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    } else if (textField == self.passwordField) {
        [self.passwordField resignFirstResponder];
        [self login:nil];
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
    // Move the whole view back.
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

// Auto login when close the alert shown successful info of register.
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == REGISTER_SUCCESSFUL_ALERT) {
        // Auto login.
        [self login:nil];
    }
}

- (void)registerViewController:(JWRegisterViewController *)controller didRegisterUser:(JWUser *)theUser
{
    // Get app delegate.
    JWAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    // Check whether username haven't been used.
    NSArray *results = [appDelegate fetchMatchUsername:theUser.username];
    if ([results count] > 0) {
        [self showAlert:@"此用户名已被使用！"];
        return;
    }
    
    // Check whether nickname haven't been used.
    results = [appDelegate fetchMatchNickname:theUser.nickname];
    if ([results count] > 0) {
        [self showAlert:@"此昵称已被使用！"];
        return;
    }
    
    // Add a new user.
    [appDelegate insertUser:theUser];
    
    // Set username and password on the screen.
    self.usernameField.text = theUser.username;
    self.passwordField.text = theUser.password;
    
    // Close the register scene.
    [self.navigationController popViewControllerAnimated:YES];
    
    // Show alert to indicate register is completed.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"恭喜您，注册成功！"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    alert.tag = REGISTER_SUCCESSFUL_ALERT;
    [alert show];
}

- (IBAction)login:(id)sender
{
    // Get username and password from view.
    username = self.usernameField.text;
    password = self.passwordField.text;
    
    // Fetch results which match inputed username and password.
    NSArray *results = [(JWAppDelegate *)[[UIApplication sharedApplication] delegate]
                        fetchMatchUsername:username matchPassword:password];
    
    // Judge whether the username and password is correct.
    if ([results count] > 0) {
        // Reserve username to user defaults.
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:username forKey:@"username"];
        [userDefaults synchronize];
        
        // Get nickname.
        User *theUser = [results firstObject];
        nickname = theUser.nickname;
        
        // Change to list blog scene.
        [self performSegueWithIdentifier:@"Login" sender:self];
    } else {
        // Username or password wrong, alert.
        [self showAlert:@"帐号或密码错误！"];
    }
}

// Withdraw keyboard when recognized tap gesture.
- (void)viewTapped:(UITapGestureRecognizer *)tap
{
    // Withdraw the keyboard.
    [self.passwordField becomeFirstResponder];
    [self.passwordField resignFirstResponder];
}

@end
