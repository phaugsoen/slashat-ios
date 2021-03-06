//
//  AppDelegate.m
//  Slashat
//
//  Created by Johan Larsson on 2013-01-01.
//  Copyright (c) 2013 Johan Larsson. All rights reserved.
//

#import "AppDelegate.h"
#import "SlashatAudioControlViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _audioHandler = [[SlashatAudioHandler alloc] init];
    
    [self setCustomNavigationBarAppearance];
    
    //NSError *sessionError = nil;
    //[[AVAudioSession sharedInstance] setDelegate:self];
    //[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    // Changing the default output audio route
    //
    //UInt32 doChangeDefaultRoute = 1;
    //AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
    // Override point for customization after application launch.
    return YES;
}

- (void)setCustomNavigationBarAppearance
{
    UIColor *slashatNavigationBarColor = [UIColor colorWithRed:200/255.0f green:200/255.0f blue:200/255.0f alpha:1];
    [[UINavigationBar appearance] setTintColor:slashatNavigationBarColor];
    
    UIColor *textColor = [UIColor blackColor];
    UIColor *textShadowColor = [UIColor colorWithWhite:255.0 alpha:0.8];
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: textColor,
                          UITextAttributeTextShadowColor: textShadowColor,
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)]
     }];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes: @{
                                UITextAttributeTextColor: textColor,
                          UITextAttributeTextShadowColor: textShadowColor,
                         UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)]}
                                                forState: UIControlStateNormal];
}

- (void)playSlashatAudioEpisode:(SlashatEpisode *)episode
{
    [self.audioHandler setEpisode:episode];
    [self.audioHandler play];
    
    UIStoryboard *iphoneStoryboard = [UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    SlashatAudioControlViewController *audioControlViewController = (SlashatAudioControlViewController*)[iphoneStoryboard instantiateViewControllerWithIdentifier:@"SlashatAudioControl"];
    
    [audioControlViewController setAudioHandler:self.audioHandler];
    [audioControlViewController.view setBounds:CGRectMake(0, 0, 320, 100)];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:audioControlViewController.view];
}

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
