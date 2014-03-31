//
//  KLFile.h
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KLFile : NSObject

@property (strong, nonatomic) NSString *fileType;
@property (strong, nonatomic) NSString *fileName;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSString *fileURI;

@end
