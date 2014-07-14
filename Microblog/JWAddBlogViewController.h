//
//  JWAddBlogViewController.h
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JWBlog.h"
#import "Blog.h"

@class JWAddBlogViewController;

@protocol JWAddBlogDelegate <NSObject>

- (void)addBlogViewController:(JWAddBlogViewController *)controller didAddBlog:(NSString *)content;
- (void)addBlogViewControllerDidCancel:(JWAddBlogViewController *)controller;

@end

@interface JWAddBlogViewController : UITableViewController

@property (nonatomic, weak) id <JWAddBlogDelegate> delegate;

@property (nonatomic, strong) IBOutlet UITextView *inputView;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
