//
//  JWMyLabel.h
//  Microblog
//
//  Created by Jayvic on 14-7-14.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    VerticalAlignmentMiddle = 0,
    VerticalAlignmentTop,
    VerticalAlignmentBottom
} VerticalAlignment;

@interface JWMyLabel : UILabel

@property (nonatomic) VerticalAlignment verticalAlign;

@end
