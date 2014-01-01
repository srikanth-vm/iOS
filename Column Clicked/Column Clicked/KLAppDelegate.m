//
//  KLAppDelegate.m
//  Column Clicked
//
//  Created by Srikanth VM on 01/01/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLAppDelegate.h"

@implementation KLAppDelegate

@synthesize tableData;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.tableData = [[NSMutableArray alloc] init];
    for (int idx = 0; idx < 7; idx++) {
        NSString *fooBarString = [NSString stringWithFormat:@"FooBar Row Item-%d", idx + 1];
        [self.tableData addObject:fooBarString];
    }
    [self.KLTable reloadData];
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return [self.tableData count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return [self.tableData objectAtIndex:row];
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    NSInteger columnClickedOn = [[self.KLTable columnClicked] integerValue] + 1;
    NSString *placeHolder = @"You have clicked on Column: %d";
    NSString *alertMessage = [NSString stringWithFormat:placeHolder, (int)columnClickedOn];
    // Do something useful with column index, for now alert user.
    [self showAlertWithMessage:alertMessage];
}

- (void) showAlertWithMessage: (NSString*) message
{
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"KLTableView"];
    [alert setInformativeText:message];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert beginSheetModalForWindow:self.window modalDelegate:nil
                     didEndSelector:nil
                        contextInfo:nil];
}

@end
