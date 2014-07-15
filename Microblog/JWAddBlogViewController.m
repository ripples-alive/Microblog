//
//  JWAddBlogViewController.m
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWAddBlogViewController.h"

#define KEYBOARD_HEIGHT 216.0

@interface JWAddBlogViewController ()

// Withdraw keyboard when recognized tap gesture.
- (void)viewTapped:(UITapGestureRecognizer *)tap;

@end

@implementation JWAddBlogViewController {
    NSString *content;
}

@synthesize delegate;

@synthesize inputView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Set input view border.
    self.inputView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.inputView.layer.borderWidth = 1.0;
    self.inputView.layer.cornerRadius = 5.0;
    
    // Hide table view cell's seperator.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Add tap gesture.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(viewTapped:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
    
    // Forbid the table view cell to be selected.
    [(UITableViewCell *)self.inputView.superview.superview.superview setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
 */

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    // Calc differ between the pos of keyboard and text view.
    CGRect frame = textView.frame;
    CGFloat offset = [textView convertPoint:frame.origin toView:nil].y + frame.size.height -
        (self.view.frame.size.height - KEYBOARD_HEIGHT);
    
    // Move the whole view up if offset is negative.
    if (offset > 0) {
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [UIView commitAnimations];
}

- (void)textViewDidChange:(UITextView *)textView
{
    // Calc differ between the pos of keyboard and text view.
//    CGRect textRect = [textView.attributedText boundingRectWithSize:textView.frame.size
//                                                            options:NSStringDrawingUsesLineFragmentOrigin
//                                                            context:nil];
    CGFloat offset = [textView convertPoint:textView.frame.origin toView:nil].y
        + MIN(textView.contentSize.height, textView.frame.size.height)
        - (self.view.frame.size.height - KEYBOARD_HEIGHT);
    
    // Move the whole view up if offset is negative.
    if (offset > 0) {
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:0.3f];
        self.view.frame = CGRectMake(0, -offset, self.view.frame.size.width, self.view.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    // Move the whole view back.
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
}


- (IBAction)cancel:(id)sender
{
    // Close current scene and return.
    [self.delegate addBlogViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    // Get content from input view.
    content = self.inputView.text;
    
    // Judge whether content is empty.
    if ((content == nil) || [content isEqualToString:@""]) {
        [self cancel:sender];
        return;
    }
    
    // Add new blog and close current scene.
    [self.delegate addBlogViewController:self didAddBlog:self.inputView.text];
}

// Withdraw keyboard when recognized tap gesture.
- (void)viewTapped:(UITapGestureRecognizer *)tap
{
    // Withdraw the keyboard.
    [self.inputView resignFirstResponder];
}

@end
