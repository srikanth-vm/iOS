//
//  KLAppDelegate.h
//  Auto resizing NSTable Columns
//
//  Created by Srikanth VM on 01/01/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KLTableView.h"

@interface KLAppDelegate : NSObject <NSApplicationDelegate> {
    KLTableView *aTable;
    NSMutableArray *tableData;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) KLTableView *aTable;
@property (weak) IBOutlet NSScrollView *tableContainer;
@property (strong, nonatomic) NSMutableArray *tableData;

@end
