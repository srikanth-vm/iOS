//
//  KLBrowseViewController.m
//  VLC Remote
//
//  Created by Srikanth VM on 30/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLBrowseViewController.h"

@interface KLBrowseViewController ()

@end

@implementation KLBrowseViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self fileFolderDataAtLocation:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_browserData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    KLBrowseTableViewCell *cell = (KLBrowseTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    KLFile *fileAtRow = [_browserData objectAtIndex:indexPath.row];
    cell.fileName.text = fileAtRow.fileName;
    cell.fileIcon.image = [self iconForFile:fileAtRow];
    return cell;
}

#pragma mark - Table View Delegates

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    KLFile *selectedFile = [_browserData objectAtIndex:indexPath.row];
    if ([selectedFile.fileType isEqualToString:DIR_FILE])
        [self fileFolderDataAtLocation:selectedFile.fileURI];
    else if ([self canPlayFileAtIndex:indexPath.row])
        [self playFileAtIndex:indexPath.row];
}

#pragma mark - Browser Methods

- (KLBrowseModel*) browserModel {
    if (_browseModel == nil)
        return [[KLBrowseModel alloc] initWithDelegate:self];
    else
        return _browseModel;
}

- (void) fileFolderDataAtLocation:(NSString*) location {
//    _webClient = [[KLWebClient alloc] init];
//    [_webClient browseFolderAtLocation:location];
    _browseModel = [self browserModel];
    [_browseModel folderDataForFolderAtPath:location];
}

- (void)browserData:(NSArray *)browerDataArray {
    _browserData = [browerDataArray copy];
    [_listView beginUpdates];
    [_listView reloadSections:[NSIndexSet indexSetWithIndex:0]
             withRowAnimation:UITableViewRowAnimationFade];
    [_listView endUpdates];
}

- (BOOL) canPlayFileAtIndex:(NSInteger) index {
    KLFile *selectedFile = [_browserData objectAtIndex:index];
    if ([[KLUtils sharedUtils] isMediaFile:selectedFile])
        return YES;
    else
        return NO;
}

- (void) playFileAtIndex:(NSInteger) index {
    KLFile *mediaFile = [_browserData objectAtIndex:index];
    _browseModel = [self browseModel];
    [_browseModel openFileinVLC:mediaFile];
}

- (UIImage*) iconForFile:(KLFile*) aFile {
    BrowserFileType fileType = [[KLUtils sharedUtils] fileType:aFile];
    UIImage *fileIcon;
    switch (fileType) {
        case Directory:
            fileIcon = [UIImage imageNamed:@"folder_file"];
            break;
        case Video:
            fileIcon = [UIImage imageNamed:@"video_file"];
            break;
        case Audio:
            fileIcon = [UIImage imageNamed:@"audio_file"];
            break;
        default:
            fileIcon = [UIImage imageNamed:@"generic_file"];
            break;
    }
    return fileIcon;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
