//
//  Remedie_PlayerAppDelegate.m
//  Remedie Player
//
//  Created by Kohichi Aoki on 6/16/09.
//  Copyright 2009 drikin.com. All rights reserved.
//
#include <Carbon/Carbon.h>

#import "Remedie_PlayerAppDelegate.h"
#import "DKAppleScript.h"

@implementation Remedie_PlayerAppDelegate

@synthesize window, fullscreen, webView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [DKAppleScript execute:@"start_remedie"];
  scraper = [[DKScraper alloc] initWithDelegate:self];
  [scraper retain];
  remedieChecker = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
  [remedieChecker retain];

	remoteControl = [[[AppleRemote alloc] initWithDelegate: self] retain];
	[remoteControl startListening:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  [DKAppleScript execute:@"stop_remedie"];
}

- (void) dealloc {
	[remoteControl autorelease];
  [remedieChecker autorelease];
  [scraper autorelease];
	[super dealloc];
}

- (void)test
{
  [scraper test:@"http://127.0.0.1:10010/"];
}

- (IBAction)goHome:(id)sender;
{
  [webView setMainFrameURL:@"http://127.0.0.1:10010/"];
}

- (IBAction)goSubscribe:(id)sender;
{
  [webView setMainFrameURL:@"http://localhost:10010/#subscribe/"]; //http://localhost:10010/#subscribe/{URL}
}

- (IBAction)fullscreen:(id)sender;
{
  if ([fullscreen isVisible]) {
    SetSystemUIMode(kUIModeNormal, 0);
    [fullscreen close];
    [webView removeFromSuperview];
    [webView setFrame:[[window contentView] frame]];
    [webView setFrameOrigin:NSMakePoint(0.0, 0.0)];
    [[[window contentView] animator] addSubview:webView];
  } else {
    SetSystemUIMode(kUIModeAllHidden, kUIOptionAutoShowMenuBar);
    [webView removeFromSuperview];
    CGDirectDisplayID currentDisplayID = CGMainDisplayID();
    CGRect    displayRect;
    displayRect = CGDisplayBounds(currentDisplayID);
    [webView setFrame:NSRectFromCGRect(displayRect)];
    [fullscreen makeKeyAndOrderFront:self];
    [[[fullscreen contentView] animator] addSubview:webView];
  }
}

- (void)remoteUp;
{
  CGSetLocalEventsSuppressionInterval(0.0);
	CGEnableEventStateCombining(false);
	CGPostKeyboardEvent(0, (CGKeyCode)126, true);
	CGPostKeyboardEvent(0, (CGKeyCode)126, false);
	CGEnableEventStateCombining(true);
	CGSetLocalEventsSuppressionInterval(0.25);
}

- (void)remoteDown;
{
  CGSetLocalEventsSuppressionInterval(0.0);
	CGEnableEventStateCombining(false);
	CGPostKeyboardEvent(0, (CGKeyCode)125, true);
	CGPostKeyboardEvent(0, (CGKeyCode)125, false);
	CGEnableEventStateCombining(true);
	CGSetLocalEventsSuppressionInterval(0.25);
}

- (void)remoteLeft;
{
  CGSetLocalEventsSuppressionInterval(0.0);
	CGEnableEventStateCombining(false);
	CGPostKeyboardEvent(0, (CGKeyCode)123, true);
	CGPostKeyboardEvent(0, (CGKeyCode)123, false);
	CGEnableEventStateCombining(true);
	CGSetLocalEventsSuppressionInterval(0.25);
}

- (void)remoteRight;
{
  CGSetLocalEventsSuppressionInterval(0.0);
	CGEnableEventStateCombining(false);
	CGPostKeyboardEvent(0, (CGKeyCode)124, true);
	CGPostKeyboardEvent(0, (CGKeyCode)124, false);
	CGEnableEventStateCombining(true);
	CGSetLocalEventsSuppressionInterval(0.25);
}

- (void)remoteMenu;
{
  CGSetLocalEventsSuppressionInterval(0.0);
	CGEnableEventStateCombining(false);
	CGPostKeyboardEvent(0, (CGKeyCode)53, true);
	CGPostKeyboardEvent(0, (CGKeyCode)53, false);
	CGEnableEventStateCombining(true);
	CGSetLocalEventsSuppressionInterval(0.25);
}

- (void)remotePlay;
{
  CGSetLocalEventsSuppressionInterval(0.0);
	CGEnableEventStateCombining(false);
	CGPostKeyboardEvent(0, (CGKeyCode)36, true);
	CGPostKeyboardEvent(0, (CGKeyCode)36, false);
	CGEnableEventStateCombining(true);
	CGSetLocalEventsSuppressionInterval(0.25);
}

- (void)sendRemoteButtonEvent:(RemoteControlEventIdentifier) event
                  pressedDown:(BOOL) pressedDown
                remoteControl:(RemoteControl*) remoteControl;
{
	NSLog(@"Button %d pressed down %d", event, pressedDown);
  if (pressedDown) {
    switch (event) {
      case kRemoteButtonPlus:
        [self remoteUp];
        break;
      case kRemoteButtonMinus:
        [self remoteDown];
        break;
      case kRemoteButtonMenu:
        [self remoteMenu];
        break;
      case kRemoteButtonPlay:
        [self remotePlay];
        break;
      case kRemoteButtonRight:
        [self remoteRight];
        break;
      case kRemoteButtonLeft:
        [self remoteLeft];
        break;        
      default:
        break;
    }
  }
}

- (void)scrappingDidProceed:(id)data dataTypeName:(NSString*)label;
{
  NSLog(@"%@", label);
  [self goHome:self];
  [remedieChecker invalidate];
  [window makeKeyAndOrderFront:self];
}
@end
