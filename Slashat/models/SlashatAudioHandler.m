//
//  SlashatAudioHandler.m
//  Slashat
//
//  Created by Johan Larsson on 2013-01-11.
//  Copyright (c) 2013 Johan Larsson. All rights reserved.
//

#import "SlashatAudioHandler.h"
#import "MediaPlayer/MPMoviePlayerController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>

@interface SlashatAudioHandler () {
    MPMoviePlayerController *player;
}

@end

@implementation SlashatAudioHandler

- (id)init
{
    if (self = [super init]) {
        player = [[MPMoviePlayerController alloc] init];
        [[AVAudioSession sharedInstance] setDelegate: self];
        
        NSError *myErr;
        
        if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&myErr]) {
            // Handle the error here.
            NSLog(@"Audio Session error %@, %@", myErr, [myErr userInfo]);
        }
        else{
            // Since there were no errors initializing the session, we'll allow begin receiving remote control events
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        }
    }
    
    return self;
}

- (void)play
{
    [player play];
    
    Class playingInfoCenter = NSClassFromString(@"MPNowPlayingInfoCenter");
    
    if (playingInfoCenter) {
        
        NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
        
        //MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage: [UIImage imagedNamed:@"AlbumArt"]];
        
        [songInfo setObject:[_episode title] forKey:MPMediaItemPropertyTitle];
        //[songInfo setObject:@"Audio Author" forKey:MPMediaItemPropertyArtist];
        //[songInfo setObject:@"Audio Album" forKey:MPMediaItemPropertyAlbumTitle];
        //[songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo];
    }
}

- (void)setEpisode:(SlashatEpisode *)episode
{
    _episode = episode;
    [player setContentURL:[_episode mediaUrl]];
    [player prepareToPlay];
}

- (void)pause
{
    [player pause];
}

@end
