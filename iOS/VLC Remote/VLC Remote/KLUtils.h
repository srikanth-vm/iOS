//
//  KLBrowseUtils.h
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum BrowserFileType:NSInteger {
    Directory = 0,
    Video,
    Audio,
    Generic
}BrowserFileType;

@interface KLUtils : NSObject <NSXMLParserDelegate>

@property (copy, nonatomic) void(^completionHandler)(NSArray*);
@property (strong, nonatomic) NSMutableArray *browserData;

+ (id) sharedUtils;
- (void) fileFolderInfoFromXMLData:(NSData*) rawXMLData
          withCompletionHandler:(void(^)(NSArray* fileFolders)) onComplete;
- (BOOL) isMediaFile:(KLFile*) aFile;
- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message;
- (BrowserFileType) fileType:(KLFile*) aFile;

@end
