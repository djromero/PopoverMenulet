//
//  WOMMenulet.m
//  PopoverMenulet
//
//  Created by Julián Romero on 10/26/11.
//  Copyright (c) 2011 Wuonm Web Services S.L. All rights reserved.
//

#import "WOMMenulet.h"

static void *kActiveChangedKVO = &kActiveChangedKVO;

@implementation WOMMenulet

@synthesize delegate;

- (void)setDelegate:(id<WOMMenuletDelegate>)newDelegate
{
    [(NSObject *)newDelegate addObserver:self forKeyPath:@"active" options:NSKeyValueObservingOptionNew context:kActiveChangedKVO];
    delegate = newDelegate;
}

- (void)drawRect:(NSRect)rect 
{
#if WITHOUT_IMAGE
    rect = CGRectInset(rect, 2, 2);
    if ([self.delegate isActive]) {
        [[NSColor selectedMenuItemColor] set]; /* blueish */
    } else {
        [[NSColor textColor] set]; /* blackish */ 
    }
    NSRectFill(rect);
#else
    NSImage *menuletIcon;
    [[NSColor clearColor] set];   
    if ([self.delegate isActive]) {
        menuletIcon = [NSImage imageNamed:@"Moon_Full.png"];
    } else {
        menuletIcon = [NSImage imageNamed:@"Moon_New.png"];
    }
    [menuletIcon drawInRect:NSInsetRect(rect, 2, 2) fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
#endif
}

- (void)mouseDown:(NSEvent *)event {
    NSLog(@"Mouse down event: %@", event);
    [self.delegate menuletClicked];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kActiveChangedKVO) {
        NSLog(@"%@", change);
        [self setNeedsDisplay:YES];
    }
}

@end
