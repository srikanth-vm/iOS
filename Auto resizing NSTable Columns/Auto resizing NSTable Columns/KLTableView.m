//
//  KLTableView.m
//  Auto resizing NSTable Columns
//
//  Created by Srikanth VM on 01/01/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLTableView.h"

@implementation KLTableView

- (id)initWithFrame:(NSRect)frame andDataSourceDelegate:(id)aViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = aViewController;
        self.delegate = aViewController;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
	[super drawRect:dirtyRect];
	
    // Drawing code here.
}

@end
