//
//  JWLoginViewController.h
//  Microblog
//
//  Created by Jayvic on 14-7-12.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "JWRegisterViewController.h"

@interface JWLoginViewController : UIViewController <JWRegisterDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *usernameLabel;
@property (nonatomic, strong) IBOutlet UITextField *passwordLabel;

- (IBAction)login:(id)sender;

@end
