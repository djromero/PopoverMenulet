//
//  WOMController.m
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import "WOMController.h"
#import "WOMAppDelegate.h"
#import "WOMMenulet.h"
#import "WOMPopoverController.h"

@implementation WOMController

@synthesize active;
@synthesize popover;

- (void)_setupPopover
{
    if (!self.popover) {
        self.popover = [[NSPopover alloc] init];
        self.popover.contentViewController = [[WOMPopoverController alloc] init];
        self.popover.contentSize = (CGSize){320, 480};
    }
}

- (void)menuletClicked
{
    NSLog(@"Menulet clicked");
    WOMAppDelegate *appDelegate = [[NSApplication sharedApplication] delegate];
    self.active = ! self.active;
    if (self.active) {
        [self _setupPopover];
        [self.popover showRelativeToRect:[appDelegate.menulet frame] 
                                  ofView:appDelegate.menulet 
                           preferredEdge:NSMinYEdge];
    } else {
        [self.popover performClose:self];
    }
}

@end
