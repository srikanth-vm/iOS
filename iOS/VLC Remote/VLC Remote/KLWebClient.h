//
//  KLWebClient.h
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "AFNetworking.h"

@interface KLWebClient : NSObject

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestManager;
@property (copy, nonatomic) void(^completionHandler)(id);

- (void) browseFolderAtLocation:(id)currentFolder withCompletionHandler:(void(^)(id)) onComplete;
- (void) playFile:(KLFile*) aFile;
- (void) albumArtWithCompletionHandler:(void(^)(UIImage* artWork)) onComplete;
- (void) vlcMediaControlCommand:(NSString*) command;
- (NSDictionary*) trackStatusWithCompletionHandler:(void(^)(id)) onComplete;

@end
