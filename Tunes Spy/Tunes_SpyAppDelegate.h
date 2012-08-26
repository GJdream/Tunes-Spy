//
//  Tunes_SpyAppDelegate.h
//  Tunes Spy
//
//  Created by Daniel deLamare on 4/24/12.
//  Copyright 2012 Columbia Basin College. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Tunes_SpyAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSMenu* statusMenu;
    NSStatusItem* statusItem;
    NSDistributedNotificationCenter* dnc;
    NSTimer* timer;
    int count;
    NSString* BigS;
    int numberOfLetters;
    int pixelWidth;    

}
-(void) cascade;
-(void) scroll;
-(IBAction)quit:(id)sender;
@end
