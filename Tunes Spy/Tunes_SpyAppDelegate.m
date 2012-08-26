//
//  Tunes_SpyAppDelegate.m
//  Tunes Spy
//
//  Created by Daniel deLamare on 4/24/12.
//  Copyright 2012 Columbia Basin College. All rights reserved.
//

#import "Tunes_SpyAppDelegate.h"

@implementation Tunes_SpyAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}
-(void) awakeFromNib
{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:0]retain];
    [statusMenu setTitle:@"0"];
    [statusItem setMenu:statusMenu];
    [statusItem setTitle:@""];
    [statusItem setHighlightMode:TRUE];
    dnc = [NSDistributedNotificationCenter defaultCenter];
    [dnc addObserver:self selector:@selector(updateTrackInfo:) name:@"com.apple.iTunes.playerInfo" object:nil];
    
    timer = [[NSTimer alloc] init];
    timer = [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    numberOfLetters = 20;
    pixelWidth  = 150;

}

- (void) updateTrackInfo:(NSNotification *)notification {
    if ([statusItem length] == 0)
    {
        statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:pixelWidth]retain];   
        [statusItem setMenu:statusMenu];
    }
    NSDictionary *information = [notification userInfo];
    count = 0;
    NSString * s = [[NSString alloc] initWithFormat:@""];
    if( [[information objectForKey:@"Player State"] isEqualToString:@"Playing"])
       //Check to make sure something is playing
        {
            if( [information objectForKey:@"Stream Title"] == nil) //For ITunes Radio
                 {
                     //Normal song
                     s = [information valueForKey:@"Name"];
                     s = [s stringByAppendingFormat:@" -- "];
                     s = [s stringByAppendingFormat:@"%@", [information valueForKey:@"Artist"]];
                     BigS = s;
                     
                 }
            else
            {
                //Itunes Radio song
                s = [s stringByAppendingString:[information valueForKey:@"Stream Title"]];
                BigS = s;
            }
        }
    else 
    {
        //When song is paused or ITunes is Quit
        [[NSStatusBar systemStatusBar] removeStatusItem:statusItem];
        statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:0]retain];
    }
    count = 0;
    [BigS retain];
}
-(void) cascade
{
    if (BigS != nil)
    {
        NSString* working;
        count++;
        if ((count+10) < [BigS length])
        {
            NSRange range = NSMakeRange(count, numberOfLetters);
            working = [BigS stringByReplacingCharactersInRange:range withString:@""];
        }
        else
        {
            int var;
            var = (int)([BigS length] - count );
            NSRange range = NSMakeRange(count, var);
            working = [BigS stringByReplacingCharactersInRange:range withString:@""];
            if(var == 0)
            {
                count = 0;
            }
            
        }
        [statusItem setTitle:working];
    }
}
-(void) scroll
{
    if (BigS != nil)
    {
        NSString* working = @"";
        count++;
        if ((count+numberOfLetters) < [BigS length])
        {
            NSRange range = NSMakeRange(count, numberOfLetters);
            working = [BigS substringWithRange:range];
        }
        else
        {
          //  int var=1;
           // var = (int)([BigS length] - count );
            NSRange range = NSMakeRange(count, numberOfLetters);
            while ([working length] < count+numberOfLetters) {
                working = [working stringByAppendingString:BigS];
                working = [working stringByAppendingString:@" -- "];
            }
            working = [working substringWithRange:range];
         //   if(count > [BigS length] + 10)
         //   {
            //count %= [BigS length];
          //  }
            
        }
        [statusItem setTitle:working];
}
}
-(IBAction)quit:(id)sender
{
    [statusItem setLength:0];
    exit(0);
}
@end
