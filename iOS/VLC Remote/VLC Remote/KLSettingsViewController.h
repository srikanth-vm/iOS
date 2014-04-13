//
//  KLSettingsViewController.h
//  VLC Remote
//
//  Created by Srikanth VM on 13/04/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "KLAppDelegate.h"

@interface KLSettingsViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *ipAddress;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)saveIP:(UIButton *)sender;

@end
