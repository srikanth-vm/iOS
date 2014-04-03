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
    self.isParsingCategory = NO;
    self.isParsingInfo = NO;
    _browserData = nil;
    self.browserData = [[NSMutableArray alloc] init];
    _statusInfo = nil;
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

- (void)statusInfoFromXMLData:(NSData *)rawXMLData withCompletionHandler:(void (^)(NSDictionary *))onComplete {
    self.statusCompletionHandler = onComplete;
    self.isParsingCategory = NO;
    self.isParsingInfo = NO;
    _statusInfo = nil;
    _statusInfo = [[NSMutableDictionary alloc] init];
    _browserData = nil;
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:rawXMLData];
    [xmlParser setDelegate:self];
    [xmlParser parse];
}

- (void) appendToStatus:(NSDictionary*) info {
    
}

#pragma mark - XML Parser

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _infoMetaData = nil;
    _infoMetaData = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:CHILD_ELEMENT])
        [self appendToBrowserData:attributeDict];
    else if ([elementName isEqualToString:CATEGORY_ELEMENT] &&
             [[attributeDict objectForKey:@"name"] isEqualToString:@"meta"])
        self.isParsingCategory = YES;
    else if ([elementName isEqualToString:INFO_ELEMENT]) {
        if (self.isParsingCategory)
            self.infoMetaName = [attributeDict objectForKey:@"name"];
        self.isParsingInfo = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (self.isParsingCategory && self.isParsingInfo) {
        [_infoMetaData appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:ROOT_ELEMENT])
        [self completeParsing];
    else if ([elementName isEqualToString:CATEGORY_ELEMENT])
        self.isParsingCategory = NO;
    else if ([elementName isEqualToString:INFO_ELEMENT] &&
             self.isParsingCategory &&
             self.isParsingInfo) {
        self.isParsingInfo = NO;
        [self.statusInfo setObject:_infoMetaData forKey:_infoMetaName];
    }
}

- (void) completeParsing {
    if (_browserData != nil)
        self.completionHandler(_browserData);
    else if (_statusInfo != nil)
        self.statusCompletionHandler(_statusInfo);
        
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

- (NSString *)lastVisitedDirectory {
    NSUserDefaults *sharedUserDefaults = [NSUserDefaults standardUserDefaults];
    return [sharedUserDefaults valueForKey:LAST_VISITED_DIR];
    
}

- (void)updateCurrentDirectory:(NSString *)currentDir {
    NSUserDefaults *sharedUserDefaults = [NSUserDefaults standardUserDefaults];
    [sharedUserDefaults setValue:currentDir forKey:LAST_VISITED_DIR];
    [sharedUserDefaults synchronize];
}

- (NSString *)remoteIP {
    NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    return [sharedDefaults valueForKey:REMOTE_IP];
}

- (void)updateRemoteIP:(NSString *)ip {
    NSUserDefaults *sharedDefaults = [NSUserDefaults standardUserDefaults];
    [sharedDefaults setValue:ip forKey:REMOTE_IP];
    [sharedDefaults synchronize];
}

#pragma mark - 

-(void)dealloc {
    if (_browserData != nil)
        [_browserData removeAllObjects];
    _browserData = nil;
}

@end
