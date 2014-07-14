//
//  JWListBlogViewController.m
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWListBlogViewController.h"
#import "JWBlog.h"
#import "JWBlogDetailCell.h"
#import "JWAppDelegate.h"
#import "JWShowBlogViewController.h"

#define LIST_BLOG_CELL_HEIGHT 115
#define MORE_CELL_HEIGHT 50

#define BLOG_NUMBER_ONCE 5

@interface JWListBlogViewController ()

@end

@implementation JWListBlogViewController {
//    NSMutableArray *blogs;
    NSArray *blogs;
    NSUInteger numOfBlogsShown;
    BOOL showMore;
//    NSUInteger selectedRow;
}

@synthesize loginUser;

//- (NSUInteger)min:(NSUInteger)firstInt secondInt:(NSUInteger)secondInt
//{
//    return (firstInt > secondInt) ? secondInt : firstInt;
//}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initBlogs
{
    // Fetch blogs by the app delegate.
    blogs = [(JWAppDelegate *)[[UIApplication sharedApplication] delegate] fetchBlogs:self.loginUser];
    
    // Set the number of blogs shown at first.
    numOfBlogsShown = MIN([blogs count], BLOG_NUMBER_ONCE);
    showMore = ([blogs count] > BLOG_NUMBER_ONCE);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    blogs = [[NSMutableArray alloc] init];
//    JWBlog *blog = [[JWBlog alloc] init];
//    blog.author = @"Jayvic";
//    //    blog.datetime = []
//    blog.content = @"Just for test!";
//    [blogs addObject:blog];
//    
//    for (NSUInteger i = 2; i <= 11; ++i) {
//        blog = [[JWBlog alloc] init];
//        blog.author = @"Jayvic";
//        blog.content = [NSString stringWithFormat:@"Blog %d", i];
//        [blogs addObject:blog];
//    }
    
    // Update title of list blog scene.
    self.title = [NSString stringWithFormat:@"%@的微博", self.loginUser];
    
    // Initialize blogs data.
    [self initBlogs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (showMore) {
        return numOfBlogsShown + 1;
    } else {
        return numOfBlogsShown;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == numOfBlogsShown) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"More"
                                                                forIndexPath:indexPath];
        return cell;
    } else {
        JWBlogDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListBlogCell"
                                                                 forIndexPath:indexPath];
        
        // Configure the cell...
        Blog *blog = [blogs objectAtIndex:indexPath.row];
        cell.authorLabel.text = blog.author;
        cell.contentLabel.text = blog.content;
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        cell.datetimeLabel.text = [dateFormatter stringFromDate:blog.datetime];
//        NSString *dateString = [NSDateFormatter localizedStringFromDate:blog.datetime
//                                                              dateStyle:NSDateFormatterShortStyle
//                                                              timeStyle:NSDateFormatterShortStyle];
//        cell.datetimeLabel.text = dateString;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == numOfBlogsShown) {
        return MORE_CELL_HEIGHT;
    } else {
        return LIST_BLOG_CELL_HEIGHT;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([segue.identifier isEqualToString:@"AddBlog"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        JWAddBlogViewController *addBlogViewController = [[navigationController viewControllers] objectAtIndex:0];
        addBlogViewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"ShowBlog"]) {
        // Get the index path of the clicked cell.
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        // Pass the blog to show blog view.
        JWShowBlogViewController *showBlogViewController = [segue destinationViewController];
        showBlogViewController.blog = [blogs objectAtIndex:indexPath.row];
        
        // Set the delegate of show blog view controller.
        showBlogViewController.delegate = self;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Judge whether clicked the "more" cell.
    if (indexPath.row == numOfBlogsShown) {
        // Calc the number of new blogs need to shown.
        NSUInteger newNumOfBlogShown = MIN([blogs count] - numOfBlogsShown, BLOG_NUMBER_ONCE);
        NSMutableArray *newBlogPaths = [[NSMutableArray alloc] init];
        for (NSUInteger i = 0; i < newNumOfBlogShown; ++i) {
            NSIndexPath *path = [NSIndexPath indexPathForRow:numOfBlogsShown + i inSection:0];
            [newBlogPaths addObject:path];
        }
        
        // Add cells for new blogs shown.
        numOfBlogsShown += newNumOfBlogShown;
        [self.tableView insertRowsAtIndexPaths:newBlogPaths
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // Judge whether the "more" cell need to be shown.
        NSIndexPath *path = [NSIndexPath indexPathForRow:numOfBlogsShown inSection:0];
        if ([blogs count] == numOfBlogsShown) {
            // Delete the "more" cell when all the blogs have been shown.
            showMore = NO;
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:path]
                                  withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            // Deselect the "more" cell.
            [self.tableView deselectRowAtIndexPath:path animated:UITableViewRowAnimationAutomatic];
        }
    }
}

- (void)addBlogViewController:(JWAddBlogViewController *)controller didAddBlog:(NSString *)content
{
    // Create new blog.
    JWBlog *theBlog = [[JWBlog alloc] init];
    theBlog.author = self.loginUser;
    theBlog.content = content;
    theBlog.datetime = [NSDate date];
    
    // Insert new blog to database.
    [(JWAppDelegate *)[[UIApplication sharedApplication] delegate] insertBlog:theBlog];
    
    // Close add blog scene.
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Refresh the blogs shown.
    if (numOfBlogsShown > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                              atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    [self initBlogs];
    [self.tableView reloadData];
}

- (void)addBlogViewControllerDidCancel:(JWAddBlogViewController *)controller
{
    // Close add blog scene.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showBlogViewController:(JWShowBlogViewController *)controller didDeleteBlog:(Blog *)blog
{
    [self.navigationController popViewControllerAnimated:YES];
    
    // Get row number of the blog to be deleted.
    NSInteger deleteRow = [blogs indexOfObject:blog];
    
    // Delete blog in the controller.
    NSMutableArray *mutableBlogs = [NSMutableArray arrayWithArray:blogs];
    [mutableBlogs removeObject:blog];
    blogs = [NSArray arrayWithArray:mutableBlogs];
    --numOfBlogsShown;
    
    // Delete the cell from the blog.
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:deleteRow inSection:0];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    
    // Delete blog from database.
    [(JWAppDelegate *)[[UIApplication sharedApplication] delegate] deleteBlog:blog];
}

@end
