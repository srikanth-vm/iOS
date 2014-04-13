//
//  KLSettingsViewController.m
//  VLC Remote
//
//  Created by Srikanth VM on 13/04/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLSettingsViewController.h"

@interface KLSettingsViewController ()

@end

@implementation KLSettingsViewController

@synthesize managedObjectContext = _managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    KLAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [appDelegate managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveIP:(UIButton *)sender {
    Settings *settings = [NSEntityDescription insertNewObjectForEntityForName:@"Settings"
                                                       inManagedObjectContext:_managedObjectContext];
    [settings setIp:[_ipAddress text]];
    NSError *error;
    [_managedObjectContext save:&error];
    [self.view endEditing:YES];
}
@end
