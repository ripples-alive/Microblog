//
//  JWShowBlogViewController.m
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWShowBlogViewController.h"

@interface JWShowBlogViewController ()

@end

@implementation JWShowBlogViewController

@synthesize delegate;
@synthesize blog;

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
    
    NSLog(@"%@", blog);
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

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // Delete blog.
        [self.delegate showBlogViewController:self didDeleteBlog:self.blog];
    }
}

- (IBAction)deleteBlog:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:@"确定删除吗？"
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:@"取消", nil];
    [alert show];
}

@end
