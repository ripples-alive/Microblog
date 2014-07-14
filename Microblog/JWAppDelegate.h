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
- (NSArray *)fetchBlogs:(NSString *)nickname;
- (NSArray *)fetchMatchUsername:(NSString *)username matchPassword:(NSString *)password;
- (NSArray *)fetchMatchUsername:(NSString *)username;
- (NSArray *)fetchMatchNickname:(NSString *)nickname;
- (void)insertBlog:(JWBlog *)theBlog;
- (void)deleteBlog:(Blog *)blog;
- (void)insertUser:(JWUser *)theUser;

@end
