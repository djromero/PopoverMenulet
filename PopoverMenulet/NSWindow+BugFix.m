//
//  NSWindow+BugFix.m
//  PopoverMenulet
//
//  Created by Julián Romero on 17/04/14.
//  Copyright (c) 2014 Wuonm Web Services S.L. All rights reserved.
//

#import <objc/objc-class.h>
#import "NSWindow+BugFix.h"
#import "WOMAppDelegate.h"
#import "WOMController.h"

@implementation NSWindow (BugFix)

+ (void)load
{
    method_exchangeImplementations(class_getInstanceMethod(self, @selector(canBecomeKeyWindow)),
                                   class_getInstanceMethod(self, @selector(_canBecomeKeyWindow)));
}

- (BOOL)_canBecomeKeyWindow
{
    if ([self class] == NSClassFromString(@"NSStatusBarWindow")) {
        WOMController * controller = [((WOMAppDelegate*)[NSApp delegate]) controller];
        if([controller isActive]) {
            return YES;
        }
    }
    /* call NSWindow implementation */
    return [self _canBecomeKeyWindow];
}


@end
