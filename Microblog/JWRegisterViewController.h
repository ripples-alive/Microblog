//
//  JWRegisterViewController.h
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JWUser.h"

@class JWRegisterViewController;

@protocol JWRegisterDelegate <NSObject>

- (void)registerViewController:(JWRegisterViewController *)controller didRegisterUser:(JWUser *)theUser;

@end

@interface JWRegisterViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id <JWRegisterDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextField *usernameField;
@property (nonatomic, strong) IBOutlet UITextField *passwordField;
@property (nonatomic, strong) IBOutlet UITextField *pswdConfirmField;
@property (nonatomic, strong) IBOutlet UITextField *nicknameField;

- (IBAction)registerUser:(id)sender;

@end
