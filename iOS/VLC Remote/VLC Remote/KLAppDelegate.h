//
//  KLAppDelegate.h
//  VLC Remote
//
//  Created by Srikanth VM on 26/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
