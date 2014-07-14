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

@interface JWLoginViewController ()

@end

@implementation JWLoginViewController {
    NSString *username;
    NSString *password;
    NSString *nickname;
}

@synthesize usernameLabel;
@synthesize passwordLabel;

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"Login"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        JWListBlogViewController *listBlogViewController = [[navigationController viewControllers] firstObject];
        listBlogViewController.loginUser = nickname;
    } else if ([segue.identifier isEqualToString:@"Register"]) {
        JWRegisterViewController *registerViewController = [segue destinationViewController];
        registerViewController.delegate = self;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameLabel) {
        [self.passwordLabel becomeFirstResponder];
    } else if (textField == self.passwordLabel) {
        [self login:nil];
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
    self.usernameLabel.text = theUser.username;
    self.passwordLabel.text = theUser.password;
    
    // Close the register scene.
    [self.navigationController popViewControllerAnimated:YES];
    
    // Auto login.
    [self login:nil];
}

- (IBAction)login:(id)sender
{
    // Get username and password from view.
    username = self.usernameLabel.text;
    password = self.passwordLabel.text;
    
    // Fetch results which match inputed username and password.
    NSArray *results = [(JWAppDelegate *)[[UIApplication sharedApplication] delegate]
                        fetchMatchUsername:username matchPassword:password];
    
    // Judge whether the username and password is correct.
    if ([results count] > 0) {
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

@end
