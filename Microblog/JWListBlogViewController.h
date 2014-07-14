//
//  JWListBlogViewController.h
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JWAddBlogViewController.h"
#import "JWShowBlogViewController.h"

@interface JWListBlogViewController : UITableViewController <JWAddBlogDelegate, JWDeleteBlogDelegate>

@property (nonatomic, copy) NSString *loginUser;

@end
