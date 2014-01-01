//
//  KLAppDelegate.h
//  Column Clicked
//
//  Created by Srikanth VM on 01/01/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KLTableView.h"

@interface KLAppDelegate : NSObject <NSApplicationDelegate> {
    NSMutableArray *tableData;
}

@property (assign) IBOutlet NSWindow *window;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (weak) IBOutlet KLTableView *KLTable;

@end
