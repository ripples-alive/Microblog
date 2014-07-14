//
//  JWUser.h
//  Microblog
//
//  Created by Jayvic on 14-7-13.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JWUser : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *nickname;

@end
