//
//  JWAppDelegate.h
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#include "JWBlog.h"
#include "Blog.h"
#include "JWUser.h"

@interface JWAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

- (NSArray *)runFetchRequest:(NSFetchRequest *)fetchRequest;
// Fetch the blogs which is published by a certain author.
- (NSArray *)fetchBlogs:(NSString *)nickname;
// Fetch the user whose username and password matches the given one.
- (NSArray *)fetchMatchUsername:(NSString *)username matchPassword:(NSString *)password;
// Fetch the user whose username matches the given one.
- (NSArray *)fetchMatchUsername:(NSString *)username;
// Fetch the user whose nickname matches the given one.
- (NSArray *)fetchMatchNickname:(NSString *)nickname;
- (void)insertBlog:(JWBlog *)theBlog;
- (void)deleteBlog:(Blog *)blog;
- (void)insertUser:(JWUser *)theUser;

@end
