//
//  JWShowBlogViewController.h
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Blog.h"

@class JWShowBlogViewController;

@protocol JWDeleteBlogDelegate <NSObject>

- (void)showBlogViewController:(JWShowBlogViewController *)controller didDeleteBlog:(Blog *)blog;

@end

@interface JWShowBlogViewController : UIViewController

//@property (nonatomic, strong) IBOutlet

@property (nonatomic, weak) id <JWDeleteBlogDelegate> delegate;
@property (nonatomic, strong) Blog *blog;

- (IBAction)deleteBlog:(id)sender;

@end
