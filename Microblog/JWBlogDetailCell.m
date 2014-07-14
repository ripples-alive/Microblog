//
//  JWBlogDetailCell.m
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import "JWBlogDetailCell.h"

@implementation JWBlogDetailCell

@synthesize authorLabel;
@synthesize datetimeLabel;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
