//
//  KLAppDelegate.m
//  Collection VIew
//
//  Created by Srikanth VM on 29/12/13.
//  Copyright (c) 2013 Kantu Labs. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "KLAppDelegate.h"
#import "Person.h"

@implementation KLAppDelegate

@synthesize namesArray;
@synthesize arrayController = _arrayController;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    
}

- (void)awakeFromNib {
    [self updateGridWithNamePrefix:@"Sp33d"];
}

- (void) updateGridWithNamePrefix: (NSString*) aName {
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 15; i++) {
        Person *aPerson = [[Person alloc] initWithString:[NSString stringWithFormat:@"%@: %d",aName, i]];
        [tempArray addObject:aPerson];
    }
    [self setNamesArray:tempArray];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"selectionIndexes"]) {
        NSLog(@"Selected Object: %d", (int) [_arrayController selectionIndex]);
    }
}

- (IBAction)removeObs:(NSButton *)sender {
    @try {
        [_arrayController removeObserver:self forKeyPath:@"selectionIndexes"];
    }
    @catch (NSException *exception) {}
    [self updateGridWithNamePrefix:@"Sp33d"];
}

- (IBAction)addObs:(NSButton *)sender {
    [self updateGridWithNamePrefix:@"GodSp33d"];
    [_arrayController setSelectionIndexes:nil];
    [_arrayController addObserver:self forKeyPath:@"selectionIndexes"
                          options:NSKeyValueObservingOptionNew context:nil];
}
@end
