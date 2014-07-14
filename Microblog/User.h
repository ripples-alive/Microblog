//
//  User.h
//  Microblog
//
//  Created by Jayvic on 14-7-12.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Blog;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString * nickname;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSSet *blogs;

@end

@interface User (CoreDataGeneratedAccessors)

- (void)addBlogsObject:(Blog *)value;
- (void)removeBlogsObject:(Blog *)value;
- (void)addBlogs:(NSSet *)values;
- (void)removeBlogs:(NSSet *)values;

@end
