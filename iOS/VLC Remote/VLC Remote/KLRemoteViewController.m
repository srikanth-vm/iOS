//
//  KLRemoteViewController.m
//  VLC Remote
//
//  Created by Srikanth VM on 29/03/14.
//  Copyright (c) 2014 Kantu Labs. All rights reserved.
//

#import "KLRemoteViewController.h"

@interface KLRemoteViewController ()

@end

@implementation KLRemoteViewController

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
    [self refreshArtWork];
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshArtWork];
}

#pragma mark - Remote Interface

- (void) refreshArtWork {
    _webClient = [self vlcClient];
    [_webClient albumArtWithCompletionHandler:^(UIImage *artWork) {
        [_artWork setImage:artWork];
    }];
}

- (IBAction)browseFolderAction:(UIButton *)sender {
}

- (IBAction)remoteButtonTouched:(UIButton *)sender {
    _webClient = [self vlcClient];
    switch ([sender tag]) {
        case 0:
            [_webClient vlcMediaControlCommand:PREV_TRACK];
            break;
        
        case 1:
            [_webClient vlcMediaControlCommand:PLAY_PAUSE_TRACK];
            break;
            
        case 2:
            [_webClient vlcMediaControlCommand:NEXT_TRACK];
            break;
            
        case 3:
            [_webClient vlcMediaControlCommand:STOP_TRACK];
            break;
    }
    [self performSelector:@selector(refreshArtWork) withObject:self afterDelay:3];
}

- (IBAction)volumeControl:(UISlider *)sender {
}

- (KLWebClient*) vlcClient {
    if (_webClient != nil)
        return _webClient;
    else
        return [[KLWebClient alloc] init];
}

#pragma mark - Dealloc

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
