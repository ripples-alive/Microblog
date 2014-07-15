//
//  JWAppDelegate.m
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "JWAppDelegate.h"
#import "Blog.h"
#import "User.h"

@implementation JWAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
//    NSManagedObjectContext *context = self.managedObjectContext;
    
//    NSManagedObject *obj = [NSEntityDescription insertNewObjectForEntityForName:@"User"
//                                                         inManagedObjectContext:context];
//    [obj setValue:@"Jayvic" forKey:@"username"];
//    [obj setValue:@"q" forKey:@"password"];
//    [obj setValue:@"JayvicWen" forKey:@"nickname"];
//    [self saveContext];
    
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User"
//                                              inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
//    for (User *user in result) {
//        NSLog(@"%@", user.username);
//        NSLog(@"%@", user.password);
//        NSLog(@"%@", user.nickname);
//        NSLog(@"%d", [user.blogs count]);
//        for (Blog *blog in user.blogs) {
//            NSLog(@"======");
//            NSLog(@"%@", blog.author);
//            NSLog(@"%@", blog.content);
//            NSLog(@"%@", blog.datetime);
//            NSLog(@"%@", blog.user.nickname);
////            [context deleteObject:blog];
//        }
////        [context deleteObject:user];
//    }
////    [self saveContext];

//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Blog"
//                                              inManagedObjectContext:context];
//    [fetchRequest setEntity:entity];
//    NSError *error;
//    NSArray *result = [context executeFetchRequest:fetchRequest error:&error];
//    NSLog(@"%d", [result count]);
//    for (Blog *blog in result) {
//        NSLog(@"%@", blog);
////        [context deleteObject:blog];
//    }
////    [self saveContext];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MicroblogModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"MicroblogModel.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSArray *)runFetchRequest:(NSFetchRequest *)fetchRequest
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    
    NSArray *results = [managedObjectContext executeFetchRequest:fetchRequest
                                                          error:&error];
    if (error != nil) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return results;
}

// Fetch the blogs which is published by a certain author.
- (NSArray *)fetchBlogs:(NSString *)nickname
{
    // Get fetch request from template.
    NSDictionary *substitution = [NSDictionary dictionaryWithObject:nickname
                                                             forKey:@"NICKNAME"];
    NSFetchRequest *fetchRequest = [self.managedObjectModel
                                    fetchRequestFromTemplateWithName:@"GetMyselfBlog"
                                    substitutionVariables:substitution];
    
    NSSortDescriptor *datetimeSort = [[NSSortDescriptor alloc] initWithKey:@"datetime"
                                                                 ascending:NO];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:datetimeSort]];
    
    return [self runFetchRequest:fetchRequest];
}

// Fetch the user whose username and password matches the given one.
- (NSArray *)fetchMatchUsername:(NSString *)username matchPassword:(NSString *)password
{
    // Get fetch request from template.
    NSDictionary *substitution = [NSDictionary dictionaryWithObjects:@[username,
                                                                       password]
                                                             forKeys:@[@"USERNAME",
                                                                       @"PASSWORD"]];
    NSFetchRequest *fetchRequest = [self.managedObjectModel
                                    fetchRequestFromTemplateWithName:@"CheckLogin"
                                    substitutionVariables:substitution];
    
    return [self runFetchRequest:fetchRequest];
}

// Fetch the user whose username matches the given one.
- (NSArray *)fetchMatchUsername:(NSString *)username
{
    // Get fetch request from template.
    NSDictionary *substitution = [NSDictionary dictionaryWithObject:username forKey:@"USERNAME"];
    NSFetchRequest *fetchRequest = [self.managedObjectModel
                                    fetchRequestFromTemplateWithName:@"GetByUsername"
                                    substitutionVariables:substitution];
    
    return [self runFetchRequest:fetchRequest];
}

// Fetch the user whose nickname matches the given one.
- (NSArray *)fetchMatchNickname:(NSString *)nickname
{
    // Get fetch request from template.
    NSDictionary *substitution = [NSDictionary dictionaryWithObject:nickname forKey:@"NICKNAME"];
    NSFetchRequest *fetchRequest = [self.managedObjectModel
                                    fetchRequestFromTemplateWithName:@"GetBlogAuthor"
                                    substitutionVariables:substitution];
    
    return [self runFetchRequest:fetchRequest];
}

- (void)insertBlog:(JWBlog *)theBlog
{
    // Get the blog author.
    User *author = [[self fetchMatchNickname:theBlog.author] firstObject];
    
    // Create new blog.
    Blog *blog = [NSEntityDescription insertNewObjectForEntityForName:@"Blog"
                                               inManagedObjectContext:self.managedObjectContext];
    blog.author = theBlog.author;
    blog.content = theBlog.content;
    blog.datetime = theBlog.datetime;
    
    // Set the relationship between author and blog.
    blog.user = author;
    author.blogs = [author.blogs setByAddingObject:blog];
    
    // Save persistent.
    [self saveContext];
}

- (void)deleteBlog:(Blog *)blog
{
    // Delete blog.
    [self.managedObjectContext deleteObject:blog];
    
    // Save persistent.
    [self saveContext];
}

- (void)insertUser:(JWUser *)theUser
{
    // Create new user.
    User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                               inManagedObjectContext:self.managedObjectContext];
    user.username = theUser.username;
    user.password = theUser.password;
    user.nickname = theUser.nickname;
    
    // Save persistent.
    [self saveContext];
}

@end
