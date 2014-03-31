//
//  KLBrowseUtils.m
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLUtils.h"

@implementation KLUtils

#pragma mark - Browser Utils

+ (id)sharedUtils {
    static dispatch_once_t token = 0;
    __strong static id _sharedUtils = nil;
    dispatch_once(&token, ^{
        _sharedUtils = [[self alloc] init];
    });
    return _sharedUtils;
}

- (void)fileFolderInfoFromXMLData:(NSData *)rawXMLData withCompletionHandler:(void (^)(NSArray *))onComplete {
    self.completionHandler = onComplete;
    _browserData = nil;
    self.browserData = [[NSMutableArray alloc] init];
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:rawXMLData];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

- (void) appendToBrowserData:(NSDictionary*) allData {
    KLFile *aFile = [[KLFile alloc] init];
    [aFile setFileType:[allData objectForKey:FILE_TYPE]];
    [aFile setFileName:[allData objectForKey:FILE_NAME]];
    [aFile setFilePath:[allData objectForKey:FILE_PATH]];
    [aFile setFileURI:[allData objectForKey:FILE_URI]];
    [_browserData addObject:aFile];
}

#pragma mark - XML Parser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:CHILD_ELEMENT])
        [self appendToBrowserData:attributeDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:ROOT_ELEMENT])
        [self completeParsing];
}

- (void) completeParsing {
    self.completionHandler(_browserData);
}

#pragma mark - File validation

- (BOOL) isMediaFile:(KLFile*) aFile {
    NSString *fileExtension = [aFile.filePath pathExtension];
    if ([[self mediaExtensions] rangeOfString:fileExtension].location != NSNotFound)
        return YES;
    else
        return NO;
}

- (NSString*) mediaExtensions {
    return @"mp4,avi,divx,mp3,m4a";
}

- (NSString*) videoExtensions {
    return @"mp4,avi,divx,mpeg,3gp";
}

- (NSString*) audioExtensions {
    return @"mp3,m4a,rm,aac";
}

#pragma mark - Alerts

- (void) showAlertWithTitle:(NSString*) title andMessage:(NSString*) message {
    
}

#pragma mark - Misc

- (BrowserFileType)fileType:(KLFile *)aFile {
    NSString *extn = [aFile.filePath pathExtension];
    if ([aFile.fileType isEqualToString:DIR_FILE])
        return Directory;
    else if ([[self videoExtensions] rangeOfString:extn].location != NSNotFound)
        return Video;
    else if ([[self audioExtensions] rangeOfString:extn].location != NSNotFound)
        return Audio;
    else
        return Generic;
}

#pragma mark - 

-(void)dealloc {
    if (_browserData != nil)
        [_browserData removeAllObjects];
    _browserData = nil;
}

@end
