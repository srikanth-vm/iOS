//
//  KLAppDelegate.m
//  Auto resizing NSTable Columns
//
//  Created by Srikanth VM on 01/01/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLAppDelegate.h"

@implementation KLAppDelegate

@synthesize aTable;
@synthesize tableData;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self dataForTable]; // Initialize random data for Table
    [self addTableView]; // Add Table View to scroll view container
}

- (void) dataForTable
{
    self.tableData = [[NSMutableArray alloc] init];
    for (int idx = 0; idx < 7; idx++) {
        NSString *fooBarString = [NSString stringWithFormat:@"FooBar Row Item-%d", idx + 1];
        [self.tableData addObject:fooBarString];
    }
}

- (void) addTableView
{
    aTable = [[KLTableView alloc] initWithFrame:self.tableContainer.frame
                          andDataSourceDelegate:self];
    for (NSInteger i = 0; i < 4; i++) {
        NSString *columnIdentfier;
        NSTableColumn *column;
        columnIdentfier = [NSString stringWithFormat:@"Column_%d", (int)i];
        column = [[NSTableColumn alloc] initWithIdentifier:columnIdentfier];
        [column setWidth:100];
        [aTable addTableColumn:column];
    }
    [self.tableContainer setDocumentView:aTable];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.tableData count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self.tableData objectAtIndex:row];
}

@end
