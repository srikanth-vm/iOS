//
//  KLTableView.h
//  Auto resizing NSTable Columns
//
//  Created by Srikanth VM on 01/01/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KLTableView : NSTableView

- (id)initWithFrame:(NSRect)frame andDataSourceDelegate: (id) delegate;

@end
