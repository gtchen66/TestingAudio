//
//  ViewController.m
//  TestingAudio
//
//  Created by George Chen on 1/24/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"Hello world");
    
    playButton.enabled = NO;
    stopButton.enabled = NO;
    
    NSArray *dirPaths;
    NSString *docsDir;
    
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    NSString *soundFilePath = [docsDir stringByAppendingPathComponent:@"sound.caf"];
    
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    NSLog(@"The sound file is at %@",soundFilePath);
    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [NSNumber numberWithInt:AVAudioQualityMin], AVEncoderAudioQualityKey,
                                    [NSNumber numberWithInt:16], AVEncoderBitRateKey,
                                    [NSNumber numberWithInt:2], AVNumberOfChannelsKey,
                                    [NSNumber numberWithFloat:44100.0], AVSampleRateKey,
                                    nil];
    
    NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc] initWithURL:soundFileURL settings:recordSettings error:&error];
    
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    } else {
        [audioRecorder prepareToRecord];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) recordAudio {
    if (!audioRecorder.recording) {
        playButton.enabled = NO;
        stopButton.enabled = YES;
        [audioRecorder record];
        NSLog(@"recording...");
        
    } else {
        NSLog(@"already recording");
    }
}

- (void)stop {
    stopButton.enabled = NO;
    playButton.enabled = YES;
    recordButton.enabled = YES;
    
    NSLog(@"stopping");
    if (audioRecorder.recording) {
        [audioRecorder stop];
        NSLog(@" was recording ");
    } else if (audioPlayer.playing) {
        [audioPlayer stop];
        NSLog(@" was playing ");
    }
}

- (void) playAudio {
    if (!audioRecorder.recording) {
        stopButton.enabled = YES;
        recordButton.enabled = NO;
        
        NSError *error;
        
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioRecorder.url error:&error];
        audioPlayer.delegate = self;
        
        if (error) {
            NSLog(@"Error: %@" ,[error localizedDescription]);
        } else {
            [audioPlayer play];
        }
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    recordButton.enabled = YES;
    stopButton.enabled = NO;
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    NSLog(@"Decode Error occurred");
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError *)error {
    NSLog(@"Encode Error occurred");
}


@end




