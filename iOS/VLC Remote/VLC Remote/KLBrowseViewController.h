//
//  KLBrowseViewController.h
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KLBrowseModel.h"
#import "KLBrowseTableViewCell.h"

@interface KLBrowseViewController : UIViewController <BrowserDelegate>

@property (strong, nonatomic) IBOutlet UITableView *listView;
@property (strong, nonatomic) KLBrowseModel *browseModel;
@property (strong, nonatomic) NSArray *browserData;

@end
