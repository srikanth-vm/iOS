//
//  KLBrowseModel.m
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLBrowseModel.h"

@implementation KLBrowseModel

- (id)initWithDelegate:(id) browserDelegate {
    self = [super init];
    if (self) {
        self.delegate = browserDelegate;
    }
    return self;
}

- (void) folderDataForFolderAtPath:(NSString*) fileURI {
    _webClient = [self vlcClient];
    [_webClient browseFolderAtLocation:fileURI withCompletionHandler:^(id fileFolder) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(browserData:)])
            [self.delegate browserData:fileFolder];
    }];
}

- (void) openFileinVLC:(KLFile*) aFile {
    _webClient = [self vlcClient];
    [_webClient playFile:aFile];
}

- (KLWebClient*) vlcClient {
    if (_webClient == nil)
        return [[KLWebClient alloc] init];
    else
        return _webClient;
}

@end
