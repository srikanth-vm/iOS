//
//  KLBrowseModel.h
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KLWebClient.h"

@protocol BrowserDelegate <NSObject>

- (void) browserData:(NSArray*) browerDataArray;

@end

@interface KLBrowseModel : NSObject

- (id)initWithDelegate:(id) browserDelegate;
- (void) folderDataForFolderAtPath:(NSString*) fileURI;
- (void) openFileinVLC:(KLFile*) aFile;

@property (strong, nonatomic) KLWebClient *webClient;
@property (strong, nonatomic) id<BrowserDelegate> delegate;

@end
