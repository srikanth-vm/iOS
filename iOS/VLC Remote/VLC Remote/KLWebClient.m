//
//  KLWebClient.m
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLWebClient.h"

@implementation KLWebClient

#pragma mark - VLC Requests

- (NSURL*) requestURLWithQuery:(NSString*) query {
    NSString *baseURL = @"http://localhost:8080";
    NSString *request = [NSString stringWithFormat:@"%@%@", baseURL, query];
    return [NSURL URLWithString:request];
}

- (void) sendCommand:(NSURL*) command withCompletionHandler:(void(^)(id)) onComplete {
    NSURLRequest *request = [NSURLRequest requestWithURL:command];
    AFHTTPRequestOperation *requestOp = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOp setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (onComplete) {
            onComplete(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (onComplete) {
            onComplete(nil);
        }
    }];
    [requestOp start];
}

#pragma mark - VLC Remote Queries

- (void)browseFolderAtLocation:(id)currentFolder withCompletionHandler:(void(^)(id)) onComplete {
    self.completionHandler = onComplete;
    NSString *folder;
    _isXMLParsingBrowser = YES;
    _isXMLParsingStatus = NO;
    if (currentFolder == nil) {
        folder = [NSString stringWithFormat:@"%@%@", BROWSE, @"file://~"];
    } else {
        folder = [NSString stringWithFormat:@"%@%@", BROWSE, currentFolder];
    }
    [self sendCommand:[self requestURLWithQuery:folder] withCompletionHandler:^(id response) {
        if (response != nil)
            [self parseXMLData:response];
    }];
}

- (void)playFile:(KLFile *)aFile {
    NSString *query = [NSString stringWithFormat:@"%@%@", PLAY_FILE, aFile.fileURI];
    [self sendCommand:[self requestURLWithQuery:query] withCompletionHandler:nil];
}

- (void) albumArtWithCompletionHandler:(void(^)(UIImage*)) onComplete {
    NSString *query = @"/art";
    [self sendCommand:[self requestURLWithQuery:query] withCompletionHandler:^(id response) {
        if (response != nil)
            onComplete([[UIImage alloc] initWithData:response]);
        else
            onComplete([UIImage imageNamed:@"default_artwork"]);
    }];
}

- (void) vlcMediaControlCommand:(NSString*) command {
    [self sendCommand:[self requestURLWithQuery:command] withCompletionHandler:nil];
}

- (NSDictionary *)trackStatusWithCompletionHandler:(void (^)(id))onComplete {
    self.completionHandler = onComplete;
    _isXMLParsingStatus = YES;
    _isXMLParsingBrowser = NO;
    NSDictionary *stats = [[NSDictionary alloc] init];
    [self sendCommand:[self requestURLWithQuery:STATUS] withCompletionHandler:^(id statusData) {
        [self parseStatusXMLData:statusData];
    }];
    return stats;
}

#pragma mark -

- (void) parseXMLData:(NSData*) rawData {
    [[KLUtils sharedUtils] fileFolderInfoFromXMLData:rawData withCompletionHandler:^(NSArray *fileFolders) {
        self.completionHandler(fileFolders);
    }];
}

- (void) parseStatusXMLData:(NSData*) rawData {
    [[KLUtils sharedUtils] statusInfoFromXMLData:rawData withCompletionHandler:^(NSDictionary *statusInfo) {
        self.completionHandler(statusInfo);
    }];
}

@end
