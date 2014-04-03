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
    [self refreshTrackStatus];
}

- (void)viewDidAppear:(BOOL)animated {
    [self refreshArtWork];
    [self refreshTrackStatus];
}

#pragma mark - Remote Interface

- (void) refreshArtWork {
    _webClient = [self vlcClient];
    [_webClient albumArtWithCompletionHandler:^(UIImage *artWork) {
        [_artWork setImage:artWork];
    }];
}

- (void) refreshTrackStatus {
    _webClient = [self vlcClient];
    [_webClient trackStatusWithCompletionHandler:^(id trackInfo) {
        _trackStatusInfo = [trackInfo copy];
        [_trackTitle setText:[_trackStatusInfo objectForKey:TRACK_TITLE]];
        [_album setText:[_trackStatusInfo objectForKey:TRACK_ALBUM]];
        [_artist setText:[_trackStatusInfo objectForKey:TRACK_ARTIST]];
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
    [self performSelector:@selector(refreshArtWork) withObject:self afterDelay:2];
    [self performSelector:@selector(refreshTrackStatus) withObject:self afterDelay:2];
}

- (IBAction)volumeSliderChanged:(UISlider *)sender {
    _webClient = [self vlcClient];
    int val = (int) ceil(sender.value);
    NSNumber *volumeLevel = @(val);
    [_webClient setVolumeTo:[volumeLevel stringValue]];
    [self updateVolumeTextWith:val];
}

#pragma mark -

- (void) updateVolumeTextWith:(int) val {
    float volumeIndicator = ceil((double) ((double) val/ 512.0) * 200.0);
    NSNumber *volumePercentile = @(volumeIndicator);
    [_volumeLevelIndicator setText:[volumePercentile stringValue]];
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
