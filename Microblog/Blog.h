//
//  Blog.h
//  Microblog
//
//  Created by Jayvic on 14-7-12.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Blog : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSDate * datetime;
@property (nonatomic, retain) User *user;

@end
