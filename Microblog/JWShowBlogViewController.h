//
//  JWShowBlogViewController.h
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"
#import "JWMyLabel.h"

@class JWShowBlogViewController;

@protocol JWDeleteBlogDelegate <NSObject>

- (void)showBlogViewController:(JWShowBlogViewController *)controller didDeleteBlog:(Blog *)blog;

@end

@interface JWShowBlogViewController : UIViewController

@property (nonatomic, weak) id <JWDeleteBlogDelegate> delegate;
@property (nonatomic, strong) Blog *blog; // Reserve the blog to be shown on the screen.

@property (strong, nonatomic) IBOutlet JWMyLabel *contentLabel;
//@property (strong, nonatomic) IBOutlet UITextView *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *authorLabel;
@property (strong, nonatomic) IBOutlet UILabel *datetimeLabel;

- (IBAction)deleteBlog:(id)sender;

@end
