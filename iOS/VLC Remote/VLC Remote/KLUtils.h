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
@property (copy, nonatomic) void(^statusCompletionHandler)(NSDictionary*);
@property (strong, nonatomic) NSMutableArray *browserData;
@property (strong, nonatomic) NSMutableDictionary *statusInfo;
@property (assign, nonatomic) BOOL isParsingCategory;
@property (assign, nonatomic) BOOL isParsingInfo;
@property (strong, nonatomic) NSMutableString *infoMetaData;
@property (strong, nonatomic) NSString *infoMetaName;

+ (id) sharedUtils;
- (void) fileFolderInfoFromXMLData:(NSData*) rawXMLData
             withCompletionHandler:(void(^)(NSArray* fileFolders)) onComplete;
- (BOOL) isMediaFile:(KLFile*) aFile;
- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message;
- (BrowserFileType) fileType:(KLFile*) aFile;
- (void) statusInfoFromXMLData:(NSData*) rawXMLData
         withCompletionHandler:(void(^)(NSDictionary*)) onComplete;
<<<<<<< HEAD
- (void) updateCurrentDirectory:(NSString*) currentDir;
- (NSString*) lastVisitedDirectory;
- (void) updateRemoteIP:(NSString*) ip;
- (NSString*) remoteIP;
=======
>>>>>>> be8b2cb28dfab38c9c4e1b9e3e2ef4cf95fa0d2d

@end
