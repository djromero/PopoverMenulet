//
//  WOMAppDelegate.h
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class WOMMenulet;
@class WOMController;

@interface WOMAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, strong) WOMController *controller;

@end
