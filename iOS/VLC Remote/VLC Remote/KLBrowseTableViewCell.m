//
//  KLBrowseTableViewCell.m
//  VLC Remote
//
//  Created by Srikanth VM on 31/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLBrowseTableViewCell.h"

@implementation KLBrowseTableViewCell

@synthesize fileName;
@synthesize fileIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
