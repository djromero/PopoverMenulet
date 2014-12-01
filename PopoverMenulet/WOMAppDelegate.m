//
//  WOMAppDelegate.m
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import "WOMAppDelegate.h"
#import "WOMMenulet.h"
#import "WOMController.h"

@implementation WOMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.controller = [[WOMController alloc] init];
}

@end
