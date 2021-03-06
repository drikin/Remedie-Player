//
//  Remedie_PlayerAppDelegate.h
//  Remedie Player
//
//  Created by Kohichi Aoki on 6/16/09.
//  Copyright 2009 drikin.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "DKScraper.h"
#import "RemoteControl.h"
#import "AppleRemote.h"

@interface Remedie_PlayerAppDelegate : NSObject {
  NSWindow      *window;
  NSWindow      *preferenceWindow;
  NSWindow      *fullscreen;
  WebView       *webView;
  DKScraper     *scraper;
  NSTimer       *remedieChecker;
 	RemoteControl *remoteControl;
}

@property (assign) IBOutlet NSWindow  *window;
@property (assign) IBOutlet NSWindow  *preferenceWindow;
@property (assign) IBOutlet NSWindow  *fullscreen;
@property (assign) IBOutlet WebView   *webView;

- (IBAction)goHome:(id)sender;
- (IBAction)goSubscribe:(id)sender;

- (IBAction)openPreference:(id)sender;
- (IBAction)openRemedieWithBrowser:(id)sender;

- (IBAction)fullscreen:(id)sender;

- (void)registBonjour:(id)theDelegate;

#pragma mark -
#pragma mark RemoteControl
- (void)remoteUp;
- (void)remoteDown;
- (void)remoteLeft;
- (void)remoteRight;
- (void)remoteMenu;
- (void)remotePlay;

#pragma mark -
#pragma mark RemoteControl delegate
- (void)sendRemoteButtonEvent:(RemoteControlEventIdentifier) event
                  pressedDown:(BOOL) pressedDown
                remoteControl:(RemoteControl*) remoteControl;

#pragma mark -
#pragma mark DKScraper delegate
- (void)scrappingDidProceed:(id)data dataTypeName:(NSString*)label;
@end
