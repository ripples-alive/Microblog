//
//  JWBlog.h
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWBlog : NSObject

@property (nonatomic, copy) NSString *author;
@property (nonatomic, strong) NSDate *datetime;
@property (nonatomic, copy) NSString *content;

@end
