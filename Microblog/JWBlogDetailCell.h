//
//  JWBlogDetailCell.h
//  Microblog
//
//  Created by Jayvic on 14-7-11.
//  Copyright (c) 2014年 Jayvic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWMyLabel.h"

@interface JWBlogDetailCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *authorLabel;
@property (nonatomic, strong) IBOutlet UILabel *datetimeLabel;
@property (nonatomic, strong) IBOutlet JWMyLabel *contentLabel;

@end
