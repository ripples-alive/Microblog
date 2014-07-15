//
//  JWMyLabel.m
//  Microblog
//
//  Created by Jayvic on 14-7-14.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWMyLabel.h"

@implementation JWMyLabel

@synthesize verticalAlign;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.verticalAlign = VerticalAlignmentMiddle;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setVerticalAlign:(VerticalAlignment)theVerticalAlign
{
    verticalAlign = theVerticalAlign;
    // Redisplay use new given vertical align.
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    
    switch (self.verticalAlign) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2;
            break;
    }
    
    return textRect;
}

- (void)drawTextInRect:(CGRect)rect
{
    CGRect realRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:realRect];
}

@end
