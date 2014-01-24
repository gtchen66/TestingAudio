//
//  ViewController.h
//  TestingAudio
//
//  Created by George Chen on 1/24/14.
//  Copyright (c) 2014 George Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioRecorderDelegate, AVAudioPlayerDelegate> {
    AVAudioRecorder *audioRecorder;
    AVAudioPlayer *audioPlayer;
    UIButton *playButton;
    UIButton *recordButton;
    UIButton *stopButton;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIButton *recordButton;
@property (nonatomic, retain) IBOutlet UIButton *stopButton;

-(IBAction) recordAudio;
-(IBAction) playAudio;
-(IBAction) stop;

@end
